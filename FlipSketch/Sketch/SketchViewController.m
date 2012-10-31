//
//  SketchViewController.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "SketchViewController.h"
#import "ShapeSelectViewController.h"
#import "ColorChooserViewController.h"
#import "Shape.h"
#import "SketchView.h"
#import "Line.h"
#import "Brush.h"

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
  selectedStrokeWidth = 4;
  selectedColor = [UIColor blackColor];
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  
  // Retrieve the touch point
  NSLog(@"dragBegan");
  
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint touchPoint = [touch locationInView:self.view];
  NSLog(@"Touch x : %f y : %f", touchPoint.x, touchPoint.y);
  float x = touchPoint.x;
  float y = touchPoint.y;
  
  if(selectedColor == nil) {
    for(int i = 0; i < 10000; i++) {
      NSLog(@"AGH NIL");
    }
    selectedColor = [UIColor blackColor];
  }
  else{
    NSLog(@"%@",selectedColor);
    NSLog(@"hai");
  }
  
  switch (currShape) {
    case rect:
      selectedShape = [[Rectangle alloc] initWithX:x withY:y withColor:selectedColor withStrokeWidth:selectedStrokeWidth isFilled:selectedFilled];
      break;
    case oval:
      selectedShape = [[Oval alloc] initWithX:x withY:y withColor:selectedColor withStrokeWidth:selectedStrokeWidth isFilled:selectedFilled];
      break;
    case line:
      selectedShape = [[Line alloc] initWithX:x withY:y withColor:selectedColor withStrokeWidth:selectedStrokeWidth];
      break;
    case brush:
      selectedShape = [[Brush alloc] initWithX:x withY:y withColor:selectedColor withStrokeWidth:selectedStrokeWidth];
      break;
  }
  
  [sketchView setDraggedShape:selectedShape];
  [sketchView setNeedsDisplay];
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint touchPoint = [touch locationInView:self.view];

  float x = touchPoint.x;
  float y = touchPoint.y;
  
  [selectedShape updateExtraPointWithX:x withY:y];
  [sketchView setNeedsDisplay];
}

- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
  [sketchView addDraggedShape];
  [sketchView setNeedsDisplay];
}

- (void) touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event {
  [sketchView setDraggedShape:nil];
  [sketchView setNeedsDisplay];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  UIViewController* destination = [segue destinationViewController];
  if([destination isKindOfClass: [ShapeSelectViewController class]]) {
    
    ShapeSelectViewController* ssvc = (ShapeSelectViewController*)destination;
    [ssvc setParentController:self];
  }
  else if([destination isKindOfClass:[ColorChooserViewController class]]) {
    ColorChooserViewController* ccvc = (ColorChooserViewController*)destination;
    [ccvc setParentController:self];
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

-(void)setCurrShape: (ShapeType) type {
  currShape = type;
}

-(void)setSelectedStrokeWidth: (int) strokeWidth {
  selectedStrokeWidth = strokeWidth;
}

-(void)setSelectedColor:(UIColor*) color {
  selectedColor = color;
}

-(IBAction)switchFilled:(id)sender {
  NSLog(@"switch");
  selectedFilled = [filledSwitch isOn];
}

@end
