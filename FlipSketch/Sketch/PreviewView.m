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
  CGPoint origin = [self frame].origin;
  
  NSLog(@"Origin: x: %f y: %f", origin.x, origin.y);
  
  int startX = 5;
  int startY = 5;
  int width = size.width - 10;
  int height = size.height - 10;
  
  UIColor* uiColor = [selectedColor uiColor];
  
  CGContextSetLineWidth(context, strokeWidth);
  CGRect drawRect = CGRectMake(startX, startY, width, height);
  
  if(shapeType ==  rect) {
    if(isFilled) {
      CGContextSetFillColorWithColor(context, uiColor.CGColor);
      CGContextAddRect(context, drawRect);
      CGContextStrokePath(context);
      CGContextFillRect(context, drawRect);
    }
    else {
      CGContextSetStrokeColorWithColor(context, uiColor.CGColor);
      CGContextAddRect(context, drawRect);
      CGContextStrokePath(context);
    } 
  }
  else if(shapeType == oval) {
    if(isFilled) {
      CGContextSetFillColorWithColor(context, uiColor.CGColor);
      CGContextAddEllipseInRect(context, drawRect);
      CGContextStrokePath(context);
      CGContextFillEllipseInRect(context, drawRect);
    }
    else {
      CGContextSetStrokeColorWithColor(context, uiColor.CGColor);
      CGContextAddEllipseInRect(context, drawRect);
      CGContextStrokePath(context);
    }
  }
  else if(shapeType ==  line || shapeType == brush) {
    CGContextSetLineWidth(context, strokeWidth);
    CGContextSetStrokeColorWithColor(context, uiColor.CGColor);
    
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddLineToPoint(context, startX + width, startY + height);
    CGContextStrokePath(context);
  }
}


@end
