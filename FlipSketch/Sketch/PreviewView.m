//
//  PreviewView.m
//  FlipSketch
//
//  Created by Kevin Hampton on 11/3/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "PreviewView.h"
#import "Shape.h"
#import "Rectangle.h"
#import "Oval.h"
#import "Line.h"
#import "Brush.h"

@implementation PreviewView

@synthesize selectedColor, isFilled, shapeType, strokeWidth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)dRect
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGSize size = [self frame].size;
  
  int startX = 5;
  int startY = 5;
  int width = size.width - 10;
  int midHeight = startY + size.height / 2 - strokeWidth/2;
  
  UIColor* uiColor = [selectedColor uiColor];
  
  CGContextSetStrokeColorWithColor(context, uiColor.CGColor);
  CGContextSetLineWidth(context, strokeWidth);
  CGContextBeginPath(context);
  
  CGContextMoveToPoint(context, startX, midHeight);
  CGContextAddLineToPoint(context, startX + width, midHeight);
  
  CGContextStrokePath(context);
  
}


@end
