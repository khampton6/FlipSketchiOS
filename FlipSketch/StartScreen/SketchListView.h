//
//  SketchListView.h
//  FlipSketch
//
//  Created by Kevin Hampton on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ViewController.h"

@class ViewController;

@interface SketchListView : UIScrollView {
  NSMutableArray* sketchPreviews;
  int selected;
  IBOutlet ViewController* parentController;
}

-(void) loadSketches:(NSArray *)slist;

@end
