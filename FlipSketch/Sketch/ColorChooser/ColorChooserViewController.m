//
//  ColorChooserViewController.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "ColorChooserViewController.h"

@interface ColorChooserViewController ()

@end

@implementation ColorChooserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)rSliderChanged:(id)sender {
  
  r = [rSlider value] / 255.0;
  
  NSString* rstr = [NSString stringWithFormat:@"R: %d", (int)(255*r)];
  [rLabel setText:rstr];
  
  [self updateColor];
}

-(IBAction)gSliderChanged:(id)sender {
  
  g = [gSlider value] / 255.0;
  
  NSString* gstr = [NSString stringWithFormat:@"G: %d", (int)(255*g)];
  [gLabel setText:gstr];
  
  [self updateColor];
}

-(IBAction)bSliderChanged:(id)sender {
  
  b = [bSlider value] / 255.0;
  
  NSString* bstr = [NSString stringWithFormat:@"B: %d", (int)(255*b)];
  [bLabel setText:bstr];
  
  [self updateColor];
}

-(void) updateColor {
  UIColor* color = [UIColor colorWithRed:r green:g blue:b alpha:1];
  [self.view setBackgroundColor:color];
  
  double Y = 255 * 0.2126 * r + 255 * 0.7152 * g + 255 * 0.0722 * b;
  
  NSLog(@"Y: %f", Y);
  
  if( Y < 125 ) {
    rLabel.textColor = [UIColor whiteColor];
    gLabel.textColor = [UIColor whiteColor];
    bLabel.textColor = [UIColor whiteColor];
  }
  else {
      rLabel.textColor = [UIColor blackColor];
      gLabel.textColor = [UIColor blackColor];
      bLabel.textColor = [UIColor blackColor];
  }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
