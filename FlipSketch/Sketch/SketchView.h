//
//  SketchView.h
//  FlipSketch
//
//  Created by Kevin Hampton on 10/12/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shape.h"

@interface SketchView : UIView {
  NSMutableArray* shapes;
}

@property (nonatomic, retain) Shape* draggedShape;

-(void) addDraggedShape;
-(void) cancelDraggedShape;

@end
