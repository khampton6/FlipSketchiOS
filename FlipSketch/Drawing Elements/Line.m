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

- (id)initWithX:(int)xPos withY:(int)yPos withColor:(UIColor *)shapeColor withStrokeWidth:(int)strokeWid {
  self = [super initWithX: xPos withY: yPos withColor:(UIColor *)shapeColor withStrokeWidth:strokeWid isFilled:YES];
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

//still figuring out draw; complete later
-(void) draw:(CGContextRef) context {
    
  CGContextSetLineWidth(context, strokeWidth);
  CGContextSetStrokeColorWithColor(context, color.CGColor);

  CGContextMoveToPoint(context, x, y);
  CGContextAddLineToPoint(context, x2, y2);
  CGContextStrokePath(context);
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Line"];
}

@end
