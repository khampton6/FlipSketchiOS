//
//  FileIO.h
//  FlipSketch
//
//  Created by Brandon Headrick on 11/18/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sketch.h"

@interface FileIO : NSObject

@property (retain, nonatomic) NSError *writeError;
@property (retain, nonatomic) NSData *jsonData;
@property (retain, nonatomic) NSMutableArray *allSketches;
@property (retain, nonatomic) NSDictionary *allJsons;
@property int currSID;

- (NSMutableArray *)loadData;
- (void)saveData:(NSData*)data;
//- (NSDictionary *)convertToJson:(NSData *)responseData;

//- (void)createFullJSON:(NSMutableArray*)sketchesArray;

- (NSData*)addSketchToJSON:(NSString *)name withDescription: (NSString*)desc withID: (int)theID withShapeArray: (NSMutableArray*)shapesArr;

- (void)saveSketch:(Sketch*) aSketch;

- (void)clearData;
//-create

@end
