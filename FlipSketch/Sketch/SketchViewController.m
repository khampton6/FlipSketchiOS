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
#import "PreviewView.h"
#import "Shape.h"
#import "SketchView.h"
#import "Line.h"
#import "Brush.h"

@interface SketchViewController ()

@end

@implementation SketchViewController

@synthesize selectedColor;

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
  selectedColor = [[RGBColor alloc] initWithR:0 withG:0 withB:0];
  [self switchFilled:self];
  [previewView setNeedsDisplay];
  
  currShape = rect;
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint touchPoint = [touch locationInView:self.view];
  float x = touchPoint.x;
  float y = touchPoint.y;
  
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void)setCurrShape: (ShapeType) type {
  currShape = type;
  [previewView setShapeType:type];
  [previewView setNeedsDisplay];
}

-(void)setSelectedStrokeWidth: (int) strokeWidth {
  selectedStrokeWidth = strokeWidth;
  [previewView setStrokeWidth: selectedStrokeWidth];
  [previewView setNeedsDisplay];
}

-(void) setSelectedColor:(RGBColor *) selColor {
  selectedColor = selColor;
  [previewView setSelectedColor:selectedColor];
  [previewView setNeedsDisplay];
}

-(IBAction)switchFilled:(id)sender {
  selectedFilled = [filledSwitch isOn];
  [previewView setIsFilled:selectedFilled];
  [previewView setNeedsDisplay];
}

@end
