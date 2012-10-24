//
//  ShapeSelectViewController.h
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rectangle.h"
#import "Oval.h"

@class SketchViewController;

@interface ShapeSelectViewController : UITableViewController {
  NSDictionary* shapeDetails;
  
}

@property (nonatomic, assign) SketchViewController* parentController;


@end
