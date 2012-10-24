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

@synthesize width, height, x, y, strokeWidth, isFilled, color;

//why does this initializer care about width & height?  Wouldn't that be done during the drawing, or are you assuming some copy functionality?
-(id) initWithX:(int) xPos withY:(int)yPos withWidth:(int) shapeWidth withHeight: (int) shapeHeight
      withColor:(UIColor *)shapeColor isFilled:(BOOL) filled {
  
  self = [super initWithX:xPos withY:yPos withColor:shapeColor isFilled:filled];
  if(self) {
    self.width = shapeWidth;
    self.height = shapeHeight;
    [self createShapePoints];
  }
  
  return self;
}

-(id) initWithX:(int) xPos withY:(int) yPos withColor:(UIColor *)shapeColor isFilled:(BOOL)filled {
  
  self = [self initWithX:xPos withY:yPos withColor:shapeColor isFilled:filled];
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

//this flow is interesting; please discuss your logic for this with me later.
- (void) updateShapePoints {
  [self createShapePoints];
}

- (void) updatePositionWithX: (int) xPos withYPos: (int) yPos withWidth: (int) shapeWidth withHeight: (int) shapeHeight {
  x = xPos;
  y = yPos;
  width = shapeWidth;
  height = shapeHeight;
}

-(void) draw:(CGContextRef) context {
  
  int drawX = x;
  int drawY = y;
  int drawWidth = width;
  int drawHeight = height;
  
  if(x < 0) {
    drawX = x-width;
    drawWidth = -1*width;
  }
  
  if(y < 0) {
    drawY = y - height;
    drawHeight = -1*height;
  }
  
  
  CGContextSetLineWidth(context, strokeWidth);
  
  if(isFilled) {
    CGContextSetFillColorWithColor(context, color.CGColor);
  }
  else {
    CGContextSetStrokeColorWithColor(context, color.CGColor);
  }
  
  CGRect rect = CGRectMake(drawX, drawY, drawWidth, drawHeight);
  CGContextAddRect(context, rect);
  CGContextStrokePath(context);
  
  for(int i = 0; i < [shapePoints count]; i++) {
    ShapePoint* sp = [shapePoints objectAtIndex:i];
    [sp draw:context];
  }
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Rectangle"];
}

@end
