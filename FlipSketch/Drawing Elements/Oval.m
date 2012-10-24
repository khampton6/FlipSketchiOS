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

@synthesize x, y, width, height, strokeWidth, color, isFilled;

-(id) initWithX:(int) xPos withY:(int)yPos withWidth:(int) shapeWidth withHeight: (int) shapeHeight
      withColor:(UIColor *)shapeColor isFilled:(BOOL) filled {
  
  self = [super initWithX:xPos withY:yPos withColor:shapeColor isFilled:filled];
  if(self) {
    self.width = shapeWidth;
    self.height = shapeHeight;
  }
  
  return self;
}

-(id) initWithX:(int) xPos withY:(int) yPos withColor:(UIColor *)shapeColor isFilled:(BOOL)filled {
  
  self = [self initWithX:xPos withY:yPos withColor:shapeColor isFilled:filled];
  if(self) {
    self.width = 1;
    self.height = 1;
    
    [self createShapePoints];
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

//this function is never called.
-(void) draw:(CGContextRef) context {
  
    NSLog(@"is this ever called?");
    
  int drawX = x;
  int drawY = y;
  int drawWidth = width;
  int drawHeight = height;
  
  if(width < 0) {
    drawX = x-width;
    drawWidth = -1*width;
  }
  
  if(height < 0) {
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
  CGContextAddEllipseInRect(context, rect);
  CGContextStrokePath(context);
  
  for(int i = 0; i < [shapePoints count]; i++) {
    ShapePoint* sp = [shapePoints objectAtIndex:i];
    [sp draw:context];
  }
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Oval"];
}

@end
