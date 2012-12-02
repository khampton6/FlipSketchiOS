//
//  PreviewPlayer.m
//  FlipSketch
//
//  Created by Kevin Hampton on 12/1/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "PreviewPlayer.h"
#import "Sketch.h"

@implementation PreviewPlayer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      for(;true;)
      NSLog(@"THIS IS CALLED");
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  return self;
}

-(void) setSketch:(Sketch*) newSketch {
  
  [playerTimer invalidate];
  playerTimer = nil;
  
  sketch = newSketch;
  currPage = 0;
  maxPages = [sketch totalPages];
  if(maxPages == 0) {
    [self setBackgroundColor:[UIColor darkGrayColor]];
    return;
  }
  
  [self setBackgroundColor:[UIColor whiteColor]];
  playerTimer = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

-(void) tick: (NSTimer*) timer {
  [self setNeedsDisplay];
  currPage = (currPage + 1) % maxPages;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  
  NSArray* shapes = [sketch shapesArray];
  
  CGContextRef context = UIGraphicsGetCurrentContext();

  for(int i = 0; i < [shapes count]; i++) {
    Shape* storedShape = [shapes objectAtIndex:i];
    
    if( [storedShape startPage] <= currPage && (currPage <=[storedShape endPage] || [storedShape endPage] == -1)) {
      [storedShape drawWithContext:context onPage:currPage];
    }
  }
}


@end
