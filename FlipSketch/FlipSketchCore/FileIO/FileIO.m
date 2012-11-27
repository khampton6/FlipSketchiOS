//
//  FileIO.m
//  FlipSketch
//
//  Created by Brandon Headrick on 11/18/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "FileIO.h"
#import "ViewController.h"
#import "SketchViewController.h"

#import "Rectangle.h"

@implementation FileIO

- (void)loadData {
  
  NSLog(@"inLoadData");
  
  /****LOADING STUFF ***/
  NSFileManager *filemgr;
  NSString *dataFile;
  NSString *docsDir;
  NSArray *dirPaths;
  
  filemgr = [NSFileManager defaultManager];
  
  // Identify the documents directory
  dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  docsDir = [dirPaths objectAtIndex:0];
  
  // Build the path to the data file
  dataFile = [docsDir stringByAppendingPathComponent: @"datafile.dat"];
  
  // Check if the file already exists
  if ([filemgr fileExistsAtPath: dataFile])
  {
    
    NSData* data = [NSData dataWithContentsOfFile:dataFile];
    //fetch the data to the JSON Foundation opject.
    //[self performSelectorOnMainThread:@selector(fetchedData:)
    //                       withObject:data waitUntilDone:YES];
    
    //NSDictionary* jsonData = nil;
    
    NSError* error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    [self processData:json];
    
  }
  
  [filemgr release];
}

- (void)saveData:(NSData *) data
{
  
  NSLog(@"in Save");
    
  NSFileManager *filemgr;
  //NSData *databuffer;
  NSString *dataFile;
  NSString *docsDir;
  NSArray *dirPaths;
  
  filemgr = [NSFileManager defaultManager];
  
  dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  docsDir = [dirPaths objectAtIndex:0];
  
  dataFile = [docsDir stringByAppendingPathComponent: @"datafile.dat"];
  
  [data writeToFile:dataFile atomically:true];
  
}


- (void)processData:(NSDictionary *) JSONObject{
  NSString        *sketches = [JSONObject valueForKey:@"sketches"];
  NSString        *sketch    = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"];
  //NSString        *shapesData = [[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:0];
  NSString        *shapesData = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"];
  NSString        *transformations =[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:0] objectForKey:@"trans"];
  //NSLog(@"sketches: %@", sketches);

  for (NSString *theSketches in sketches) {
  
    
    //NSString *theSketch = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"];
    
    NSString *theSketch = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"];
  
    NSString *theDesc = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"desc"];
    
    NSString *theId = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"id"];
    
    NSString *theName = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"name"];
    
    //NSString        *theSketch    = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"];
    
    //NSLog(@"theSketch is %@", theSketch);
    NSLog(@"theDesc is %@", theDesc);
    NSLog(@"theId is %@", theId);
    NSLog(@"theName is %@", theName);
    
    for (NSString *theShapesData in shapesData) {
      

      //NSString *theShapes = [[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[shapesData indexOfObject:theShapesData]];
      
      //NSString *theColor = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[shapesData indexOfObject:theShapesData]] objectForKey:@"color"];
      
      NSMutableArray *theColor = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"color"];
      
      NSInteger index0 = 0;
      NSInteger index1 = 1;
      NSInteger index2 = 2;
      
      NSLog(@"%@", [theColor objectAtIndex:index0]);
      
      int r = (int)[theColor objectAtIndex:index0];
      int g = (int)[theColor objectAtIndex:index1];
      int b = (int)[theColor objectAtIndex:index2];
      
      
      RGBColor* tColor = [[RGBColor alloc] initWithR:r withG:g withB:b];
      
      
      NSString *theStartingpage = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"startingPage"];
      
      NSString *theEndingPage = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"endingPage"];
      
      NSString *theIsShapeFilled = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"isShapeFilled"];
      
      NSString *thePoints = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"points"];
      
      NSString *theShapeType = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"shapeType"];
      
      NSString *theStrokeWidth = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"strokeWidth"];
      
      if([theShapeType intValue] ==0){
        NSLog(@"IT'S ZERO!");
        Rectangle *tRect;
        //[tRect initWithX:(int) xPos withY:(int) yPos withColor:(RGBColor *)shapeColor withStrokeWidth:(int) strokeWidth isFilled:(BOOL)filled];
        
        
        
      }
      else if([theShapeType intValue] ==1){
        NSLog(@"IT'S ONE!");
      }
      else if([theShapeType intValue] ==2){
        NSLog(@"IT'S TWO!");
      }
      else if([theShapeType intValue] ==3){
        NSLog(@"IT'S THREE!");
      }
      
      //NSLog(@"theShapes is %@", theShapes);
      NSLog(@"theColor is %@", theColor);
      NSLog(@"theStartingPage is %@", theStartingpage);
      NSLog(@"theEndingpage is %@", theEndingPage);
      NSLog(@"theIsShapeFilled is %@", theIsShapeFilled);
      NSLog(@"thePoints is %@", thePoints);
      NSLog(@"theShapeType is %@", theShapeType);
      NSLog(@"theStrokeWidth is %@", theStrokeWidth);
      
      //trans is just pageNum, xPos, yPos
      for (NSString *theTrans in transformations) {
        
        NSString *theCurrTrans = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:0] objectForKey:@"trans"] objectAtIndex:0];
        
        NSString *thePageNum = [[[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:0] objectForKey:@"trans"] objectAtIndex:0] objectForKey:@"pageNum"];
        
        NSString *theXPos = [[[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:0] objectForKey:@"trans"] objectAtIndex:0] objectForKey:@"xPos"];
        
        NSString *theYPos = [[[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:0] objectForKey:@"trans"] objectAtIndex:0] objectForKey:@"yPos"];
        
        
        //NSLog(@"currTrans is %@",theCurrTrans);
        
        NSLog(@"currTrans is %@",thePageNum);
        
        NSLog(@"currTrans is %@",theXPos);
        
        NSLog(@"currTrans is %@",theYPos);
      }
    }
    
  }


}

