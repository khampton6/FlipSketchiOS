//
//  FlipSketchIO.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "FlipSketchIO.h"

@implementation FlipSketchIO

+(UIImage*) readNewSketchImage {
  return [UIImage imageNamed:@"plus.png"];
}

+(NSArray*) readFlipSketches {
  return [[NSArray alloc] init];
}

@end
