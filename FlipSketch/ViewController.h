//
//  ViewController.h
//  FlipSketch
//
//  Created by Kevin Hampton on 10/2/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "SketchListView.h"
#import "FlipSketch.h"

@class SketchListView;

@interface ViewController : UIViewController {
  IBOutlet SketchListView* sketchList;
  IBOutlet UITextView* previewTextView;
  IBOutlet UILabel* nameLabel;
  IBOutlet UILabel* pagesLabel;
}

@property (nonatomic, retain) NSMutableArray* flipSketches;

-(void) setSketch:(FlipSketch*) sketch;

@end
