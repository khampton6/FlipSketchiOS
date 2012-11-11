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

@synthesize xPos = x, yPos = y, shapeStrokeWidth = strokeWidth, shapeColor = color, isShapeFilled = isFilled, isSelected = selected;

- (id) initWithX: (int)xPos withY: (int)yPos withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid isFilled: (BOOL) filled {
  
  self = [super init];
  
  if(self) {
    x = xPos;
    y = yPos;
    rgbColor = shapeColor;
    isFilled = filled;
    strokeWidth = strokeWid;
    
    selected = NO;
  }
  return self;
}

- (id) initWithX: (int)xPos withY: (int)yPos withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid {
  self = [self initWithX:xPos withY:yPos withColor:shapeColor withStrokeWidth:strokeWid isFilled:YES];
  
  return self;
}

- (void) updatePositionWithX: (int) xPos withYPos: (int) yPos withWidth: (int) shapeWidth
                  withHeight: (int) shapeHeight {
  
}

- (void) updateExtraPointWithX:(int) xPos withY:(int) yPos {
  
}

- (void) moveShapeWithDirX:(int) vX withDirY:(int) vY {
  
}

-(void) draw:(CGContextRef)context {
  
}

- (void) createShapePoints {
  
}

-(BOOL) pointTouchesShape:(CGPoint) point {
  return NO;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Generic Shape"];
}

@end
