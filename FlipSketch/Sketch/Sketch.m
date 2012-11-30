//
//  Sketch.m
//  FlipSketch
//
//  Created by Brandon Headrick on 11/27/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "Sketch.h"

@implementation Sketch

@synthesize name, desc, sID, shapesArray;

-(id) initWithName:(NSString *) aName withDesc:(NSString *) aDesc withSID:(int) aSID{
  
  self = [super init];
  
  if(self){
    name = aName;
    desc = aDesc;
    sID = aSID;
  }
  
  return self;
}

-(id) initWithName:(NSString *) aName withDesc:(NSString *) aDesc withSID:(int) aSID withShape:(NSMutableArray *) theShapes{
  
  self = [self initWithName:(NSString *) aName withDesc:(NSString *) aDesc withSID:(int) aSID];
  shapesArray = theShapes;
  
  return self;
}

-(void) addShapeToArray:(Shape *) aShape{
  [shapesArray addObject:aShape];
}

- (NSString *)description
{
  NSLog(@"Hey, it got to sketch description!");
  return [NSString stringWithFormat:@"Sketch"];
}

@end
