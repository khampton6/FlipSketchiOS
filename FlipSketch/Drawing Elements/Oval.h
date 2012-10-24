//
//  Oval.h
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Shape.h"

@interface Oval : Shape

@property int width;
@property int height;

-(id) initWithX:(int) xPos withY:(int)yPos withWidth:(int) shapeWidth withHeight: (int) shapeHeight
      withColor:(UIColor *)shapeColor isFilled:(BOOL) filled;

-(id) initWithX:(int) xPos withY:(int) yPos withColor:(UIColor *)shapeColor isFilled:(BOOL)filled;

@end