- (NSData*)addSketchToJSON:(NSString *)name withDescription: (NSString*)desc withID: (int)theID withShapeArray: (NSMutableArray*)shapesArr{
  
  NSMutableArray *points = [NSMutableArray array];
  for (NSInteger i = 0; i < 4; i++)
    [points addObject:[NSNumber numberWithInteger:i]];
  
  NSMutableArray *colorVals = [NSMutableArray array];
  for (NSInteger i = 0; i < 3; i++)
    [colorVals addObject:[NSNumber numberWithInteger:i]];
  
  NSNumber *x1 = [NSNumber numberWithInt:10];
  NSNumber *y1 = [NSNumber numberWithInt:11];
  NSNumber *x2 = [NSNumber numberWithInt:20];
  NSNumber *y2 = [NSNumber numberWithInt:21];
  
  NSNumber *tX = [NSNumber numberWithInt:40];
  NSNumber *tY = [NSNumber numberWithInt:41];
  NSNumber *tPageNum = [NSNumber numberWithInt:1];
  
  NSNumber *sPage = [NSNumber numberWithInt:0];
  NSNumber *ePage = [NSNumber numberWithInt:2];
  
  NSNumber *sWidth = [NSNumber numberWithInt:1];
  
  NSDictionary *transData = [NSDictionary dictionaryWithObjectsAndKeys:tX, @"xPos", tY, @"yPos", tPageNum, @"pageNum", nil];
  NSMutableArray *transDataArray = [[NSMutableArray alloc] initWithObjects:transData, nil];
  
  NSDictionary *shapeData = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"shapeType", points, @"points", x1, @"x1", y1, @"y1", x2, @"x2", y2, @"y2", colorVals, @"color", @"trueBool", @"isShapeFilled", transDataArray, @"trans", sPage, @"startingPage", ePage, @"endingPage", sWidth, @"strokeWidth", nil];
  
  NSMutableArray *shapeDataArray = [[NSMutableArray alloc] initWithObjects:shapeData, nil];
  
  NSDictionary *sketchData = [NSDictionary dictionaryWithObjectsAndKeys:@"NamedSketch", @"name", @"thisNewDesc", @"desc", @"001", @"id", shapeDataArray, @"shapesData", nil];
  
  NSMutableArray *sketchDataArray = [[NSMutableArray alloc] initWithObjects:sketchData, nil];
  
  NSDictionary *sketches = [[NSDictionary alloc] initWithObjectsAndKeys:sketchDataArray, @"sketch", nil];
  
  NSMutableArray *sketchesArray = [[NSMutableArray alloc] initWithObjects:sketches, nil];
  
  
  
  
  
  NSNumber *x1b = [NSNumber numberWithInt:10];
  NSNumber *y1b = [NSNumber numberWithInt:11];
  NSNumber *x2b = [NSNumber numberWithInt:20];
  NSNumber *y2b = [NSNumber numberWithInt:21];
  
  NSNumber *tXb = [NSNumber numberWithInt:40];
  NSNumber *tYb = [NSNumber numberWithInt:41];
  NSNumber *tPageNumb = [NSNumber numberWithInt:1];
  
  NSNumber *sPageb = [NSNumber numberWithInt:0];
  NSNumber *ePageb = [NSNumber numberWithInt:2];
  
  NSNumber *sWidthb = [NSNumber numberWithInt:5];
  
  NSDictionary *transDatab = [NSDictionary dictionaryWithObjectsAndKeys:tXb, @"xPos", tYb, @"yPos", tPageNumb, @"pageNum", nil];
  NSMutableArray *transDataArrayb = [[NSMutableArray alloc] initWithObjects:transDatab, nil];
  
  NSDictionary *shapeDatab = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"shapeType", points, @"points", x1, @"x1", y1, @"y1", x2, @"x2", y2, @"y2", colorVals, @"color", @"trueBool", @"isShapeFilled", transDataArray, @"trans", sPage, @"startingPage", ePage, @"endingPage", sWidthb, @"strokeWidth", nil];
  
  NSMutableArray *shapeDataArrayb = [[NSMutableArray alloc] initWithObjects:shapeDatab, nil];
  
  NSDictionary *sketchDatab = [NSDictionary dictionaryWithObjectsAndKeys:@"NamedSketchb", @"name", @"thisNewDescb", @"desc", @"001b", @"id", shapeDataArrayb, @"shapesData", nil];
  
  NSMutableArray *sketchDataArrayb = [[NSMutableArray alloc] initWithObjects:sketchDatab, nil];
  
  NSDictionary *sketchesb = [[NSDictionary alloc] initWithObjectsAndKeys:sketchDataArrayb, @"sketch", nil];

  [sketchesArray addObject:sketchesb];
  
  
  
  
  
  
  NSDictionary *sketchesWrapper = [[NSDictionary alloc] initWithObjectsAndKeys:sketchesArray, @"sketches", nil];
  
  NSError *writeError = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sketchesWrapper options:NSJSONWritingPrettyPrinted error:&writeError];
  
  //NSLog( @" in AddSketchToJson%@", jsonData);
  
  return jsonData;

}

-(void) createTestObjects{
  
}

@end
