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
#import "TimeLineView.h"
#import "TimeLineViewController.h"
#import "Timeline.h"

@interface SketchViewController ()

@end

@implementation SketchViewController

@synthesize selectedColor, selectMode, timeline;

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
  
  selectMode = YES;
  
  selectedStrokeWidth = 5;
  selectedColor = [[RGBColor alloc] initWithR:0 withG:0 withB:0];
  [self switchFilled:self];
  [self setSelectedStrokeWidth:5];
  [previewView setStrokeWidth:selectedStrokeWidth];
  [previewView setNeedsDisplay];
  
  currShape = rect;
  
  [tViewPanel setHidden:YES];
  
  timeline = [[Timeline alloc] init];
  
  UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timelineTap:)];
  [tView addGestureRecognizer:tapGesture];
  
  UIPanGestureRecognizer* drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(timelinePan:)];
  [tView addGestureRecognizer:drag];
  
  UITapGestureRecognizer* addTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPageImage:)];
  [addPageView addGestureRecognizer:addTapGesture];
  
  [tapGesture release];
  [drag release];
  [addTapGesture release];
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint touchPoint = [touch locationInView:self.view];
  float x = touchPoint.x;
  float y = touchPoint.y;
  
  dragPt = CGPointMake(x, y);
  
  dragPoints = 1;
  
  if(selectMode) {
    selectedShape = [self getSelectedShape:touchPoint];
    [selectedShape setIsSelected:YES];
    return;
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
    [selectedShape moveShapeWithDirX:vecX withDirY:vecY];
  }
  else {
    [selectedShape updateExtraPointWithX:x withY:y];
  }
  
  [sketchView setNeedsDisplay];
}

- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
  
  if(dragPoints <= 2 && selectMode) {
    //Toggle timelineview
    [tViewPanel setHidden:![tViewPanel isHidden]];
  }
  
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
      return tempShape;
    }
  }
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

#pragma mark TimeLine

-(IBAction)addPageImage:(UITapGestureRecognizer *)recognizer {
  [timeline addPage];
  [(TimeLineView *)tView setNumLines:[[timeline pages] count]];
  [tView setNeedsDisplay];
  NSLog(@"Pushed");
}

//scroll the timelineArea to specify a page to make active.
-(IBAction)timelinePan:(UIPanGestureRecognizer *)recognizer{
  
  int theActivePage = [self calcActivePage:recognizer];
  
  [timeline setActivePageWithIndex:theActivePage];
  [(TimeLineView *)tView setActivePage: theActivePage];
  
  [tView setNeedsDisplay];
}

//tap on the timeline area to specify a page to make active
-(IBAction)timelineTap:(UITapGestureRecognizer *)recognizer{
  
  //int theActivePage = 0;
  
  int theActivePage = [self calcActivePage:(UIPanGestureRecognizer *)recognizer];
  
  [timeline setActivePageWithIndex:theActivePage];
  [(TimeLineView *)tView setActivePage: theActivePage];
  
  [tView setNeedsDisplay];
  
}

-(int) calcActivePage:(UIGestureRecognizer *)recognizer{
  
  CGRect rect = [tView frame];
  
  //TODO; make this get the size of the view object, not hardcoded width based on the storyboard attribute.
  //CGRect screenRect = [[UIScreen mainScreen] bounds];
  //  CGFloat screenWidth = screenRect.size.width-108;
  CGFloat screenWidth = rect.size.width;//screenRect.size.height-108;
  
  //NSLog(@"numlines is %d",[(TimeLineView *)tView numLines]);
  int numLines = [(TimeLineView *)tView numLines];
  int displacement = screenWidth/numLines;
  //  int absLoc = screenWidth;
  int absLoc = 0;
  int activeIndex = 0;
  int tempActive = -1;
  if(numLines>0){
    for(int i = 0; i<numLines-1; i++){
      tempActive = numLines-2;
      //tempActive = 0;
      absLoc = absLoc + displacement;
      
      CGPoint location = [recognizer locationInView:tView];
      
      if(location.x > absLoc){
        //NSLog(@"trans %f%f",location.x,location.y);
        tempActive = tempActive - i;
        activeIndex = (numLines-1) - tempActive;
        //activeIndex = tempActive  (numLines -1);
        
        //NSLog(@"trans %f  %f  %d",location.x,location.y,tempActive);
      }
    }
  }
  NSLog(@" activeIndex is %d", activeIndex);
  return activeIndex;
}


@end
