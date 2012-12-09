//
//  Sketch.h
//  FlipSketch
//
//  Created by Brandon Headrick on 11/27/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"

@interface Sketch : NSObject {
  NSString* _sketchName;
}

@property (retain, nonatomic) NSString *desc;
@property int sID;
@property int totalPages;
@property (retain, nonatomic) NSMutableArray *shapesArray;

-(void) setSketchName:(NSString*) sName;
-(NSString*) sketchName;

-(id) initWithName:(NSString *) aName withDesc:(NSString *) aDesc withSID:(int) aSID withTotalPages:(int) totalPages;

//-(id) initWithName:(NSString *) aName withDesc:(NSString *) aDesc withSID:(int) aSID withShapes:(NSMutableArray *) theShapes;

-(void) addShapeToArray:(Shape *) aShape;

-(NSMutableArray*) testGetShapes;

@end
