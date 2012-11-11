//
//  PreviewView.h
//  FlipSketch
//
//  Created by Kevin Hampton on 11/3/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Shape.h"

@interface PreviewView : UIView {
  Shape* drawShape;
}

@property ShapeType shapeType;
@property (nonatomic, retain) RGBColor* selectedColor;
@property BOOL isFilled;
@property int strokeWidth;

@end
