//
//  ColorChooserViewController.h
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SketchViewController;

@interface ColorChooserViewController : UIViewController {
  IBOutlet UISlider* rSlider;
  IBOutlet UISlider* gSlider;
  IBOutlet UISlider* bSlider;
  
  IBOutlet UILabel* rLabel;
  IBOutlet UILabel* gLabel;
  IBOutlet UILabel* bLabel;
  
  double r, g, b;
}

@property (nonatomic, retain) SketchViewController* parentController;

@end
