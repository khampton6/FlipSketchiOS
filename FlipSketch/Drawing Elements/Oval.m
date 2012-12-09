//
//  Oval.m
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//
//  Model class for drawing rectangle elements
//

#import "Oval.h"

@implementation Oval

@synthesize width, height;

-(id) initWithX:(int) xPos withY:(int)yPos withWidth:(int) shapeWidth withHeight: (int) shapeHeight
      withColor:(RGBColor *)shapeColor withStrokeWidth:(int) strokeWid isFilled:(BOOL) filled {
  
  self = [super initWithX:xPos withY:yPos withColor:shapeColor withStrokeWidth:strokeWid isFilled:filled];
  if(self) {
    self.width = shapeWidth;
    self.height = shapeHeight;
    [self createShapePoints];
  }
  
  return self;
}

-(id) initWithX:(int) xPos withY:(int) yPos withColor:(RGBColor *)shapeColor withStrokeWidth:(int)strokeWid isFilled:(BOOL)filled {
  
  self = [self initWithX:xPos withY:yPos withWidth: 1 withHeight: 1 withColor:shapeColor withStrokeWidth: strokeWid isFilled:filled];
  if(self) {

  }
  return self;
}

-(id) initWithX: (int)xPos withY: (int)yPos withWidth:(int) shapeWidth withHeight:(int) shapeHeight withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid isFilled: (BOOL) filled withStartingPage:(int) sPage withEndingPage:(int) ePage withTransArray:(NSMutableDictionary *) tArray withShapeType:(int) shapeType{
  
  self = [super initWithX: (int)xPos withY: (int)yPos withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid isFilled: (BOOL) filled withStartingPage:(int) sPage withEndingPage:(int) ePage withTransArray:(NSMutableDictionary *) tArray withShapeType:(int) shapeType];
  
  if(self){
    self.width = shapeWidth;
    self.height = shapeHeight;
  }
  
  return self;
  
}

- (void) createShapePoints {
  ShapePoint* leftPoint = [[ShapePoint alloc] initWithX:x withY:y+height/2 withOwner:self];
  ShapePoint* rightPoint = [[ShapePoint alloc] initWithX:x+width withY:y+height/2 withOwner:self];
  ShapePoint* topPoint = [[ShapePoint alloc] initWithX:x+width/2 withY:y withOwner:self];
  ShapePoint* bottomPoint = [[ShapePoint alloc] initWithX:x+width/2 withY:y+height withOwner:self];
  
  shapePoints = [NSMutableArray arrayWithObjects:leftPoint, rightPoint, topPoint, bottomPoint, nil];
}

- (void) updateShapePoints {
  [self createShapePoints];
}

- (void) updatePositionWithX: (int) xPos withYPos: (int) yPos withWidth: (int) shapeWidth withHeight: (int) shapeHeight {
  x = xPos;
  y = yPos;
  width = shapeWidth;
  height = shapeHeight;
}

- (void) updateExtraPointWithX:(int) xPos withY:(int) yPos {
  width = xPos - x;
  height = yPos - y;
}

- (void) moveShapeWithDirX:(int) vX withDirY:(int) vY withPageNumber:(int) pageNum {
  [super moveShapeWithDirX:vX withDirY:vY withPageNumber:pageNum];
  x += vX;
  y += vY;
}

-(BOOL) pointTouchesShape:(CGPoint) point atPage:(int) pageNum {
  CGPoint pt = [super pointOnPage:pageNum];
  
  return ((point.x >= pt.x) && (point.x <= pt.x+width) && (point.y >= pt.y) && (point.y <= pt.y+height));
}

- (void)drawWithContext:(CGContextRef)context onPage:(int) page {
  
  CGPoint pt = [super pointOnPage:page];
  CGFloat cX = (int)pt.x;
  CGFloat cY = (int)pt.y;
  
  UIColor* uiColor = [rgbColor uiColor];
  
  CGContextSetLineWidth(context, strokeWidth);
  CGRect rect = CGRectMake(cX, cY, width, height);
  
  if(isFilled) {
    CGContextSetFillColorWithColor(context, uiColor.CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    CGContextFillEllipseInRect(context, rect);
  }
  else {
    CGContextSetStrokeColorWithColor(context, uiColor.CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
  }
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Oval"];
}

- (NSDictionary*) getJSONData{
  
  NSDictionary *transData = [[NSDictionary alloc]init];
  
  NSMutableArray *transDataArray;
  
  NSMutableDictionary* theTransDict = [self transformations];
  
  NSArray* keys = [theTransDict allKeys];
  
  NSNumber *x1 = [NSNumber numberWithInt:x];
  NSNumber *y1 = [NSNumber numberWithInt:y];
  
  transDataArray = [[NSMutableArray alloc] init];
  
  for (int i = 0; i < [keys count]; i++) {
    NSNumber* key = [keys objectAtIndex:i];
    Transformation* transValue = [theTransDict objectForKey:key];
    
    NSNumber* xNum = [NSNumber numberWithInt:[transValue newX]];
    NSNumber* yNum = [NSNumber numberWithInt:[transValue newY]];
    NSNumber* pageNum = [NSNumber numberWithInt:[transValue pageNum]];
    
    transData = [NSDictionary dictionaryWithObjectsAndKeys: xNum, @"xPos", yNum, @"yPos", pageNum, @"pageNum", nil];
    [transDataArray addObject:transData];
    
    //if any transformations have occurred, then the initial x and y values need to be corrected
    if(i==0){
      x1 = xNum;
      y1 = yNum;
    }
    
  }
  
  
  /*
   NSNumber *x2 = [NSNumber numberWithInt:20];
   NSNumber *y2 = [NSNumber numberWithInt:21];
   */
  
  float r = [rgbColor getR];
  float g = [rgbColor getG];
  float b = [rgbColor getB];
  
  NSMutableArray* tColor = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:r], [NSNumber numberWithFloat:g], [NSNumber numberWithFloat:b], nil];
  
  NSString *iFilled;
  
  if(isFilled == 0){
    iFilled = @"NO";
  }
  else{
    iFilled = @"YES";
  }
  
  NSNumber *sPage = [NSNumber numberWithInt:_startPage];
  NSNumber *ePage = [NSNumber numberWithInt:_endPage];
  
  NSNumber *sWidth = [NSNumber numberWithInt:strokeWidth];
  
  NSNumber *shapeWidth = [NSNumber numberWithInt:width];
  NSNumber *shapeHeight = [NSNumber numberWithInt:height];
  
  NSDictionary* shapeData = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"shapeType", x1, @"x1", y1, @"y1", tColor, @"color", iFilled, @"isShapeFilled", transDataArray, @"trans", sPage, @"startingPage", ePage, @"endingPage", sWidth, @"strokeWidth", shapeWidth, @"shapeWidth", shapeHeight, @"shapeHeight", nil];
  
  
  return shapeData;
  
}

@end
