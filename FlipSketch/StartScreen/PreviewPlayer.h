//
//  PreviewPlayer.h
//  FlipSketch
//
//  Created by Kevin Hampton on 12/1/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Sketch;

@interface PreviewPlayer : UIView {
  Sketch* sketch;
  
  NSTimer* playerTimer;
  
  int currPage;
  int maxPages;
}

-(void) setSketch:(Sketch*) newSketch;
-(void) tick: (NSTimer*) timer;

@end
