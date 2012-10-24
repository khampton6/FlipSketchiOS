//
//  SketchView.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "SketchView.h"

@implementation SketchView

@synthesize draggedShape;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      shapes = [[NSMutableArray alloc] init];
      NSLog(@"init here");
    }
    return self;
}


-(id) init {
  self = [super init];
  shapes = [[NSMutableArray alloc] init];
  return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  shapes = [[NSMutableArray alloc]init];
  return self;
}

-(void) addDraggedShape {
  [shapes addObject:draggedShape];
  draggedShape = nil;
}

-(void) cancelDraggedShape {
  draggedShape = nil;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  [draggedShape draw:context];
  
  NSLog(@"Num shapes: %d", [shapes count]);
  for(int i = 0; i < [shapes count]; i++) {
    Shape* storedShape = [shapes objectAtIndex:i];
    [storedShape draw:context];
  }
}

@end
