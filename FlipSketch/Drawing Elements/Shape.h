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
#import "RGBColor.h"

typedef enum {
  rect = 1,
  oval = 2,
  line = 3,
  brush = 4
} ShapeType;

@interface Shape : NSObject {

  NSMutableDictionary* transformations;
  NSMutableArray* shapePoints;
  
  int x;
  int y;
  UIColor* color;
  RGBColor* rgbColor;
  BOOL isFilled;
  int strokeWidth;
  
  int _startPage;
  int _stopPage;
  
  BOOL selected;
}

@property int xPos;
@property int yPos;
@property int shapeStrokeWidth;
@property (nonatomic, retain) RGBColor* shapeColor;
@property BOOL isShapeFilled;
@property BOOL isSelected;
@property int startPage;
@property int endPage;

- (id) initWithX: (int)xPos withY: (int)yPos withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid isFilled: (BOOL) filled;
- (id) initWithX: (int)xPos withY: (int)yPos withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid;

- (void)drawWithContext:(CGContextRef)context onPage:(int) page;
- (void) updatePositionWithX: (int) xPos withYPos: (int) yPos withWidth: (int) shapeWidth withHeight: (int) shapeHeight;
- (void) updateExtraPointWithX:(int) xPos withY:(int) yPos;
- (void) moveShapeWithDirX:(int) vX withDirY:(int) vY withPageNumber:(int) pageNum;

- (BOOL) pointTouchesShape:(CGPoint) point;
- (CGPoint) pointOnPage:(int) page;

-(Transformation*) findNextTransform:(int) pageNum;
-(Transformation*) findPrevTransform:(int) pageNum;

- (NSMutableDictionary*) transformations;
@end
