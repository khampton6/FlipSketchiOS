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
#import "ViewController.h"
#import "Sketch.h"
#import "FileIO.h"

@interface SketchViewController ()

@end

@implementation SketchViewController

@synthesize selectedColor, selectMode, timeline, fIO;

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
  
  playing = false;
  
  currPage = 0;
  
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
  
  [sketchView setShapes:startShapes];
  int pages = [loadedSketch totalPages];
  for(int i = 0; i < pages; i++) {
    [self addPageImage:nil];
  }
  
  [sketchView setNeedsDisplay];
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
    
    if([touch tapCount] == 2) {
      if([selectedShape endPage] == -1) {
        [selectedShape setEndPage:currPage];
      }
      else {
        [selectedShape setEndPage:-1];
      }
      [sketchView setNeedsDisplay];
    }
    
    if(selectedShape != nil) {
      [selectedShape setIsSelected:NO];
    }
    
    return;
  }
  
  switch (currShape) {
    case rect:
      selectedShape = [[Rectangle alloc] initWithX:x withY:y withColor:selectedColor withStrokeWidth:selectedStrokeWidth isFilled:selectedFilled];
      [selectedShape setStartPage:currPage];
      break;
    case oval:
      selectedShape = [[Oval alloc] initWithX:x withY:y withColor:selectedColor withStrokeWidth:selectedStrokeWidth isFilled:selectedFilled];
      [selectedShape setStartPage:currPage];
      break;
    case line:
      selectedShape = [[Line alloc] initWithX:x withY:y withColor:selectedColor withStrokeWidth:selectedStrokeWidth];
      [selectedShape setStartPage:currPage];
      break;
    case brush:
      selectedShape = [[Brush alloc] initWithX:x withY:y withColor:selectedColor withStrokeWidth:selectedStrokeWidth];
      [selectedShape setStartPage:currPage];
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
    [selectedShape moveShapeWithDirX:vecX withDirY:vecY withPageNumber:currPage];
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
    
    BOOL withinPages = [tempShape startPage] <= currPage &&
      (currPage <= [tempShape endPage] || [tempShape endPage] == -1);
    
    if([tempShape pointTouchesShape:touchPoint atPage:currPage] && withinPages) {
      return tempShape;
    }
  }
  
  NSLog(@"Didn't find shape");
  return nil;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  UIViewController* destination = [segue destinationViewController];
  
  
  if([destination isKindOfClass: [ViewController class]]) {
    //Tell it to save here; this is for backing out of the sketch view.
    //[fIO saveSketch:_currSketch];
    [fIO saveSketch:loadedSketch];
    

  }
  else if([destination isKindOfClass: [ShapeSelectViewController class]]) {
    
    ShapeSelectViewController* ssvc = (ShapeSelectViewController*)destination;
    [ssvc setParentController:self];
  }
  else if([destination isKindOfClass:[ColorChooserViewController class]]) {
    ColorChooserViewController* ccvc = (ColorChooserViewController*)destination;
    [ccvc setStartColor: selectedColor];
    [ccvc setParentController:self];
  }
}

-(IBAction)deleteSelectedShape:(id)sender {
  if (selectedShape != nil) {
    [sketchView removeShape:selectedShape];
    selectedShape = nil;
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
  
  if(selectedColor != nil && selectedShape != nil) {
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
  [loadedSketch setTotalPages:([loadedSketch totalPages]+1)];
  [(TimeLineView *)tView setNumLines:[[timeline pages] count]];
  [tView setNeedsDisplay];
}

-(void) updatePageLabel:(int) newPage {
  NSString* pageStr = [NSString stringWithFormat:@"Page: %d", newPage+1];
  [pageLabel setText:pageStr];
}

//scroll the timelineArea to specify a page to make active.
-(IBAction)timelinePan:(UIPanGestureRecognizer *)recognizer{
  
  int theActivePage = [self calcActivePage:recognizer];
  currPage = theActivePage;
  [self updatePageLabel:currPage];
  [sketchView setPage:currPage];
  
  [timeline setActivePageWithIndex:theActivePage];
  [(TimeLineView *)tView setActivePage: theActivePage];
  
  [tView setNeedsDisplay];
}

//tap on the timeline area to specify a page to make active
-(IBAction)timelineTap:(UITapGestureRecognizer *)recognizer{
  
  int theActivePage = [self calcActivePage:(UIPanGestureRecognizer *)recognizer];
  currPage = theActivePage;
  [self updatePageLabel:currPage];
  [sketchView setPage:currPage];
  
  [timeline setActivePageWithIndex:theActivePage];
  [(TimeLineView *)tView setActivePage: theActivePage];
  
  [tView setNeedsDisplay];
}

-(int) calcActivePage:(UIGestureRecognizer *)recognizer{
  
  CGRect rect = [tView frame];

  CGFloat screenWidth = rect.size.width;
  
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

-(void) goToPage:(int) page {

  currPage = page;
  [self updatePageLabel:currPage];
  [sketchView setPage:currPage];
  
  [timeline setActivePageWithIndex:currPage];
  [(TimeLineView *)tView setActivePage: currPage];
  
  [tView setNeedsDisplay];
}

#pragma mark playing transitions.

-(IBAction) play: (id) sender {
  
  if([tView numLines] == 0 || currPage >= [tView numLines]-1) {
    return;
  }

  returnPage = currPage;
  
  if(playing && playTimer != nil) {
    [playTimer invalidate];
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
    [self goToPage:returnPage];
    playing = NO;
    return;
  }

  playTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(incrementFrame:) userInfo:nil repeats:YES];
  [playButton setTitle:@"Stop" forState:UIControlStateNormal];
  playing = YES;
}

-(void) incrementFrame: (NSTimer*) timer {
  NSLog(@"Increment Frame");
  
  //If curr page is on last.
  if(currPage == [tView numLines]-1) {
    [timer invalidate];
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
    [self goToPage:returnPage];
    playing = NO;
    return;
  }
  
  NSLog(@"Going to page: %d", currPage + 1 );
  [self goToPage: currPage+1];
}

-(void) loadSketch:(Sketch*) newSketch {
  [loadedSketch retain];
  loadedSketch = newSketch;
}

-(void) setShapes:(NSMutableArray*) shapes {
  [sketchView setShapes:shapes];
  startShapes = shapes;
  [sketchView setNeedsDisplay];
}

@end
