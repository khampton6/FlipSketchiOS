//
//  Brush.m
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Brush.h"

@implementation Brush

@synthesize x, y, color, strokeWidth;

- (id)initWithX:(int)xPos withY:(int)yPos withColor:(UIColor *)shapeColor{
    self = [super initWithX: xPos withY: yPos withColor:(UIColor *)shapeColor];
    
    return self;
}

//this really needs an array of shape points that is constantly added during the update (for every touch-drag event).
//TODO; on new location from touch-drag, add a new shapepoint to the array.
- (void) createShapePoints {
    ShapePoint* begPoint = [[ShapePoint alloc] initWithX:x withY:y withOwner:self];
    
    shapePoints = [NSMutableArray arrayWithObjects:begPoint, nil];
}

- (void) updateShapePoints {
    [self createShapePoints];
}

//probably don't need this, but I'm unclear as to how exactly you (kevin) plan to use this method in the other model classes.
- (void) updatePositionWithX: (int) xPos withYPos: (int) yPos{
    x = xPos;
    y = yPos;
}

//still figuring out draw; complete later
-(void) draw:(CGContextRef) context {
    
    //    int drawX = x;
    //    int drawY = y;
    //
    //    if(x < 0) {
    //        drawX = x-width;
    //        drawWidth = -1*width;
    //    }
    //
    //    if(y < 0) {
    //        drawY = y - height;
    //        drawHeight = -1*height;
    //    }
    //
    //
    //    CGContextSetLineWidth(context, strokeWidth);
    //
    //
    //    CGRect rect = CGRectMake(drawX, drawY, drawWidth, drawHeight);
    //    CGContextAddRect(context, rect);
    //    CGContextStrokePath(context);
    //
    //    for(int i = 0; i < [shapePoints count]; i++) {
    //        ShapePoint* sp = [shapePoints objectAtIndex:i];
    //        [sp draw:context];
    //    }
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Brush"];
}

@end
