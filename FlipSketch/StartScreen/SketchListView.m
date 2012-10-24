//
//  SketchListView.m
//  FlipSketch
//
//  Created by Kevin Hampton on 10/6/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "SketchListView.h"
#import "FlipSketchIO.h"
#import "FlipSketchPreviewView.h"

@implementation SketchListView

const int SKETCHNODEWIDTH = 200;
const int SKETCHNODEHEIGHT = 100;

const int SKETCHNODESPACINGY = 40;
const int SKETCHNODESPACINGX = 40;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) loadSketches:(NSMutableArray *)slist {
  sketchPreviews = [[NSMutableArray alloc] initWithCapacity:[slist count]+1];
  
  //Need to resize view
  int selfWidth = SKETCHNODEWIDTH * [slist count] + SKETCHNODESPACINGX;
  int selfHeight = SKETCHNODEHEIGHT;
  [self setContentSize:CGSizeMake(selfWidth, selfHeight)];
  
  //Add represent tiles
  int startX = 10;
  int startY = 10;

  CGRect frame = CGRectMake(startX, startY, SKETCHNODEWIDTH, SKETCHNODEHEIGHT);
  FlipSketchPreviewView* addNew = [FlipSketchPreviewView createNewPreviewView: frame];
  [self addSubview:addNew];
  
  FlipSketch* addNewSketch = [addNew sketch];
  [sketchPreviews addObject: addNew];
  
  [parentController setSketch: addNewSketch];
  [addNew setSelected: YES];
  selected = 0;

  for(int i = 1; i < [slist count]; i++) {
    frame = CGRectMake(startX+i*(SKETCHNODEWIDTH+SKETCHNODESPACINGX), startY, SKETCHNODEWIDTH, SKETCHNODEHEIGHT);
    addNew = [FlipSketchPreviewView createNewPreviewView: frame];
    [sketchPreviews addObject: addNew];
    [self addSubview:addNew];
  }
  
  UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
  tapRecognizer.numberOfTapsRequired = 1;
  [self addGestureRecognizer: tapRecognizer];
  
}

-(void) handleTapGesture:(UIGestureRecognizer*) gesture {
  
  CGPoint touchPoint = [gesture locationInView:self];
  
  int found = selected;
  for(int i = 0; i < [sketchPreviews count]; i++) {
    FlipSketchPreviewView* preview = [sketchPreviews objectAtIndex:i];
    
    CGRect bounds = preview.frame;
    int vX = bounds.origin.x;
    int vY = bounds.origin.y;
    int vW = bounds.size.width;
    int vH = bounds.size.height;
    
    if(touchPoint.x >= vX && touchPoint.x <= vX + vW &&
       touchPoint.y >= vY && touchPoint.y <= vY + vH) {
      found = i;
      break;
    }
  }
  
  if(found != selected) {
    
    [[sketchPreviews objectAtIndex:selected] setSelected:NO];
    selected = found;
    
    FlipSketch* selectedSketch = [[sketchPreviews objectAtIndex:selected] sketch];
    [parentController setSketch: selectedSketch];
    [[sketchPreviews objectAtIndex:selected] setSelected:YES];
  }
  
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  for(int i = 0; i < [sketches count]; i++) {
    
  }
}*/


@end
