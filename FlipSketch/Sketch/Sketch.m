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
    shapesArray = [[NSMutableArray alloc] init];
  }
  
  return self;
}
/*
-(id) initWithName:(NSString *) aName withDesc:(NSString *) aDesc withSID:(int) aSID withShape:(NSMutableArray *) theShapes{
  
  self = [self initWithName:(NSString *) aName withDesc:(NSString *) aDesc withSID:(int) aSID];
  shapesArray = theShapes;
  
  return self;
}
 */

-(void) addShapeToArray:(Shape *) aShape{
  //NSLog(@"addingToArray");
  //NSLog(@" shapeArrSize is %d", shapesArray.count);
  [shapesArray addObject:aShape];
  //NSLog(@" shapeArrSize is %d", shapesArray.count);
}

- (NSString *)description
{
  NSLog(@"Sketch");
  //NSLog(@" shapeArrSize is %d", shapesArray.count);
  return [NSString stringWithFormat:@"Sketch"];
}

-(NSMutableArray*) testGetShapes{
  return shapesArray;
}

@end
