//
//  Rectangle.h
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Shape.h"

@interface Rectangle : Shape

@property int width;
@property int height;

-(id) initWithX:(int) xPos withY:(int)yPos withWidth:(int) shapeWidth withHeight: (int) shapeHeight
      withColor:(RGBColor *)shapeColor withStrokeWidth:(int) strokeWidth isFilled:(BOOL) filled;

-(id) initWithX:(int) xPos withY:(int) yPos withColor:(RGBColor *)shapeColor withStrokeWidth:(int) strokeWidth isFilled:(BOOL)filled;

-(id) initWithX: (int)xPos withY: (int)yPos withWidth:(int) shapeWidth withHeight:(int) shapeHeight withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid isFilled: (BOOL) filled withStartingPage:(int) sPage withEndingPage:(int) ePage withTransArray:(NSMutableDictionary *) tArray;

@end
