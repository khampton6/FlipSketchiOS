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
@class Shape;
@class TimeLineView;
@class TimeLineViewController;
@class Timeline;

@interface SketchViewController : UIViewController {
  ShapeType currShape;
  Shape* selectedShape;
  IBOutlet SketchView* sketchView;
  
  IBOutlet PreviewView* previewView;
  
  IBOutlet UISwitch* filledSwitch;
  IBOutlet UILabel* strokeWidthLabel;
  
  int selectedStrokeWidth;
  RGBColor* selectedColor;
  BOOL selectedFilled;
  
  int dragPoints;
  
  CGPoint dragPt;
  
  IBOutlet TimeLineView* tView;
  IBOutlet UIView* tViewPanel;
  IBOutlet UIImageView* addPageView;
}

-(IBAction)switchFilled:(id)sender;

-(void)setCurrShape: (ShapeType) type;
-(void)setSelectedStrokeWidth: (int) strokeWidth;
-(IBAction)updateStrokeWidth:(id)sender;

-(Shape*) getSelectedShape:(CGPoint) touchPoint;

@property (nonatomic, retain) RGBColor* selectedColor ;
@property BOOL selectMode;

@property (strong, nonatomic) Timeline* timeline;
@end
