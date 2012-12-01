//
//  Transformation.h
//  FlipSketch
//
//  Created by Brandon Headrick on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//
//  Class that holds the final positions of objects at particular timestamps.
//
#import <Foundation/Foundation.h>

@interface Transformation : NSObject {
  int _pageNum;
  
  int _newX;
  int _newY;
  
  BOOL _isKeyFrame;
}

@property int pageNum;
@property int newX;
@property int newY;

-(id) initWithPageNumber:(int) pageNumber withX:(int) x withY:(int) y;
+ (NSArray*) translateBetweenTransformations: (Transformation*) prev andTransformation:(Transformation* ) current withList:(NSMutableArray*) array;
-(void) print;



@end
