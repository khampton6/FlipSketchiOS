//
//  SketchView.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "SketchView.h"

@implementation SketchView

@synthesize draggedShape, page;

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

-(int) page {
  return page;
}

-(void) setPage:(int)npage {
  page = npage;
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  for(int i = 0; i < [shapes count]; i++) {
    Shape* storedShape = [shapes objectAtIndex:i];
  
    if( [storedShape startPage] <= page && (page <=[storedShape endPage] || [storedShape endPage] == -1)) {
      [storedShape drawWithContext:context onPage:page];
    }
  }
  
  [draggedShape drawWithContext:context onPage:page];
}

@end
