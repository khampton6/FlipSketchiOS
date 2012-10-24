//
//  FlipSketchPreviewView.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "FlipSketchPreviewView.h"
#import "FlipSketchIO.h"

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
  
  FlipSketch* sketch = [[FlipSketch alloc] init];
  [sketch setName:@"New Sketch"];
  [sketch setDescription:@"Press the Start Sketching button below to start sketching!"];
  [sketch setNumPages:0];
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
