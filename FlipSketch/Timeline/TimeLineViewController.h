//
//  TimeLineViewController.h
//  T-Line
//
//  Created by Brandon Headrick on 11/10/12.
//  Copyright (c) 2012 Brandon Headrick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Timeline.h"
#import "TimeLineView.h"

@interface TimeLineViewController : UIViewController
{
  UILabel *statusLabel;
}
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) Timeline* timeline;
@property (strong, nonatomic) TimeLineView* timeView;
@property (strong, nonatomic) UIView *tlView;
@property (strong, nonatomic) UIView *apView;

-(id)init;

-(IBAction) addPageImage:(UIPanGestureRecognizer *)recognizer;
-(IBAction) timelinePan:(UIPanGestureRecognizer *)recognizer;
-(IBAction) timelineTap:(UITapGestureRecognizer *)recognizer;
-(int) calcActivePage:(UIPanGestureRecognizer *)recognizer;

@end
