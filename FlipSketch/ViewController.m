//
//  ViewController.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/2/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "ViewController.h"
#import "SketchListView.h"
#import "FileIO.h"
#import "Sketch.h"
#import "SketchViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize flipSketches;

- (void)viewDidLoad
{
  [_fIO retain];
  _fIO = [[FileIO alloc] init];
  
  

  [super viewDidLoad];
  
  
  //use below to nullify the sketches array
  //[_fIO saveSketch:nil];
  //[_fIO clearData];
  
  flipSketches = [_fIO loadData];

  [sketchList loadSketches:flipSketches];
}

-(void) setSketch:(Sketch*) sketch {
  
  selectedSketch = sketch;
  
  [nameLabel setText:[sketch sketchName]];
  
  NSString* pagesStr = [NSString stringWithFormat:@"%d", [sketch totalPages]];
  [pagesLabel setText: pagesStr];
  
  [previewTextView setText: [sketch desc]];
  [player setSketch:sketch];
  
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSLog(@"Segue-ing");
  
  SketchViewController* svc = (SketchViewController*)[segue destinationViewController];
  
  //[svc setfIO:_fIO];
  [svc setFIO:_fIO];
  
  if(selectedSketch) {
    
    NSLog(@"Selected Sketch is there!");
    NSArray* shapes = [selectedSketch shapesArray];
    [svc setShapes:shapes];
    [svc loadSketch:selectedSketch];
    /*
    Shape* shape = [shapes objectAtIndex:0];
    [shape setXPos:200];
    [shape setYPos:200];
    */
    NSLog(@"Number shapes: %d", [shapes count]);
     
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

@end
