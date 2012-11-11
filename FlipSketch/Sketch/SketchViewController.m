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

@synthesize selectedColor, selectMode;

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
  selectedStrokeWidth = 5;
  selectedColor = [[RGBColor alloc] initWithR:0 withG:0 withB:0];
  [self switchFilled:self];
  [self setSelectedStrokeWidth:5];
  [previewView setStrokeWidth:selectedStrokeWidth];
  [previewView setNeedsDisplay];
  
  currShape = rect;
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint touchPoint = [touch locationInView:self.view];
  float x = touchPoint.x;
  float y = touchPoint.y;
  
  dragPt = CGPointMake(x, y);
  
  if(selectMode) {
    selectedShape = [self getSelectedShape:touchPoint];
    [selectedShape setIsSelected:YES];
    return;
  }
  
  dragPoints = 1;
  
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
  
  dragPoints++;
  
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint touchPoint = [touch locationInView:self.view];

  float x = touchPoint.x;
  float y = touchPoint.y;
  CGPoint newPt = CGPointMake(x, y);
  
  int vecX = x - dragPt.x;
  int vecY = y - dragPt.y;
  
  dragPt = newPt;
  
  if(selectMode) {
    NSLog(@"Dir vec: %d %d", vecX, vecY);
    [selectedShape moveShapeWithDirX:vecX withDirY:vecY];
  }
  else {
    [selectedShape updateExtraPointWithX:x withY:y];
  }
  
  [sketchView setNeedsDisplay];
}

- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
  
  if(dragPoints <= 2 || selectMode) {
    [sketchView setDraggedShape:nil];
  }
  else {
    [sketchView addDraggedShape];
    selectedShape = nil;
  }
  [sketchView setNeedsDisplay];
}

- (void) touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event {
  [sketchView setDraggedShape:nil];
  [sketchView setNeedsDisplay];
}

-(Shape*) getSelectedShape:(CGPoint) touchPoint {
  NSArray* shapes = [sketchView getShapes];
  
  for(int i = 0; i < [shapes count]; i++) {
    Shape* tempShape = [shapes objectAtIndex:i];
    
    if([tempShape pointTouchesShape:touchPoint]) {
      NSLog(@"found shape");
      return tempShape;
    }
  }
  
  NSLog(@"No Found Shape");
  return nil;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  UIViewController* destination = [segue destinationViewController];
  if([destination isKindOfClass: [ShapeSelectViewController class]]) {
    
    ShapeSelectViewController* ssvc = (ShapeSelectViewController*)destination;
    [ssvc setParentController:self];
  }
  else if([destination isKindOfClass:[ColorChooserViewController class]]) {
    ColorChooserViewController* ccvc = (ColorChooserViewController*)destination;
    [ccvc setStartColor: selectedColor];
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
  
  NSString* strokeStr = [NSString stringWithFormat:@"Stroke: %d", strokeWidth ];
  [strokeWidthLabel setText:strokeStr];
  
  if(selectedShape != nil) {
    [selectedShape setShapeStrokeWidth:selectedStrokeWidth];
    [sketchView setNeedsDisplay];
  }
  
  [previewView setStrokeWidth: selectedStrokeWidth];
  [previewView setNeedsDisplay];
}

-(void) setSelectedColor:(RGBColor *) selColor {
  selectedColor = selColor;
  
  if(selectedColor != nil) {
    [selectedShape setShapeColor:selectedColor];
    [sketchView setNeedsDisplay];
  }
  
  [previewView setSelectedColor:selectedColor];
  [previewView setNeedsDisplay];
}

-(IBAction)switchFilled:(id)sender {
  selectedFilled = [filledSwitch isOn];
  
  if(selectedShape != nil) {
    [selectedShape setIsShapeFilled:selectedFilled];
    [sketchView setNeedsDisplay];
  }
  
  [previewView setIsFilled:selectedFilled];
  [previewView setNeedsDisplay];
}

-(IBAction)updateStrokeWidth:(UIStepper*)sender {
  double value = [sender value];
  [self setSelectedStrokeWidth:(int)value];
}

@end
