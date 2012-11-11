//
//  DrawOp.h
//  FlipSketch
//
//  Created by Kevin Hampton on 11/11/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawOp : NSObject {
  UIImage* image;
  NSString* tag;
}

@property (nonatomic, retain) UIImage* image;
@property (nonatomic, retain) NSString* tag;

@end
