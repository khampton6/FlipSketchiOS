//
//  SketchViewController.h
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shape.h"

@class SketchView;
@class RGBColor;
@class PreviewView;

@interface SketchViewController : UIViewController {
  ShapeType currShape;
  Shape* selectedShape;
  IBOutlet SketchView* sketchView;
  
  IBOutlet PreviewView* previewView;
  
  IBOutlet UISwitch* filledSwitch;
  
  int selectedStrokeWidth;
  RGBColor* selectedColor;
  BOOL selectedFilled;
}

-(IBAction)switchFilled:(id)sender;

-(void)setCurrShape: (ShapeType) type;
-(void)setSelectedStrokeWidth: (int) strokeWidth;

@property (nonatomic, retain) RGBColor* selectedColor ;

@end
