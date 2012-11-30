//
//  Sketch.h
//  FlipSketch
//
//  Created by Brandon Headrick on 11/27/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"

@interface Sketch : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *desc;
@property int sID;
@property (strong, nonatomic) NSMutableArray *shapesArray;

-(id) initWithName:(NSString *) aName withDesc:(NSString *) aDesc withSID:(int) aSID;

//-(id) initWithName:(NSString *) aName withDesc:(NSString *) aDesc withSID:(int) aSID withShapes:(NSMutableArray *) theShapes;

-(void) addShapeToArray:(Shape *) aShape;

@end
