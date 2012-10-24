//
//  Shape.h
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transformation.h"
#import "ShapePoint.h"

@interface Shape : NSObject {

  NSMutableArray* transformations;
  NSMutableArray* shapePoints;
}

@property int x;
@property int y;
@property int strokeWidth;
@property (nonatomic, retain) UIColor* color;
@property BOOL isFilled;

- (id) initWithX: (int)xPos withY: (int)yPos withColor: (UIColor*) shapeColor isFilled: (BOOL) filled;
- (id) initWithX: (int)xPos withY: (int)yPos withColor: (UIColor*) shapeColor;

- (void)draw:(CGContextRef)context;
- (void) updatePositionWithX: (int) xPos withYPos: (int) yPos withWidth: (int) shapeWidth withHeight: (int) shapeHeight;

@end
