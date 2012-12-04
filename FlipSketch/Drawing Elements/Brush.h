//
//  Brush.h
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Shape.h"

@interface Brush : Shape {
  UIBezierPath* strokePath;
  NSMutableArray* strokePoints;
}


- (id)initWithX:(int)xPos withY:(int)yPos withColor:(RGBColor *)shapeColor withStrokeWidth:(int) strokeWid;

- (id)initWithStrokePoints:(NSMutableArray *) sPoints withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid withStartingPage:(int) sPage withEndingPage:(int) ePage withTransArray:(NSMutableDictionary *) tArray withShapeType:(int) shapeType;

- (NSDictionary*) getJSONData;

@end
