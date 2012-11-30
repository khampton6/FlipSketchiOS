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
#import "Sketch.h"

@implementation FileIO

@synthesize allSketches;
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
  NSArray        *sketches = [JSONObject valueForKey:@"sketches"];
  NSArray        *sketch    = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"];
  //NSString        *shapesData = [[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:0];
  NSArray        *shapesData = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"];
  NSArray        *transformations =[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:0] objectForKey:@"trans"];
  //NSLog(@"sketches: %@", sketches);

  for (NSString *theSketches in sketches) {
  
    
    //NSString *theSketch = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"];
    
    NSString *theSketch = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"];
  
    NSString *theDesc = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"desc"];
    
    int theId = [[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"id"] intValue];
    
    NSString *theName = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"name"];
    
    
    
    //NSString        *theSketch    = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"];
    
    //NSLog(@"theSketch is %@", theSketch);
    NSLog(@"theDesc is %@", theDesc);
    NSLog(@"theId is %d", theId);
    NSLog(@"theName is %@", theName);
    
    NSLog(@"the size of allSketches is %d", [allSketches count]);
    
    [[allSketches alloc] initWithObject:[[Sketch alloc] initWithName:theName withDesc:theDesc withSID:theId]];
    
    //[allSketches addObject:[[Sketch alloc] initWithName:theName withDesc:theDesc withSID:theId]];
    
    NSLog(@"the size of allSketches is %d", [allSketches count]);
    
    for (NSString *theShapesData in shapesData) {
      

      //NSString *theShapes = [[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[shapesData indexOfObject:theShapesData]];
      
      //NSString *theColor = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[shapesData indexOfObject:theShapesData]] objectForKey:@"color"];
      
      NSMutableArray *theColor = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"color"];
      
      NSInteger index0 = 0;
      NSInteger index1 = 1;
      NSInteger index2 = 2;
      
      //NSLog(@"%@", [theColor objectAtIndex:index0]);
      
      int r = (int)[theColor objectAtIndex:index0];
      int g = (int)[theColor objectAtIndex:index1];
      int b = (int)[theColor objectAtIndex:index2];
      
      
      RGBColor* tColor = [[RGBColor alloc] initWithR:r withG:g withB:b];
      
      
      int theStartingPage = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"startingPage"] intValue];
      
      int theEndingPage = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"endingPage"] intValue];
      
      BOOL theIsShapeFilled = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"isShapeFilled"] boolValue];
      
      NSString *thePoints = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"points"];
      
      NSString *theShapeType = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"shapeType"];
      
      int theStrokeWidth = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"strokeWidth"] intValue];
      
      
      
      //if the shape is a rectangle
      //rectangle specific attributes include shapeWidth, shapeHeight, X1, and Y1
      if([theShapeType intValue] ==0){
        NSLog(@"IT'S ZERO!");
        
        int theShapeWidth = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"shapeWidth"] intValue];
        
        int theShapeHeight = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"shapeHeight"] intValue];
        
        int theX1Pos = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"x1"] intValue ];
        
        int theY1Pos = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"y1"] intValue ];
        
        /*
        int theX2Pos = (int)[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"x2"];
        
        int theY2Pos = (int)[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"y2"];
        */
        
        NSLog(@"theShapeWidth is %d", theShapeWidth);
        NSLog(@"theShapeHeight is %d", theShapeHeight);
        
        NSLog(@"theX1 is %d", theX1Pos);
        NSLog(@"theY1 is %d", theY1Pos);
        /*
        NSLog(@"theX2 is %@", theX2Pos);
        NSLog(@"theY2 is %@", theY2Pos);
        */
        
        //[[allSketches objectAtIndex: [(NSMutableArray*)sketches indexOfObject:theSketches]]addShapeToArray:<#(Shape *)#>];
        
        //[[Rectangle alloc] initWithX: (int)theX1Pos withY: (int)theY1Pos withWidth:(int) theShapeWidth withHeight:(int) theShapeHeight withColor: tColor withStrokeWidth:(int) theStrokeWidth isFilled: (BOOL) YES withStartingPage:(int) theStartingPage withEndingPage:(int) theEndingPage withTransArray: nil];
        
        //add the current shape to the current sketch object
        [[allSketches objectAtIndex: [(NSMutableArray*)sketches indexOfObject:theSketches]]addShapeToArray:[[Rectangle alloc] initWithX: (int)theX1Pos withY: (int)theY1Pos withWidth:(int) theShapeWidth withHeight:(int) theShapeHeight withColor: tColor withStrokeWidth:(int) theStrokeWidth isFilled: (BOOL) theIsShapeFilled withStartingPage:(int) theStartingPage withEndingPage:(int) theEndingPage withTransArray: nil]];
        
        
        /////////NSLog(@"current Index is %d", [(NSMutableArray*)sketches indexOfObject:theSketches]);
        
        //test that the object was indeed created
        //NSString *test = [[allSketches objectAtIndex:0] description];
        //NSString *test = [[allSketches objectAtIndex:0] description];
        
        /////////NSLog(@"The description is %@", [allSketches objectAtIndex:0]);
        
      }
      //if the shape is an Oval
      //Oval specific attributes include shapeWidth, shapeHeight, X1, and Y1 (same as rect)
      else if([theShapeType intValue] ==1){
        NSLog(@"IT'S ONE!");
      }
      
      //if the shape is a line
      //rectangle specific attributes include X1, Y1, X2, and Y2
      else if([theShapeType intValue] ==2){
        NSLog(@"IT'S TWO!");
      }
      
      //if the shape is a brush
      //rectangle specific attributes include strokePath & strokePoints
      else if([theShapeType intValue] ==3){
        NSLog(@"IT'S THREE!");
      }
      
      //NSLog(@"theShapes is %@", theShapes);
      NSLog(@"theColor is %@", theColor);
      NSLog(@"theStartingPage is %d", theStartingPage);
      NSLog(@"theEndingpage is %d", theEndingPage);
      NSLog(@"theIsShapeFilled is %d", theIsShapeFilled);
      NSLog(@"thePoints is %@", thePoints);
      NSLog(@"theShapeType is %@", theShapeType);
      NSLog(@"theStrokeWidth is %d", theStrokeWidth);
      
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
    [colorVals addObject:[NSNumber numberWithInteger:(i+25)]];
  
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
  
  NSNumber *shapeWidth = [NSNumber numberWithInt:5];
  NSNumber *shapeHeight = [NSNumber numberWithInt:5];
  
  NSDictionary *transData = [NSDictionary dictionaryWithObjectsAndKeys:tX, @"xPos", tY, @"yPos", tPageNum, @"pageNum", nil];
  NSMutableArray *transDataArray = [[NSMutableArray alloc] initWithObjects:transData, nil];
  
  //UIBezierPath *thePath = [[UIBezierPath alloc] init];
  
  NSMutableArray *thePath = [[NSMutableArray alloc] init];
  
  /*
  thePath.lineWidth = strokeWidth;
  [thePath moveToPoint:CGPointMake(x, y)];
   */
  
  NSMutableArray *strokePoints = [NSMutableArray array];
  for (NSInteger i = 0; i < 2; i++)
    [strokePoints addObject:[NSNumber numberWithInteger:i]];
  
  NSDictionary *shapeData = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"shapeType", points, @"points", x1, @"x1", y1, @"y1", x2, @"x2", y2, @"y2", colorVals, @"color", @"YES", @"isShapeFilled", transDataArray, @"trans", sPage, @"startingPage", ePage, @"endingPage", sWidth, @"strokeWidth", shapeWidth, @"shapeWidth", shapeHeight, @"shapeHeight", thePath, @"strokePath", strokePoints, @"strokePoints", nil];
  
  NSMutableArray *shapeDataArray = [[NSMutableArray alloc] initWithObjects:shapeData, nil];
  
  NSDictionary *sketchData = [NSDictionary dictionaryWithObjectsAndKeys:@"NamedSketch", @"name", @"thisNewDesc", @"desc", @"1", @"id", shapeDataArray, @"shapesData", nil];
  
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
  
  NSNumber *shapeWidthb = [NSNumber numberWithInt:3];
  NSNumber *shapeHeightb = [NSNumber numberWithInt:3];
  
  NSDictionary *transDatab = [NSDictionary dictionaryWithObjectsAndKeys:tXb, @"xPos", tYb, @"yPos", tPageNumb, @"pageNum", nil];
  NSMutableArray *transDataArrayb = [[NSMutableArray alloc] initWithObjects:transDatab, nil];
  
  NSDictionary *shapeDatab = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"shapeType", points, @"points", x1b, @"x1", y1b, @"y1", x2b, @"x2", y2b, @"y2", colorVals, @"color", @"NO", @"isShapeFilled", transDataArrayb, @"trans", sPageb, @"startingPage", ePageb, @"endingPage", sWidthb, @"strokeWidth", shapeWidthb, @"shapeWidth", shapeHeightb, @"shapeHeight", thePath, @"strokePath", strokePoints, @"strokePoints", nil];
  
  NSMutableArray *shapeDataArrayb = [[NSMutableArray alloc] initWithObjects:shapeDatab, nil];
  
  NSDictionary *sketchDatab = [NSDictionary dictionaryWithObjectsAndKeys:@"NamedSketchb", @"name", @"thisNewDescb", @"desc", @"0", @"id", shapeDataArrayb, @"shapesData", nil];
  
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
