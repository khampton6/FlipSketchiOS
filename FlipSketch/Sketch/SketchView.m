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
      shapes = [[NSMutableArray alloc] init];
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

-(NSArray*) getShapes {
  return shapes;
}

-(void) addDraggedShape {
  [shapes addObject:draggedShape];
  draggedShape = nil;
}

-(void) cancelDraggedShape {
  draggedShape = nil;
}


- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  for(int i = 0; i < [shapes count]; i++) {
    Shape* storedShape = [shapes objectAtIndex:i];
    [storedShape draw:context];
  }
  
  [draggedShape draw:context];
}

@end
