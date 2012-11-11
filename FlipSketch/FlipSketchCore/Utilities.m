//
//  Utilities.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Utilities.h"
#import "DrawOp.h"

@implementation Utilities

+ (NSMutableArray*) getShapeDetails {
  
  //NSMutableDictionary* shapes = [[NSMutableDictionary alloc] init];
  
  DrawOp* selectOp = [[DrawOp alloc] init];
  [selectOp setImage:[UIImage imageNamed:@"select.png"]];
  [selectOp setTag:@"Select"];

  DrawOp* rectOp = [[DrawOp alloc] init];
  [rectOp setImage:[UIImage imageNamed:@"Rectangle.png"]];
  [rectOp setTag:@"Rectangle"];
  
  DrawOp* ovalOp = [[DrawOp alloc] init];
  [ovalOp setImage:[UIImage imageNamed:@"Oval.jpg"]];
  [ovalOp setTag:@"Oval"];
  
  DrawOp* lineOp = [[DrawOp alloc] init];
  [lineOp setImage:[UIImage imageNamed:@"Line.png"]];
  [lineOp setTag:@"Line"];
  
  DrawOp* brushOp = [[DrawOp alloc] init];
  [brushOp setImage:[UIImage imageNamed:@"brush.jpg"]];
  [brushOp setTag:@"Brush"];
  
  NSMutableArray* shapes = [[NSMutableArray alloc] init];
  [shapes addObject:selectOp];
  [shapes addObject:rectOp];
  [shapes addObject:ovalOp];
  [shapes addObject:lineOp];
  [shapes addObject:brushOp];
    
  return shapes;
}

@end
