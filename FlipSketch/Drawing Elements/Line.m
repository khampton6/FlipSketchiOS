//
//  Line.m
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Line.h"

@implementation Line

@synthesize x, y, color, strokeWidth;

- (id)initWithX:(int)xPos withY:(int)yPos withColor:(UIColor *)shapeColor{
    self = [super initWithX: xPos withY: yPos withColor:(UIColor *)shapeColor];
    
    return self;
}


- (void) createShapePoints {
    ShapePoint* begPoint = [[ShapePoint alloc] initWithX:x withY:y withOwner:self];
    //stubbed; for now the end is the same as the begining.  Finish later.
    ShapePoint* endPoint = [[ShapePoint alloc] initWithX:x withY:y withOwner:self];
    
    shapePoints = [NSMutableArray arrayWithObjects:begPoint, endPoint, nil];
}

- (void) updateShapePoints {
    [self createShapePoints];
}

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
  return [NSString stringWithFormat:@"Line"];
}

@end
