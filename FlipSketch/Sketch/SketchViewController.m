//
//  SketchViewController.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "SketchViewController.h"
#import "ShapeSelectViewController.h"
#import "Shape.h"

@interface SketchViewController ()

@end

@implementation SketchViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
	// Do any additional setup after loading the view.
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
//  [currShape ]
  
  
  // Retrieve the touch point
  NSLog(@"dragBegan......");
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint touchPoint = [touch locationInView:self.view];
  NSLog(@"Touch x : %f y : %f", touchPoint.x, touchPoint.y);
  
  //[currShape initWithX:touchPoint.x withY:touchPoint.y withColor:[UIColor blackColor] isFilled: NO];
  [currShape setX: touchPoint.x];
  [currShape setY: touchPoint.y];
  [currShape setColor:[UIColor blackColor]];
  [currShape setIsFilled:YES];
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
  
}

- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
  
}

- (void) touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event {
  
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  UIViewController* destination = [segue destinationViewController];
  if([destination isKindOfClass: [ShapeSelectViewController class]]) {
    
    ShapeSelectViewController* ssvc = (ShapeSelectViewController*)destination;
    [ssvc setParentController:self];
  }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void)setCurrShape: (Shape*) aShape{
  currShape = aShape;
  NSLog(@"%@", currShape);
}



@end
