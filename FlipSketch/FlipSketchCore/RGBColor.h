//
//  RGBColor.h
//  FlipSketch
//
//  Created by Kevin Hampton on 11/3/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGBColor : NSObject {
  float r;
  float g;
  float b;
}

-(id) initWithR:(float) rVal withG:(float) gVal withB:(float) bVal;
-(UIColor*) uiColor;
-(float) getR;
-(float) getB;
-(float) getG;

@end
