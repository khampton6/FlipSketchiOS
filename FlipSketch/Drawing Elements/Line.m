//
//  Line.m
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Line.h"

@implementation Line

@synthesize x2,y2, dirX, dirY;

- (id)initWithX:(int)xPos withY:(int)yPos withColor:(RGBColor *)shapeColor withStrokeWidth:(int)strokeWid {
  self = [super initWithX: xPos withY: yPos withColor:shapeColor withStrokeWidth:strokeWid isFilled:YES];
  if(self) {
    x2 = x;
    y2 = y;
    
    dirX = 0;
    dirY = 0;
    
    [self createShapePoints];
  }
  
  return self;
}

//has big 
-(id) initWithX1: (int)xPos withY1: (int)yPos withX2:(int) xPos2 withY2:(int) yPos2 withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid isFilled: (BOOL) filled withStartingPage:(int) sPage withEndingPage:(int) ePage withTransArray:(NSMutableDictionary *) tArray withShapeType:(int) shapeType{
  
  self = [super initWithX: xPos withY: yPos withColor:shapeColor withStrokeWidth:strokeWid isFilled:filled withStartingPage:sPage withEndingPage:ePage withTransArray:tArray withShapeType:(int) shapeType];
  
  if(self) {
    x2 = xPos2;
    y2 = yPos2;
    
    dirX = x - x2;
    dirY = y - y2;
    
    [self createShapePoints];
  }
  
  return self;
  
  
}


- (void) createShapePoints {
    ShapePoint* begPoint = [[ShapePoint alloc] initWithX:x withY:y withOwner:self];
    ShapePoint* endPoint = [[ShapePoint alloc] initWithX:x2 withY:y2 withOwner:self];
    
    shapePoints = [NSMutableArray arrayWithObjects:begPoint, endPoint, nil];
}

- (void) updateShapePoints {
    [self createShapePoints];
}

- (void) updatePositionWithX: (int) xPos withYPos: (int) yPos {
  x = xPos;
  y = yPos;
}

- (void) updateExtraPointWithX:(int) xPos withY:(int) yPos {
  x2 = xPos;
  y2 = yPos;
  
  dirX = x2 - x;
  dirY = y2 - y;
}

- (void) moveShapeWithDirX:(int) vX withDirY:(int) vY withPageNumber:(int) pageNum {
  [super moveShapeWithDirX:vX withDirY:vY withPageNumber:pageNum];
  x += vX;
  y += vY;
  x2 += vX;
  y2 += vY;
}

-(BOOL) pointTouchesShape:(CGPoint) point atPage:(int) pageNum {
  
  CGPoint pt = [super pointOnPage:pageNum];
  
  x = pt.x;
  y = pt.y;
  
  CGPoint a = CGPointMake(x, y);
  CGPoint lineVec = CGPointMake(dirX, dirY);
  double lineDist = sqrt(pow(dirX,2.0) + pow(dirY, 2.0));
  CGPoint unitVec = CGPointMake(lineVec.x/lineDist, lineVec.y/lineDist);
  
  CGPoint aminusp = CGPointMake(a.x - point.x, a.y - point.y);
  double aminuspdpn = unitVec.x*aminusp.x + unitVec.y*aminusp.y;
  
  CGPoint newN = CGPointMake(aminuspdpn*unitVec.x, aminuspdpn*unitVec.y);
  
  CGPoint perpVec = CGPointMake(aminusp.x - newN.x, aminusp.y - newN.y);
  
  double pointDist = sqrt(pow(perpVec.x, 2.0) + pow(perpVec.y, 2.0));
  
  
  int minStartX = (dirX > 0) ? x : x +  dirX;
  int minStartY = (dirY > 0) ? y : y +  dirY;
  
  int maxStartX = minStartX + abs(dirX);
  int maxStartY = minStartY + abs(dirY);
  
  BOOL boundingBox = (point.x >= minStartX) && (point.x <= maxStartX) &&
    (point.y >= minStartY) && (point.y <= maxStartY);
  
  BOOL withinDist = (pointDist < 100);
  
  return boundingBox && withinDist;
}

- (void)drawWithContext:(CGContextRef)context onPage:(int) page {
  
  UIColor* uiColor = [rgbColor uiColor];
  
  CGContextSetLineWidth(context, strokeWidth);
  CGContextSetStrokeColorWithColor(context, uiColor.CGColor);
  
  CGPoint pt = [super pointOnPage:page];
  
  x = pt.x;
  y = pt.y;
  

  CGContextMoveToPoint(context, x, y);
  CGContextAddLineToPoint(context, x + dirX, y + dirY);
  CGContextStrokePath(context);
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Line"];
}

- (NSDictionary*) getJSONData{
  
  NSDictionary *transData = [[NSDictionary alloc]init];
  
  NSMutableArray *transDataArray;
  
  NSMutableDictionary* theTransDict = [self transformations];
  
  NSArray* keys = [theTransDict allKeys];
  
  transDataArray = [[NSMutableArray alloc] init];
  
  NSNumber *xPos1 = [NSNumber numberWithInt:x];
  NSNumber *yPos1 = [NSNumber numberWithInt:y];
  
  NSNumber *xPos2 = [NSNumber numberWithInt:x2];
  NSNumber *yPos2 = [NSNumber numberWithInt:y2];
  
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
      xPos1 = xNum;
      yPos1 = yNum;
    }
    
  }
  
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
  
  //NSLog(@" all stuff is ")
  
  NSDictionary* shapeData = [NSDictionary dictionaryWithObjectsAndKeys:@"2", @"shapeType", xPos1, @"x1", yPos1, @"y1", xPos2, @"x2", yPos2, @"y2", tColor, @"color", iFilled, @"isShapeFilled", transDataArray, @"trans", sPage, @"startingPage", ePage, @"endingPage", sWidth, @"strokeWidth", nil];
  
  
  return shapeData;
  
}

@end
