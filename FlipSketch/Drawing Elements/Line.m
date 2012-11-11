//
//  Line.m
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Line.h"

@implementation Line

@synthesize x2,y2;

- (id)initWithX:(int)xPos withY:(int)yPos withColor:(RGBColor *)shapeColor withStrokeWidth:(int)strokeWid {
  self = [super initWithX: xPos withY: yPos withColor:shapeColor withStrokeWidth:strokeWid isFilled:YES];
  if(self) {
    x2 = x;
    y2 = y;
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
}

- (void) moveShapeWithDirX:(int) vX withDirY:(int) vY {
  x += vX;
  y += vY;
  x2 += vX;
  y2 += vY;
}

-(BOOL) pointTouchesShape:(CGPoint) point {
  
  CGPoint a = CGPointMake(x, y);
  CGPoint lineVec = CGPointMake(x-x2, y-y2);
  double lineDist = sqrt(pow(x-x2,2.0) + pow(y-y2, 2.0));
  CGPoint unitVec = CGPointMake(lineVec.x/lineDist, lineVec.y/lineDist);
  
  CGPoint aminusp = CGPointMake(a.x - point.x, a.y - point.y);
  double aminuspdpn = unitVec.x*aminusp.x + unitVec.y*aminusp.y;
  
  CGPoint newN = CGPointMake(aminuspdpn*unitVec.x, aminuspdpn*unitVec.y);
  
  CGPoint perpVec = CGPointMake(aminusp.x - newN.x, aminusp.y - newN.y);
  
  double pointDist = sqrt(pow(perpVec.x, 2.0) + pow(perpVec.y, 2.0));
  
  NSLog(@"Point dist: %f", pointDist);
  
  BOOL boundingBox = (point.x >= x) && (point.x <= x2) &&
    (point.y >= y) && (point.y <= y2);
  
  BOOL withinDist = (pointDist < 100);
  
  return boundingBox && withinDist;
}

-(void) draw:(CGContextRef) context {
  
  UIColor* uiColor = [rgbColor uiColor];
  
  CGContextSetLineWidth(context, strokeWidth);
  CGContextSetStrokeColorWithColor(context, uiColor.CGColor);

  CGContextMoveToPoint(context, x, y);
  CGContextAddLineToPoint(context, x2, y2);
  CGContextStrokePath(context);
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Line"];
}

@end
