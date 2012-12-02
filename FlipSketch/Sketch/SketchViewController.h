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
  
  NSMutableArray* startShapes;
  
  int dragPoints;
  
  CGPoint dragPt;
  
  IBOutlet TimeLineView* tView;
  IBOutlet UIView* tViewPanel;
  IBOutlet UIImageView* addPageView;
  
  IBOutlet UILabel* pageLabel;
  
  IBOutlet UIButton* playButton;
  
  int currPage;
  
  NSTimer* playTimer;
  int returnPage;
  BOOL playing;
}

-(IBAction)switchFilled:(id)sender;
-(IBAction)deleteSelectedShape:(id)sender;

-(IBAction) play: (id) sender;
-(void) incrementFrame: (NSTimer*) timer;

-(void)setCurrShape: (ShapeType) type;
-(void)setSelectedStrokeWidth: (int) strokeWidth;
-(IBAction)updateStrokeWidth:(id)sender;

-(Shape*) getSelectedShape:(CGPoint) touchPoint;

-(void) updatePageLabel:(int) newPage;
-(void) goToPage:(int) page;

-(void) setShapes:(NSArray*) shapes;

@property (nonatomic, retain) RGBColor* selectedColor ;
@property BOOL selectMode;

@property (strong, nonatomic) Timeline* timeline;
@end
