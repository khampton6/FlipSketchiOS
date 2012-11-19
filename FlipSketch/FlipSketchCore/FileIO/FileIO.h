//
//  FileIO.h
//  FlipSketch
//
//  Created by Brandon Headrick on 11/18/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileIO : NSObject

- (void)loadData;
- (void)saveData;
- (NSDictionary *)convertToJson:(NSData *)responseData;

@end
