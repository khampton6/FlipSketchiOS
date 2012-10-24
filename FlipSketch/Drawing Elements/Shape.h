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

typedef enum {
  rect = 1,
  oval = 2,
  line = 3,
  brush = 4
} ShapeType;

@interface Shape : NSObject {

  NSMutableArray* transformations;
  NSMutableArray* shapePoints;
  
  int x;
  int y;
  UIColor* color;
  BOOL isFilled;
  int strokeWidth;
}

@property int xPos;
@property int yPos;
@property int shapeStrokeWidth;
@property (nonatomic, retain) UIColor* shapeColor;
@property BOOL isShapeFilled;

- (id) initWithX: (int)xPos withY: (int)yPos withColor: (UIColor*) shapeColor withStrokeWidth:(int) strokeWid isFilled: (BOOL) filled;
- (id) initWithX: (int)xPos withY: (int)yPos withColor: (UIColor*) shapeColor withStrokeWidth:(int) strokeWid;

- (void)draw:(CGContextRef)context;
- (void) updatePositionWithX: (int) xPos withYPos: (int) yPos withWidth: (int) shapeWidth withHeight: (int) shapeHeight;
- (void) updateExtraPointWithX:(int) xPos withY:(int) yPos;
@end
