//
//  ViewController.h
//  FlipSketch
//
//  Created by Kevin Hampton on 10/2/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FileIO.h"
#import "SketchView.h"
#import "Sketch.h"


@class SketchListView;

@interface ViewController : UIViewController {
  IBOutlet SketchListView* sketchList;
  IBOutlet UITextView* previewTextView;
  IBOutlet UILabel* nameLabel;
  IBOutlet UILabel* pagesLabel;
}

@property (nonatomic, retain) NSMutableArray* flipSketches;
@property (nonatomic, retain) FileIO* fIO;
@property (nonatomic, retain) NSMutableArray* temp;
@property (nonatomic, retain) SketchView* sView;

-(void) setSketch:(Sketch*) sketch;

@end
