//
//  Transformation.m
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Transformation.h"

@implementation Transformation

@synthesize pageNum = _pageNum, newX = _newX, newY = _newY;

-(id) initWithPageNumber:(int) pageNumber withX:(int) x withY:(int) y {
  self = [super init];
  
  _pageNum = pageNumber;
  _newX = x;
  _newY = y;
  
  return self;
}

+ (NSArray*) translateBetweenTransformations: (Transformation*) prev andTransformation:(Transformation* ) current {
  int startIndex = [prev pageNum] + 1;
  
  
  
}


@end
