//
//  ShapePoint.h
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Shape;

@interface ShapePoint : NSObject

@property int x;
@property int y;

@property (retain) Shape* owner;

//this 
-(id) initWithX: (int) xPos withY: (int) yPos withOwner:(Shape*) shapeOwner;
-(void) draw:(CGContextRef) context;

@end
