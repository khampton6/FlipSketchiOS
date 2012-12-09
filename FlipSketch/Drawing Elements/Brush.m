//
//  Brush.m
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Brush.h"

@implementation Brush

- (id)initWithX:(int)xPos withY:(int)yPos withColor:(RGBColor *)shapeColor withStrokeWidth:(int) strokeWid {
  self = [super initWithX: xPos withY: yPos withColor: shapeColor withStrokeWidth:strokeWid];
  if(self) {
    strokePath = [[UIBezierPath alloc] init];
    strokePath.lineWidth = strokeWidth;
    [strokePath moveToPoint:CGPointMake(x, y)];
    
    strokePoints = [[NSMutableArray alloc] init];
    NSValue* pointWrapper = [NSValue valueWithCGPoint: CGPointMake(xPos, yPos)];
    [strokePoints addObject:pointWrapper];
  }
  return self;
}

-(id) initWithStrokePoints:(NSMutableArray *) sPoints withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid withStartingPage:(int) sPage withEndingPage:(int) ePage withTransArray:(NSMutableDictionary *) tArray withShapeType:(int) shapeType{
  
  self = [super initWithX: [[sPoints objectAtIndex:0]intValue] withY: [[sPoints objectAtIndex:1] intValue] withColor:shapeColor withStrokeWidth:strokeWid isFilled:YES withStartingPage:sPage withEndingPage:ePage withTransArray:tArray withShapeType:(int) shapeType];

  if(self) {
    
    CGPoint firstPt = CGPointMake(x, y);
    strokePath = [[UIBezierPath alloc] init];
    strokePath.lineWidth = strokeWidth;
    [strokePath moveToPoint:firstPt];
    
    strokePoints = [[NSMutableArray alloc] init];
    
    NSValue* firstPtValue = [NSValue valueWithCGPoint:firstPt];
    [strokePoints addObject:firstPtValue];
    
    for(int i = 0; i < [sPoints count]; i+=2) {
          
      float xread = [[sPoints objectAtIndex:i] floatValue];
      float yread = [[sPoints objectAtIndex:i+1] floatValue];
          
      CGPoint pt = CGPointMake(xread, yread);
      NSValue* valueWrapper = [NSValue valueWithCGPoint:pt];
      
      [strokePath addLineToPoint:pt];
      [strokePoints addObject:valueWrapper];
    }
  
  }
  return self;
  
}

- (void) createShapePoints {
    ShapePoint* begPoint = [[ShapePoint alloc] initWithX:x withY:y withOwner:self];
    
    shapePoints = [NSMutableArray arrayWithObjects:begPoint, nil];
}

- (void) updateShapePoints {
    [self createShapePoints];
}

- (void) updatePositionWithX: (int) xPos withYPos: (int) yPos{
    x = xPos;
    y = yPos;
}

- (void) updateExtraPointWithX:(int) xPos withY:(int) yPos {
  [strokePath addLineToPoint:CGPointMake(xPos, yPos)];
  NSValue* pointWrapper = [NSValue valueWithCGPoint: CGPointMake(xPos, yPos)];
  [strokePoints addObject:pointWrapper];
}

- (void) moveShapeWithDirX:(int) vX withDirY:(int) vY withPageNumber:(int) pageNum {
  [super moveShapeWithDirX:vX withDirY:vY withPageNumber:pageNum];
  
  NSMutableArray* newStrPts = [[NSMutableArray alloc] init];
  
  for(int i = 0; i < [strokePoints count]; i++) {
    CGPoint strokePt = [[strokePoints objectAtIndex:i] CGPointValue];
    strokePt.x += vX;
    strokePt.y += vY;
    [newStrPts addObject:[NSValue valueWithCGPoint:strokePt]];
  }
  shapePoints = newStrPts;
  
  CGAffineTransform transform = CGAffineTransformMakeTranslation(vX, vY);
  [strokePath applyTransform:transform];
}

-(BOOL) pointTouchesShape:(CGPoint) point atPage:(int) pageNum {

  CGPoint prevPt = [[strokePoints objectAtIndex:0] CGPointValue];
  
  for(int i = 1; i < [strokePoints count]; i++) {
    CGPoint currPt = [[strokePoints objectAtIndex:i] CGPointValue];
    
    BOOL segmentTouched = [self pointTouchesSegment:point withPoint1:currPt withPoint2:prevPt];
    if(segmentTouched) {
      NSLog(@"Segment touche");
      return YES;
    }
    
    prevPt = currPt;
  }
  
  NSLog(@"Didn't find brush");
  return NO;
}

