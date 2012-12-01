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

-(void) print {
  NSLog(@"Page #: %d, X: %d Y: %d", _pageNum, _newX, _newY);
}

+ (NSArray*) translateBetweenTransformations: (Transformation*) prev andTransformation:(Transformation* ) current withList:(NSMutableArray*) array {
  
  int startIndex = [prev pageNum];
  int startX = [prev newX];
  int startY = [prev newY];
  
  int numNewTransitions = [current pageNum] - [prev pageNum] - 1;
  
  int xDiff = [current newX] - startX;
  int yDiff = [current newY] - startY;
  
  for(int i = 1 ; i < numNewTransitions+1; i++) {
    double percentage = i / (numNewTransitions+1.0);
    
    int newX = xDiff*percentage + startX;
    int newY = yDiff*percentage + startY;
    int newPageNumber = i+startIndex;
    
    Transformation* newTrans = [[Transformation alloc] initWithPageNumber:newPageNumber withX:newX withY:newY];
    [array insertObject:newTrans atIndex:newPageNumber];
  }
  return array;
}


@end
