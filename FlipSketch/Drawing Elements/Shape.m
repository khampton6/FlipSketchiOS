//
//  Shape.m
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//
//  Super class of all drawn elements
//

#import "Shape.h"

@implementation Shape

@synthesize x, y, strokeWidth, color, isFilled;

- (id) initWithX: (int)xPos withY: (int)yPos withColor: (UIColor*) shapeColor  isFilled: (BOOL) filled {
  
  self = [super init];
  
  if(self) {
    self.x = x;
    self.y = y;
    self.color = shapeColor;
    self.isFilled = filled;
  }
  return self;
}

- (id) initWithX: (int)xPos withY: (int)yPos withColor: (UIColor*) shapeColor {
  self = [self initWithX:xPos withY:yPos withColor:shapeColor isFilled:YES];
  
  return self;
}

- (void) updatePositionWithX: (int) xPos withYPos: (int) yPos withWidth: (int) shapeWidth withHeight: (int) shapeHeight {
  
}

-(void) draw:(CGContextRef)context {
  
}

- (void) createShapePoints {
  
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Generic Shape"];
}

@end
