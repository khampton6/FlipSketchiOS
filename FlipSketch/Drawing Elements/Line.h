//
//  Line.h
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Shape.h"

@interface Line : Shape

@property int x2;
@property int y2;

@property double dirX;
@property double dirY;

- (id)initWithX:(int)xPos withY:(int)yPos withColor:(RGBColor *)shapeColor withStrokeWidth:(int)strokeWid;

-(id) initWithX1: (int)xPos withY1: (int)yPos withX2:(int) xPos2 withY2:(int) yPos2 withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid isFilled: (BOOL) filled withStartingPage:(int) sPage withEndingPage:(int) ePage withTransArray:(NSMutableDictionary *) tArray withShapeType:(int) shapeType;

- (NSDictionary*) getJSONData;


@end
