//
//  RGBColor.m
//  FlipSketch
//
//  Created by Kevin Hampton on 11/3/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "RGBColor.h"

@implementation RGBColor

-(id) initWithR:(float) rVal withG:(float) gVal withB:(float) bVal {
  self = [super init];
  if(self) {
    self->r = rVal;
    self->g = gVal;
    self->b = bVal;
  }
  return self;
}

-(UIColor*) uiColor {
  return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

-(float) getR {
  return r;
}

-(float) getB {
  return b;
}

-(float) getG {
  return g;
}

@end
