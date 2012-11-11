//
//  ShapeSelectViewController.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "ShapeSelectViewController.h"
#import "SketchViewController.h"
#import "Utilities.h"
#import "DrawOp.h"
#import "Shape.h"
#import "Rectangle.h"
#import "Oval.h"
#import "Line.h"
#import "Brush.h"

@interface ShapeSelectViewController ()

@end

@implementation ShapeSelectViewController

@synthesize parentController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  shapeDetails = [Utilities getShapeDetails];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [shapeDetails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  int index = [indexPath row];
  
  DrawOp* op = [shapeDetails objectAtIndex:index];
  
  static NSString *CellIdentifier = @"ShapeCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
  cell.textLabel.text = [op tag];
  cell.textLabel.textAlignment = kCTRightTextAlignment;
  cell.imageView.image = [op image];
  
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  DrawOp* shapeOp = [shapeDetails objectAtIndex:[indexPath row]];
  NSString* shapeString = [shapeOp tag];
  
  [parentController setSelectMode:NO];
  
  if([shapeString isEqualToString:@"Rectangle"]) {
    [parentController setCurrShape: rect];
  }
  else if([shapeString isEqualToString:@"Oval"]) {
    [parentController setCurrShape: oval];
  }
  else if([shapeString isEqualToString:@"Line"]) {
    [parentController setCurrShape: line];
  }
  else if([shapeString isEqualToString:@"Brush"]) {
    [parentController setCurrShape: brush];
  }
  else if([shapeString isEqualToString:@"Select"])
  {
    [parentController setSelectMode:YES];
  }
  
  [self removeFromParentViewController];
}



@end
