//
//  ColorChooserViewController.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "ColorChooserViewController.h"
#import "SketchViewController.h"
#import "RGBColor.h"

@interface ColorChooserViewController ()

@end

@implementation ColorChooserViewController

@synthesize parentController;

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
  
  RGBColor* color = [[RGBColor alloc] initWithR:r withG:g withB:b];
  
  [self.view setBackgroundColor:[color uiColor]];
  
  double Y = 255 * 0.2126 * r + 255 * 0.7152 * g + 255 * 0.0722 * b;
  
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
  [parentController setSelectedColor:color];
}

-(void) setStartColor: (RGBColor*) startColor {
  r = [startColor getR];
  g = [startColor getG];
  b = [startColor getB];
  
  int rSliderVal = (int)(r*255);
  int bSliderVal = (int)(b*255);
  int gSliderVal = (int)(g*255);
  
  [rSlider setValue:rSliderVal];
  [bSlider setValue:bSliderVal];
  [gSlider setValue:gSliderVal];

  rSlider.value = rSliderVal;
  
  [self updateColor];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  rSlider.value = (int)(r*255);
  gSlider.value = (int)(g*255);
  bSlider.value = (int)(b*255);
  
  NSString* bstr = [NSString stringWithFormat:@"B: %d", (int)(255*b)];
  [bLabel setText:bstr];
  
  NSString* rstr = [NSString stringWithFormat:@"R: %d", (int)(255*r)];
  [rLabel setText:rstr];
  
  NSString* gstr = [NSString stringWithFormat:@"B: %d", (int)(255*g)];
  [gLabel setText:gstr];
  
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
