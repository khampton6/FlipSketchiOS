//
//  Utilities.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (NSDictionary*) getShapeDetails {
  
  NSMutableDictionary* shapes = [[NSMutableDictionary alloc] init];
  
  UIImage* brushImage = [UIImage imageNamed:@"brush.jpg"];
  [shapes setValue:brushImage forKey:@"Brush"];
  
  UIImage* lineImage = [UIImage imageNamed:@"Line.png"];
  [shapes setValue:lineImage forKey:@"Line"];
  
  UIImage* ovalImage = [UIImage imageNamed:@"Oval.jpg"];
  [shapes setValue:ovalImage forKey:@"Oval"];
  
  UIImage* rectImage = [UIImage imageNamed:@"Rectangle.png"];
  [shapes setValue:rectImage forKey:@"Rectangle"];
  
  return shapes;
}

@end
