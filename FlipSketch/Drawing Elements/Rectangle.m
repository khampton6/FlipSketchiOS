//
//  Rectangle.m
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//
//  Model class for drawing rectangle elements
//

#import "Rectangle.h"

@implementation Rectangle

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

-(id) initWithX:(int) xPos withY:(int) yPos withColor:(RGBColor *)sCol withStrokeWidth:(int) strokeWid isFilled:(BOOL)filled {
  
  self = [super initWithX:xPos withY:yPos withColor:sCol withStrokeWidth: strokeWid isFilled:filled];
  if(self) {
    self.width = 1;
    self.height = 1;
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

- (void) moveShapeWithDirX:(int) vX withDirY:(int) vY {
  x += vX;
  y += vY;
}

-(BOOL) pointTouchesShape:(CGPoint) point {
  return ((point.x >= x) && (point.x <= x+width) && (point.y >= y) && (point.y <= y+height));
}

-(void) draw:(CGContextRef) context {
  
  UIColor* uiColor = [rgbColor uiColor];
  
  CGContextSetLineWidth(context, strokeWidth);
  CGRect rect = CGRectMake(x, y, width, height);
  
  if(isFilled) {
    CGContextSetFillColorWithColor(context, uiColor.CGColor);
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
    CGContextFillRect(context, rect);
  }
  else {
    CGContextSetStrokeColorWithColor(context, uiColor.CGColor);
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
  }
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Rectangle"];
}

@end
