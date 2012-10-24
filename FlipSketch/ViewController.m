//
//  ViewController.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/2/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "ViewController.h"
#import "SketchListView.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize flipSketches;

- (void)viewDidLoad
{
  [super viewDidLoad];
  flipSketches = [[NSMutableArray alloc] init];
  [sketchList loadSketches:flipSketches];
}

-(void) setSketch:(FlipSketch*) sketch {
    
  [nameLabel setText:[sketch name]];
  
  NSString* pagesStr = [NSString stringWithFormat:@"%d", [sketch numPages]];
  [pagesLabel setText: pagesStr];
  
  [previewTextView setText: [sketch description]];
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