-(BOOL) pointTouchesSegment:(CGPoint) touchPoint withPoint1:(CGPoint) point1 withPoint2:(CGPoint) point2 {
    
  CGPoint a = CGPointMake(point1.x, point1.y);
  CGPoint lineVec = CGPointMake(point1.x-point2.x, point1.y-point2.y);
  double lineDist = sqrt(pow(point1.x-point2.x,2.0) + pow(point1.y-point2.y, 2.0));
  CGPoint unitVec = CGPointMake(lineVec.x/lineDist, lineVec.y/lineDist);
    
  CGPoint aminusp = CGPointMake(a.x - touchPoint.x, a.y - touchPoint.y);
  double aminuspdpn = unitVec.x*aminusp.x + unitVec.y*aminusp.y;
    
  CGPoint newN = CGPointMake(aminuspdpn*unitVec.x, aminuspdpn*unitVec.y);
    
  CGPoint perpVec = CGPointMake(aminusp.x - newN.x, aminusp.y - newN.y);
    
  double pointDist = sqrt(pow(perpVec.x, 2.0) + pow(perpVec.y, 2.0));
  
  double p1Dist = sqrt(pow(point1.x - touchPoint.x, 2.0) + pow(point1.y - touchPoint.y, 2.0));
  double p2Dist = sqrt(pow(point2.x - touchPoint.x, 2.0) + pow(point2.y - touchPoint.y, 2.0));
    
  BOOL withinDist = (pointDist < 200) && (p1Dist < 100 || p2Dist < 100);
    
  return withinDist;
}

- (void)drawWithContext:(CGContextRef)context onPage:(int) page {
  
  UIColor* uiColor = [rgbColor uiColor];
  [uiColor set];
  [strokePath stroke];
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Brush"];
}

- (NSDictionary*) getJSONData{
  
  NSDictionary *transData = [[NSDictionary alloc]init];
  
  NSMutableArray *transDataArray;
  
  NSMutableDictionary* theTransDict = [self transformations];
  
  NSArray* keys = [theTransDict allKeys];
  
  transDataArray = [[NSMutableArray alloc] init];
  
  for (int i = 0; i < [keys count]; i++) {
    NSNumber* key = [keys objectAtIndex:i];
    Transformation* transValue = [theTransDict objectForKey:key];
    
    NSNumber* xNum = [NSNumber numberWithInt:[transValue newX]];
    NSNumber* yNum = [NSNumber numberWithInt:[transValue newY]];
    NSNumber* pageNum = [NSNumber numberWithInt:[transValue pageNum]];
    
    transData = [NSDictionary dictionaryWithObjectsAndKeys: xNum, @"xPos", yNum, @"yPos", pageNum, @"pageNum", nil];
    
    [transDataArray addObject:transData];
  }
  
  
  
  NSDictionary* transDatab = [NSDictionary dictionaryWithObjectsAndKeys:@"2", @"xPos", @"4", @"yPos", @"0", @"pageNum", @"NO", @"isKeyFrame", nil];
  NSMutableArray* transDataArrayb = [[NSMutableArray alloc] initWithObjects:transDatab, nil];
  
  NSNumber *x1 = [NSNumber numberWithInt:x];
  NSNumber *y1 = [NSNumber numberWithInt:y];
  
  
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
  
  NSMutableArray *sPoints = [[NSMutableArray alloc]init];
  
  for(int i = 0; i<strokePoints.count; i++){
    
    NSValue* tempPoint = [strokePoints objectAtIndex:i];
    CGPoint point = [tempPoint CGPointValue];
    
    NSNumber* xOfPoint = [NSNumber numberWithInt:point.x];
    NSNumber* yOfPoint = [NSNumber numberWithInt:point.y];
    
    [sPoints addObject: xOfPoint];
    [sPoints addObject: yOfPoint];
  }
  
  NSDictionary* shapeData = [NSDictionary dictionaryWithObjectsAndKeys:@"3", @"shapeType", x1, @"x1", y1, @"y1", tColor, @"color", iFilled, @"isShapeFilled", transDataArray, @"trans", sPage, @"startingPage", ePage, @"endingPage", sWidth, @"strokeWidth", sPoints, @"strokePoints", nil];
  
  
  return shapeData;
  
}

@end
