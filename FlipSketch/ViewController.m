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

@interface ViewController ()

@end

@implementation ViewController

@synthesize flipSketches;

- (void)viewDidLoad
{
  
  _fIO = [[FileIO alloc] init];
  
  _temp = [[NSMutableArray alloc] init];

  [super viewDidLoad];
  
  NSData *dataToSave = [_fIO addSketchToJSON:@"named" withDescription:@"desc" withID:1 withShapeArray:_temp];
  
  [_fIO saveData:dataToSave];
  
  flipSketches = [_fIO loadData];

  [sketchList loadSketches:flipSketches];
}

-(void) setSketch:(Sketch*) sketch {
  
  if(sketch == nil) {
    NSLog(@"I AM SO NIL");
    return;
  }
  
  NSObject* obj = [sketch sketchName];
  NSString* type = NSStringFromClass([obj class]);
  NSLog(@"Type: %@", type);
  
  NSString* name = [sketch sketchName];
  if(name == NULL || name == nil) {
    NSLog(@"ARRRRGH");
  }
  
  [sketch shapesArray];
  
//  [nameLabel setText:@"Llamas"];
  [sketch setSketchName:@"Llamas"];

  NSLog(@"String: %@", [sketch sketchName]);
  [nameLabel setText:[sketch sketchName]];
  
  NSString* pagesStr = [NSString stringWithFormat:@"%d", [sketch totalPages]];
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
