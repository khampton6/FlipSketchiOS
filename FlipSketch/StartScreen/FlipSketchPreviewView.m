//
//  FlipSketchPreviewView.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "FlipSketchPreviewView.h"
#import "FlipSketchIO.h"
#import "Sketch.h"
#import "Rectangle.h"

@implementation FlipSketchPreviewView

@synthesize sketch;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      [self setBackgroundColor:[UIColor colorWithRed:(116/255.0) green:(125/255.0) blue:(132/255.0) alpha:1]];
    }
    return self;
}

+ (id) createNewPreviewView: (CGRect) frame {
  
  FlipSketchPreviewView* preview = [[FlipSketchPreviewView alloc] initWithFrame:frame];
  
  //FlipSketch* sketch = [[FlipSketch alloc] init];
  Sketch* sketch = [[Sketch alloc]init];
  [sketch setTotalPages:11];
  RGBColor* shapeColor = [[RGBColor alloc] initWithR:255 withG:0 withB:0];
  Rectangle* rect = [[Rectangle alloc] initWithX:10 withY:10 withColor:shapeColor withStrokeWidth:5 isFilled:YES];
  [rect setHeight:10];
  [rect setWidth:50];
  [rect setStartPage:0];
  [rect moveShapeWithDirX:200 withDirY:200 withPageNumber:10];
  NSMutableArray* shapes = [NSMutableArray arrayWithObject:rect];
  [sketch setShapesArray:shapes];
  
  [sketch setSketchName:@"New Sketch"];
  [sketch setDesc:@"Press the Start Sketching button below to start sketching!"];
  [sketch setTotalPages:0];
  
  [preview setSketch:sketch];
  
  UIImage* image = [FlipSketchIO readNewSketchImage];
  
  CGSize size = frame.size;
  CGFloat width = size.width;
  CGFloat height = size.height;
  
  CGSize imgSize = image.size;
  CGFloat imgWidth = imgSize.width;
  CGFloat imgHeight = imgSize.height;
  
  CGFloat newX = (width - imgWidth) / 2;
  CGFloat newY = (height - imgHeight) / 2;
  

  CGRect centeredRect = CGRectMake(newX, newY, imgWidth, imgHeight);
  
  [preview setPreviewStub:image withFrame:centeredRect];
  
  return preview;
}

+ (id) createNewPreviewView: (CGRect) frame withSketch: (Sketch*) aSketch {
  
  FlipSketchPreviewView* preview = [[FlipSketchPreviewView alloc] initWithFrame:frame];

  [preview setSketch:aSketch];
  
  CGSize size = frame.size;
  CGFloat width = size.width;
  CGFloat height = size.height;
  
  
  NSString* text = [aSketch sketchName];
  UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
  [label setText:text];
  [label setTextAlignment: NSTextAlignmentCenter];
  UIColor* color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
  [label setBackgroundColor:color];
  [label setTextColor:[UIColor whiteColor]];
  [preview addSubview:label];
  
  return preview;
}

- (void) setPreviewStub: (UIImage*) image withFrame:(CGRect) rect {
  imageStub = image;

  UIImageView* stubView = [[UIImageView alloc] initWithImage:imageStub];
  [stubView setFrame:rect];
  [self addSubview:stubView];
}

- (void) setSelected:(BOOL) isSelected {
  selected = isSelected;
  [self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  if(!selected) {
    CGContextSetLineWidth(context, 4);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
  }
  else {
    CGContextSetLineWidth(context, 6);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
  }
  
  CGContextAddRect(context, self.bounds);
  CGContextStrokePath(context);
}

@end
