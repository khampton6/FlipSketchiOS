//
//  Shape.m
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//
//  Super class of all drawn elements
//

#import "Shape.h"

@implementation Shape

@synthesize xPos = x, yPos = y, shapeStrokeWidth = strokeWidth, isShapeFilled = isFilled, isSelected = selected, shapeColor = rgbColor;

- (id) initWithX: (int)xPos withY: (int)yPos withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid isFilled: (BOOL) filled {
  
  self = [super init];
  
  if(self) {
    x = xPos;
    y = yPos;
    rgbColor = shapeColor;
    isFilled = filled;
    strokeWidth = strokeWid;
    
    selected = NO;
    
    transformations = [[NSMutableDictionary alloc] init];
    Transformation* transform = [[Transformation alloc] initWithPageNumber:0 withX:x withY:y];
    [transformations setObject:transform forKey:[NSNumber numberWithInt:0]];
  }
  return self;
}

- (id) initWithX: (int)xPos withY: (int)yPos withColor: (RGBColor*) shapeColor withStrokeWidth:(int) strokeWid {
  self = [self initWithX:xPos withY:yPos withColor:shapeColor withStrokeWidth:strokeWid isFilled:YES];
  
  return self;
}

- (void) updatePositionWithX: (int) xPos withYPos: (int) yPos withWidth: (int) shapeWidth
                  withHeight: (int) shapeHeight {
  
}

- (void) updateExtraPointWithX:(int) xPos withY:(int) yPos {
  
}

- (void) moveShapeWithDirX:(int) vX withDirY:(int) vY withPageNumber:(int) pageNum {
  Transformation* newTransform = [[Transformation alloc] initWithPageNumber:pageNum withX:vX withY:vY];
  [transformations setObject:newTransform forKey: [NSNumber numberWithInt:pageNum]];
}

- (CGPoint) pointOnPage:(int) page {
  NSNumber* key = [NSNumber numberWithInt:page];
  Transformation* trans = [transformations objectForKey:key];
  
  if(trans != nil) {
    return CGPointMake([trans newX], [trans newY]);
  }
  
  Transformation* prev = [self findPrevTransform:page];
  Transformation* next = [self findPrevTransform:page];
  
  if(next ==  nil) {
    return CGPointMake([prev newX], [prev newY]);
  }
  
  int startX = [prev newX];
  int startY = [prev newY];
  
  int numNewTransitions = [next pageNum] - [prev pageNum] - 1;
  
  int xDiff = [next newX] - startX;
  int yDiff = [next newY] - startY;

  double ratio = (page - [prev pageNum]) / (numNewTransitions+1.0);
  
  int newX = (int)(startX + xDiff*ratio);
  int newY = (int)(startY + yDiff*ratio);
  
  return CGPointMake(newX, newY);
}

-(Transformation*) findNextTransform:(int) pageNum {
  
  if([transformations count] == 0) {
    return nil;
  }
  
  Transformation* closest = nil;
  int minDist = INT_MAX;
  
  NSArray* keys = [transformations allKeys];
  
  for(int i = 0; i < [keys count]; i++) {
    NSNumber* key = [keys objectAtIndex:i];
    Transformation* curr = [transformations objectForKey:key];
    int currPageNum = [curr pageNum];
    if(abs(currPageNum - pageNum) < minDist && currPageNum > pageNum) {
      closest = curr;
      minDist = abs(currPageNum - pageNum);
    }
  }
  return closest;
}

-(Transformation*) findPrevTransform:(int) pageNum {
  
  if([transformations count] == 0) {
    return nil;
  }
  
  Transformation* closest = nil;
  int minDist = INT_MAX;
  
  NSArray* keys = [transformations allKeys];
  
  for(int i = 0; i < [keys count]; i++) {
    NSNumber* key = [keys objectAtIndex:i];
    Transformation* curr = [transformations objectForKey:key];
    int currPageNum = [curr pageNum];
    if(abs(currPageNum - pageNum) < minDist && currPageNum < pageNum) {
      closest = curr;
      minDist = abs(currPageNum - pageNum);
    }
  }
  return closest;
}

-(void) draw:(CGContextRef)context {
  
}

- (void) createShapePoints {
  
}

-(BOOL) pointTouchesShape:(CGPoint) point {
  return NO;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Generic Shape"];
}

@end
