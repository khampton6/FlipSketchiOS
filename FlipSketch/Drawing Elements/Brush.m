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
}

-(void) draw:(CGContextRef) context {
  UIColor* uiColor = [rgbColor uiColor];
  [uiColor set];
  [strokePath stroke];
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Brush"];
}

@end
