//
//  FlipSketchPreviewView.h
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sketch.h"

@interface FlipSketchPreviewView : UIView {
  UIImage* imageStub;
  BOOL selected;
}

@property(nonatomic, retain) Sketch* sketch;

+ (id) createNewPreviewView: (CGRect) frame;
+ (id) createNewPreviewView: (CGRect) frame withSketch: (Sketch*) aSketch;
- (void) setPreviewStub: (UIImage*) image withFrame:(CGRect) rect;
- (void) setSelected:(BOOL) isSelected;

@end
