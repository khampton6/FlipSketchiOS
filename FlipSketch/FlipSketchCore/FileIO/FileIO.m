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
#import "SketchListView.h"

#import "Rectangle.h"
#import "Oval.h"
#import "Line.h"
#import "Brush.h"
#import "Sketch.h"

@implementation FileIO

@synthesize allSketches, allJsons, currSID;

-(id)init{
  
  //allJsons = nil;
  allSketches = [[NSMutableArray alloc] init];
  currSID = 0;
  self = [super init];
  //allSketches = [[NSMutableArray alloc] init];
  return self;
}

- (NSMutableArray *)loadData {
  
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
    
    NSDictionary *prevSavedJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return [self processDataForLoading:prevSavedJSON];
  }
  
  //[filemgr release];
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

- (void)clearData
{
  NSString* data = @"{}";
  NSLog(@"in ClearData");
  
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

- (NSMutableArray *)processDataForLoading:(NSDictionary *) JSONObject{
  NSArray        *sketches = [JSONObject valueForKey:@"sketches"];

  //NSArray        *shapesData = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"];
  
  //NSLog(@"sketches: %@", sketches);
  
  
  //allSketches = [[NSMutableArray alloc] init];
  
  for (NSString *theSketches in sketches) {
    
    
    //NSString *theSketch = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"];
    
    //NSString *theSketch = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"];
    
    NSString *theDesc = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"desc"];
    
    int theId = [[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"id"] intValue];
    
    NSDictionary* dict = [[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0];
    
    NSObject* obj = [dict objectForKey:@"name"];
    NSString* type = NSStringFromClass([obj class]);
    //NSLog(@"Type: %@", type);
    
    NSString *theName = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"name"];
    
    int theTotalPages = [[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"totalNumOfPages"] intValue];
    
    /*
    if(currSID <= theId){
      currSID = theId+1;
      
    }
    */
    
    int lowerBound = 1;
    int upperBound = INT_MAX;
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    
    //theId = rndValue;
    
    //for testing purposes, just get a randomized num for the curSID;
    
    
    //NSString        *theSketch    = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"];
    
    //NSLog(@"theSketch is %@", theSketch);
    /*
    NSLog(@"theDesc is %@", theDesc);
    NSLog(@"theId is %d", theId);
    NSLog(@"theName is %@", theName);
    NSLog(@"the Total Pages is %d", theTotalPages);
    
    NSLog(@"the size of allSketches is %d", [allSketches count]);
    */
    //allSketches = [[allSketches alloc] initWithObject:[[Sketch alloc] initWithName:theName withDesc:theDesc withSID:theId]];
    
    //[allSketches retain];
    [allSketches addObject:[[Sketch alloc] initWithName:theName withDesc:theDesc withSID:theId withTotalPages:theTotalPages]];
    //[[allSketches objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] retain];
    
    //NSLog(@"the size of allSketches is %d", [allSketches count]);
    
    
    NSArray *shapesData = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"];
    
    //NSLog(@" testingxxx %@", [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]);
    //NSLog(@" testingxxx %@", [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]);
    
    for (NSString *theShapesData in shapesData) {
      
      NSMutableArray *theColor = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"color"];
      
      
      
      NSInteger index0 = 0;
      NSInteger index1 = 1;
      NSInteger index2 = 2;
      
      float r = [[theColor objectAtIndex:index0] floatValue];
      float g = [[theColor objectAtIndex:index1] floatValue];
      float b = [[theColor objectAtIndex:index2] floatValue];
      
      /*
      NSLog(@" the cols are %f%f%f", r,g,b);
      NSLog(@" the cols array is %@", theColor);
       */
      
      RGBColor* tColor = [[RGBColor alloc] initWithR:r withG:g withB:b];
      
      
      int theStartingPage = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"startingPage"] intValue];
      
      int theEndingPage = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"endingPage"] intValue];
      
      BOOL theIsShapeFilled = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"isShapeFilled"] boolValue];
      
      
      NSString *thePoints = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"points"];
      
      int theShapeType = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"shapeType"] intValue];
      
      int theStrokeWidth = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"strokeWidth"] intValue];
      
      
      //NSLog(@"theShapes is %@", theShapes);
      /*
      NSLog(@"theColor is %@", tColor);
      NSLog(@"theStartingPage is %d", theStartingPage);
      NSLog(@"theEndingpage is %d", theEndingPage);
      NSLog(@"theIsShapeFilled is %d", theIsShapeFilled);
      NSLog(@"thePoints is %@", thePoints);
      NSLog(@"theShapeType is %d", theShapeType);
      NSLog(@"theStrokeWidth is %d", theStrokeWidth);
      */
      NSMutableDictionary *transDict = [[NSMutableDictionary alloc] init];
      //[transDict retain];
      NSLog(@"BEFORE Trans X times? ");
      
      NSArray *transformations =[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"trans"];
      
      //trans is just pageNum, xPos, yPos
      for (NSString *theTrans in transformations) {
        
        NSLog(@"InTrans X times? ");
        
        int thePageNum = [[[[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"trans"] objectAtIndex:[(NSMutableArray*)transformations indexOfObject:theTrans]] objectForKey:@"pageNum"] intValue];
        
        int theXPos = [[[[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"trans"] objectAtIndex:[(NSMutableArray*)transformations indexOfObject:theTrans]] objectForKey:@"xPos"] intValue];
        
        int theYPos = [[[[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"trans"] objectAtIndex:[(NSMutableArray*)transformations indexOfObject:theTrans]] objectForKey:@"yPos"] intValue];
        
        /*
         BOOL theIsKeyFrame = [[[[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:0] objectForKey:@"trans"] objectAtIndex:0] objectForKey:@"isKeyFrame"] boolValue];
         */
        BOOL theIsKeyFrame = [[[[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"trans"] objectAtIndex:[(NSMutableArray*)transformations indexOfObject:theTrans]] objectForKey:@"isKeyFrame"] boolValue];
        
        //NSLog(@"currTrans is %@",theCurrTrans);
        
        /*
        NSLog(@"currTrans is %d",thePageNum);
        
        NSLog(@"currTrans is %d",theXPos);
        
        NSLog(@"currTrans is %d",theYPos);
        
        NSLog(@"currTrans is %d",theIsKeyFrame);
        */
        Transformation *currTrans = [[Transformation alloc] initWithPageNumber:thePageNum withX:theXPos withY:theYPos isKeyFrame:theIsKeyFrame];
        
        
        
        //transDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:currTrans, [NSNumber numberWithInt:thePageNum], nil];
        //transDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:currTrans, [NSNumber numberWithInt:89], nil];
        
        [transDict setObject:currTrans forKey:[NSNumber numberWithInt:thePageNum]];
        
        //Transformation *currTrans = [[Transformation alloc] initWithPageNumber:thePageNum withX:theXPos withY:theYPos isKeyFrame:theIsKeyFrame];
        
        //[transArr addObject:currTrans];
        
      }
      
      
      //if the shape is a rectangle
      //rectangle/oval specific attributes include shapeWidth, shapeHeight, X1, and Y1
      if(theShapeType ==0 || theShapeType ==1){
        
        
        int theShapeWidth = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"shapeWidth"] intValue];
        
        int theShapeHeight = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"shapeHeight"] intValue];
        
        int theX1Pos = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"x1"] intValue ];
        
        int theY1Pos = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"y1"] intValue ];
        
        
        /*
        NSLog(@"theShapeWidth is %d", theShapeWidth);
        NSLog(@"theShapeHeight is %d", theShapeHeight);
        
        NSLog(@"theX1 is %d", theX1Pos);
        NSLog(@"theY1 is %d", theY1Pos);
        */
        
        //[[allSketches objectAtIndex: [(NSMutableArray*)sketches indexOfObject:theSketches]]addShapeToArray:<#(Shape *)#>];
        
        //[[Rectangle alloc] initWithX: (int)theX1Pos withY: (int)theY1Pos withWidth:(int) theShapeWidth withHeight:(int) theShapeHeight withColor: tColor withStrokeWidth:(int) theStrokeWidth isFilled: (BOOL) YES withStartingPage:(int) theStartingPage withEndingPage:(int) theEndingPage withTransArray: nil];
        
        if(theShapeType == 0){
          
          //NSLog(@"sizeOfShapeArr is %d", [[allSketches objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] ]);
          
          //add the current shape to the current sketch object
          
          
          
          [[allSketches objectAtIndex: [(NSMutableArray*)sketches indexOfObject:theSketches]]addShapeToArray:[[Rectangle alloc] initWithX: (int)theX1Pos withY: (int)theY1Pos withWidth:(int) theShapeWidth withHeight:(int) theShapeHeight withColor: tColor withStrokeWidth: theStrokeWidth isFilled: theIsShapeFilled withStartingPage:(int) theStartingPage withEndingPage:(int) theEndingPage withTransArray: transDict withShapeType:theShapeType]];
          
          
          
          NSLog(@"IS SHAPE RECTANGLE");
          
          
        }
        else{
          [[allSketches objectAtIndex: [(NSMutableArray*)sketches indexOfObject:theSketches]]addShapeToArray:[[Oval alloc] initWithX: (int)theX1Pos withY: (int)theY1Pos withWidth:(int) theShapeWidth withHeight:(int) theShapeHeight withColor: tColor withStrokeWidth: theStrokeWidth isFilled: theIsShapeFilled withStartingPage:(int) theStartingPage withEndingPage:(int) theEndingPage withTransArray: transDict withShapeType:theShapeType]];
          
          NSLog(@"IS SHAPE Oval");
        }
        
        
      }
      
      //if the shape is a line
      //rectangle specific attributes include X1, Y1, X2, and Y2
      else if(theShapeType  ==2){
        NSLog(@"IS SHAPE LINE");
        
        
        int theX1Pos = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"x1"] intValue ];
        
        int theY1Pos = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"y1"] intValue ];
        
        
        int theX2Pos = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"x2"] intValue];
        
        int theY2Pos = [[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"y2"] intValue];
        
        //NSLog(@" the poses are %d %d %d %d ", theX1Pos, theY1Pos, theX2Pos, theY2Pos);
        
        [[allSketches objectAtIndex: [(NSMutableArray*)sketches indexOfObject:theSketches]]addShapeToArray:[[Line alloc] initWithX1:theX1Pos withY1:theY1Pos withX2:theX2Pos withY2:theY2Pos withColor:tColor withStrokeWidth:theStrokeWidth isFilled:theIsShapeFilled withStartingPage:theStartingPage withEndingPage:theEndingPage withTransArray:transDict withShapeType:theShapeType]];
        
      }
      
      //if the shape is a brush
      //brush specific attributes include strokePoints
      else if(theShapeType  ==3){
        NSLog(@"IS SHAPE BRUSH");
        
        NSMutableArray *theStrokePoints = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[(NSMutableArray*)shapesData indexOfObject:theShapesData]] objectForKey:@"strokePoints"];
        
        [[allSketches objectAtIndex: [(NSMutableArray*)sketches indexOfObject:theSketches]]addShapeToArray:[[Brush alloc] initWithStrokePoints:theStrokePoints withColor:tColor withStrokeWidth:theStrokeWidth withStartingPage:theStartingPage withEndingPage:theEndingPage withTransArray:transDict withShapeType:theShapeType]];
        
      }
      /*
      [[[allSketches objectAtIndex: [(NSMutableArray*)sketches indexOfObject:theSketches]]shapesArray] retain];

      NSLog(@"Testing shapesArray Retain %@", [[allSketches objectAtIndex: [(NSMutableArray*)sketches indexOfObject:theSketches]]shapesArray]);
       */
      
      

    }
    
  }
  
  NSLog(@"zzz1 allSketches is %@", allSketches);
  
  return allSketches;
}

- (NSData*)addSketchToJSON:(NSString *)name withDescription: (NSString*)desc withID: (int)theID withShapeArray: (NSMutableArray*)shapesArr{
  
  NSMutableArray *points = [NSMutableArray array];
  for (NSInteger i = 0; i < 4; i++)
    [points addObject:[NSNumber numberWithInteger:i]];
  
  NSMutableArray *colorVals = [NSMutableArray array];
  for (NSInteger i = 0; i < 3; i++)
    [colorVals addObject:[NSNumber numberWithFloat:((i+1.0f)/5.0f)]];
  
  NSNumber *totPages = [NSNumber numberWithInt:10];
  
  NSNumber *x1 = [NSNumber numberWithInt:100];
  NSNumber *y1 = [NSNumber numberWithInt:110];
  NSNumber *x2 = [NSNumber numberWithInt:20];
  NSNumber *y2 = [NSNumber numberWithInt:21];
  
  NSNumber *tX = [NSNumber numberWithInt:40];
  NSNumber *tY = [NSNumber numberWithInt:41];
  NSNumber *tPageNum = [NSNumber numberWithInt:1];
  NSString *tIsKeyFrame = @"YES";
  
  NSNumber *sPage = [NSNumber numberWithInt:0];
  NSNumber *ePage = [NSNumber numberWithInt:2];
  
  NSNumber *sWidth = [NSNumber numberWithInt:5];
  
  NSNumber *shapeWidth = [NSNumber numberWithInt:50];
  NSNumber *shapeHeight = [NSNumber numberWithInt:50];
  
  NSDictionary *transData = [NSDictionary dictionaryWithObjectsAndKeys:tX, @"xPos", tY, @"yPos", tPageNum, @"pageNum", tIsKeyFrame, @"isKeyFrame", nil];
  NSMutableArray *transDataArray = [[NSMutableArray alloc] initWithObjects:transData, nil];
  
  NSMutableArray *strokePoints = [NSMutableArray array];
  for (NSInteger i = 0; i < 2; i++)
    [strokePoints addObject:[NSNumber numberWithInteger:i]];
  
  NSDictionary *shapeData = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"shapeType", points, @"points", x1, @"x1", y1, @"y1", x2, @"x2", y2, @"y2", colorVals, @"color", @"YES", @"isShapeFilled", transDataArray, @"trans", sPage, @"startingPage", ePage, @"endingPage", sWidth, @"strokeWidth", shapeWidth, @"shapeWidth", shapeHeight, @"shapeHeight", strokePoints, @"strokePoints", nil];
  
  NSMutableArray *shapeDataArray = [[NSMutableArray alloc] initWithObjects:shapeData, nil];
  
  NSDictionary *sketchData = [NSDictionary dictionaryWithObjectsAndKeys:@"sketch A", @"name", @"thisNewDesc", @"desc", @"1", @"id", shapeDataArray, @"shapesData", totPages, @"totalNumOfPages", nil];
  
  NSMutableArray *sketchDataArray = [[NSMutableArray alloc] initWithObjects:sketchData, nil];
  
  NSDictionary *sketches = [[NSDictionary alloc] initWithObjectsAndKeys:sketchDataArray, @"sketch", nil];
  
  NSMutableArray *sketchesArray = [[NSMutableArray alloc] initWithObjects:sketches, nil];
  
  
  
  
  /***SECOND OBJECT; OVAL ****/
  NSNumber *totPagesb = [NSNumber numberWithInt:12];
  
  NSNumber *x1b = [NSNumber numberWithInt:100];
  NSNumber *y1b = [NSNumber numberWithInt:110];
  NSNumber *x2b = [NSNumber numberWithInt:20];
  NSNumber *y2b = [NSNumber numberWithInt:21];
  
  NSNumber *tXb = [NSNumber numberWithInt:40];
  NSNumber *tYb = [NSNumber numberWithInt:41];
  NSNumber *tPageNumb = [NSNumber numberWithInt:1];
  NSString *tIsKeyFrameb = @"YES";
  
  NSNumber *sPageb = [NSNumber numberWithInt:0];
  NSNumber *ePageb = [NSNumber numberWithInt:2];
  
  NSNumber *sWidthb = [NSNumber numberWithInt:5];
  
  NSNumber *shapeWidthb = [NSNumber numberWithInt:50];
  NSNumber *shapeHeightb = [NSNumber numberWithInt:50];
  
  NSDictionary *transDatab = [NSDictionary dictionaryWithObjectsAndKeys:tXb, @"xPos", tYb, @"yPos", tPageNumb, @"pageNum", tIsKeyFrameb, @"isKeyFrame", nil];
  
  NSMutableArray *transDataArrayb = [[NSMutableArray alloc] initWithObjects:transDatab, nil];
  
  NSDictionary *shapeDatab = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"shapeType", points, @"points", x1b, @"x1", y1b, @"y1", x2b, @"x2", y2b, @"y2", colorVals, @"color", @"NO", @"isShapeFilled", transDataArrayb, @"trans", sPageb, @"startingPage", ePageb, @"endingPage", sWidthb, @"strokeWidth", shapeWidthb, @"shapeWidth", shapeHeightb, @"shapeHeight", strokePoints, @"strokePoints", nil];
  
  NSMutableArray *shapeDataArrayb = [[NSMutableArray alloc] initWithObjects:shapeDatab, nil];
  
  NSDictionary *sketchDatab = [NSDictionary dictionaryWithObjectsAndKeys:@"sketch B", @"name", @"thisNewDesc", @"desc", @"1", @"id", shapeDataArrayb, @"shapesData", totPagesb, @"totalNumOfPages", nil];
  
  NSMutableArray *sketchDataArrayb = [[NSMutableArray alloc] initWithObjects:sketchDatab, nil];
  
  NSDictionary *sketchesb = [[NSDictionary alloc] initWithObjectsAndKeys:sketchDataArrayb, @"sketch", nil];
  
  [sketchesArray addObject:sketchesb];
  /************************/
  
  
  
  
  /***THIRD OBJECT; LINE ****/
  NSNumber *totPagesc = [NSNumber numberWithInt:15];
  
  NSNumber *x1c = [NSNumber numberWithInt:100];
  NSNumber *y1c = [NSNumber numberWithInt:110];
  NSNumber *x2c = [NSNumber numberWithInt:20];
  NSNumber *y2c = [NSNumber numberWithInt:21];
  
  NSNumber *tXc = [NSNumber numberWithInt:40];
  NSNumber *tYc = [NSNumber numberWithInt:41];
  NSNumber *tPageNumc = [NSNumber numberWithInt:1];
  NSString *tIsKeyFramec = @"YES";
  
  NSNumber *sPagec = [NSNumber numberWithInt:0];
  NSNumber *ePagec = [NSNumber numberWithInt:2];
  
  NSNumber *sWidthc = [NSNumber numberWithInt:5];
  
  NSNumber *shapeWidthc = [NSNumber numberWithInt:50];
  NSNumber *shapeHeightc = [NSNumber numberWithInt:50];
  
  NSDictionary *transDatac = [NSDictionary dictionaryWithObjectsAndKeys:tXc, @"xPos", tYc, @"yPos", tPageNumc, @"pageNum", tIsKeyFramec, @"isKeyFrame", nil];
  
  NSMutableArray *transDataArrayc = [[NSMutableArray alloc] initWithObjects:transDatac, nil];
  
  NSDictionary *shapeDatac = [NSDictionary dictionaryWithObjectsAndKeys:@"2", @"shapeType", points, @"points", x1c, @"x1", y1c, @"y1", x2c, @"x2", y2c, @"y2", colorVals, @"color", @"NO", @"isShapeFilled", transDataArrayc, @"trans", sPagec, @"startingPage", ePagec, @"endingPage", sWidthc, @"strokeWidth", shapeWidthc, @"shapeWidth", shapeHeightc, @"shapeHeight", strokePoints, @"strokePoints", nil];
  
  NSMutableArray *shapeDataArrayc = [[NSMutableArray alloc] initWithObjects:shapeDatac, nil];
  
  NSDictionary *sketchDatac = [NSDictionary dictionaryWithObjectsAndKeys:@"sketch C", @"name", @"thisNewDesc", @"desc", @"1", @"id", shapeDataArrayc, @"shapesData", totPagesc, @"totalNumOfPages", nil];
  
  NSMutableArray *sketchDataArrayc = [[NSMutableArray alloc] initWithObjects:sketchDatac, nil];
  
  NSDictionary *sketchesc = [[NSDictionary alloc] initWithObjectsAndKeys:sketchDataArrayc, @"sketch", nil];
  
  [sketchesArray addObject:sketchesc];
  /************************/
  
  
  /***FOURTH OBJECT; BRUSH ****/
  NSNumber *totPagesd = [NSNumber numberWithInt:20];
  
  NSNumber *x1d = [NSNumber numberWithInt:100];
  NSNumber *y1d = [NSNumber numberWithInt:110];
  NSNumber *x2d = [NSNumber numberWithInt:20];
  NSNumber *y2d = [NSNumber numberWithInt:21];
  
  NSNumber *tXd = [NSNumber numberWithInt:40];
  NSNumber *tYd = [NSNumber numberWithInt:41];
  NSNumber *tPageNumd = [NSNumber numberWithInt:1];
  NSString *tIsKeyFramed = @"YES";
  
  NSNumber *sPaged = [NSNumber numberWithInt:0];
  NSNumber *ePaged = [NSNumber numberWithInt:2];
  
  NSNumber *sWidthd = [NSNumber numberWithInt:5];
  
  NSNumber *shapeWidthd = [NSNumber numberWithInt:50];
  NSNumber *shapeHeightd = [NSNumber numberWithInt:50];
  
  NSDictionary *transDatad = [NSDictionary dictionaryWithObjectsAndKeys:tXd, @"xPos", tYd, @"yPos", tPageNumd, @"pageNum", tIsKeyFramed, @"isKeyFrame", nil];
  
  NSMutableArray *transDataArrayd = [[NSMutableArray alloc] initWithObjects:transDatad, nil];
  
  NSDictionary *shapeDatad = [NSDictionary dictionaryWithObjectsAndKeys:@"3", @"shapeType", points, @"points", x1d, @"x1", y1d, @"y1", x2d, @"x2", y2d, @"y2", colorVals, @"color", @"NO", @"isShapeFilled", transDataArrayd, @"trans", sPaged, @"startingPage", ePaged, @"endingPage", sWidthd, @"strokeWidth", shapeWidthd, @"shapeWidth", shapeHeightd, @"shapeHeight", strokePoints, @"strokePoints", nil];
  
  NSMutableArray *shapeDataArrayd = [[NSMutableArray alloc] initWithObjects:shapeDatad, nil];
  
  NSDictionary *sketchDatad = [NSDictionary dictionaryWithObjectsAndKeys:@"sketch D", @"name", @"thisNewDesc", @"desc", @"1", @"id", shapeDataArrayd, @"shapesData", totPagesd, @"totalNumOfPages", nil];
  
  NSMutableArray *sketchDataArrayd = [[NSMutableArray alloc] initWithObjects:sketchDatad, nil];
  
  NSDictionary *sketchesd = [[NSDictionary alloc] initWithObjectsAndKeys:sketchDataArrayd, @"sketch", nil];
  
  [sketchesArray addObject:sketchesd];
  /************************/
  
  
  
  NSDictionary *sketchesWrapper = [[NSDictionary alloc] initWithObjectsAndKeys:sketchesArray, @"sketches", nil];
  
  NSError *writeError = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sketchesWrapper options:NSJSONWritingPrettyPrinted error:&writeError];
  
  //NSLog( @" in AddSketchToJson%@", jsonData);
  
  return jsonData;
  
}



-(void) saveSketch:(Sketch *)aSketch{
  
  
  /************************************************************************************************************************/
    /************************************************************************************************************************/
  
  
  
  //just prepopulating the stuff
  
  /*
  NSMutableArray* _temp = [[NSMutableArray alloc] init];
  
  NSData *dataToSave = [self addSketchToJSON:@"named" withDescription:@"desc" withID:1 withShapeArray:_temp];
  
  [self saveData:dataToSave];
  */

  
  //allSketches = [self loadData];
  
  //for(allSketches.count){
  
  NSMutableArray *shapeDataArray;
  
  NSDictionary *sketchData;
  
  NSMutableArray *sketchDataArray;
  
  NSDictionary *theSketch;
  
  NSDictionary *sketchesWrapper;
  
  NSError *writeError;
  
  NSData *jsonData = nil;
  
  NSString *theSketchName = [aSketch sketchName];
  NSString *theSketchDesc = [aSketch desc];
  
  NSNumber *theSID = [NSNumber numberWithInteger:[aSketch sID]];
  
  NSNumber *theNumOfPages = [NSNumber numberWithInteger:[aSketch totalPages]];
  
  shapeDataArray = [[NSMutableArray alloc] init];
  
  for (Shape *allTheShapes in [aSketch shapesArray]) {
    
    //if rect or oval
    //rectangle/oval specific attributes include shapeWidth, shapeHeight, X1, and Y1
    if([allTheShapes shapeType] == 0 || [allTheShapes shapeType] == 1){
      [shapeDataArray addObject:[allTheShapes getJSONData]];
      
    }
    //if line
    //rectangle specific attributes include X1, Y1, X2, and Y2
    else if([allTheShapes shapeType] == 2){
      [shapeDataArray addObject:[allTheShapes getJSONData]];
    }
    //if brush
    //brush specific attributes include strokePoints
    else{
      [shapeDataArray addObject:[allTheShapes getJSONData]];
    }
    
  }
  
  sketchData = [NSDictionary dictionaryWithObjectsAndKeys:theSketchName, @"name", theSketchDesc, @"desc", theSID, @"id", shapeDataArray, @"shapesData", theNumOfPages, @"totalNumOfPages", nil];
  
  sketchDataArray = [[NSMutableArray alloc] initWithObjects:sketchData, nil];
  
  theSketch = [[NSDictionary alloc] initWithObjectsAndKeys:sketchDataArray, @"sketch", nil];

  //allSketches = [[NSMutableArray alloc] init];
  NSMutableArray* sketchToBeSaved = [[NSMutableArray alloc]init];
  
  //[allSketches addObject:[[Sketch alloc] initWithName:theSketchName withDesc:theSketchDesc withSID:0 withTotalPages:5]];
  
  //NSLog(@"theExtractedValue %@", [self extractSavedJsonData]);
  
  //just tests to make sure that this isn't the first sketch the user is creating.
  if([self extractSavedJsonData:-1] != NULL){
    
    sketchToBeSaved = [self extractSavedJsonData: [theSID intValue]];
  }
  
  NSLog(@"theSketchesDictIs %@", sketchToBeSaved);
  
  
  [sketchToBeSaved addObject:theSketch];
  
  //NSLog(@"sketchToBeSavedThing %@", sketchToBeSaved);
  
  sketchesWrapper = [[NSDictionary alloc] initWithObjectsAndKeys:sketchToBeSaved, @"sketches", nil];
  
  
  writeError = nil;
  jsonData = [NSJSONSerialization dataWithJSONObject:sketchesWrapper options:NSJSONWritingPrettyPrinted error:&writeError];
  
  
  
  
  [self saveData: jsonData];
}

-(NSMutableArray*) extractSavedJsonData: (int)idToIgnore{
  //NSMutableArray* retJsonData = [[NSMutableArray alloc]init];
  
  NSMutableArray *resultingSketches;
  
  NSLog(@"inGettingJsonForSavings");
  
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
    
    NSDictionary *unMutePrevSavedJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSMutableDictionary* prevSavedJSON = [unMutePrevSavedJSON mutableCopy];
    
    //NSLog(@"theMutablePrevSaved %@", prevSavedJSON );
    
    //return [self processDataForLoading:prevSavedJSON];
    
    //everySketch = [prevSavedJSON valueForKey:@"sketches"];
    
    NSMutableArray *sketches = [prevSavedJSON valueForKey:@"sketches"];
    
    for (NSString *aSketch in sketches) {
      
      
      
      int theId = [[[[[[prevSavedJSON objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:aSketch]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"id"] intValue];
      
      
      
      //if the id is the same, ignore it.
      if(theId == idToIgnore){
        //NSLog(@"!!!!!!!");
        
        
        //NSMutableDictionary* innerJSON = [[prevSavedJSON objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:aSketch]];
        
        
        
        NSMutableData* toBeRem = [[[prevSavedJSON objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:aSketch]] objectForKey:@"sketch"];
        
        //NSMutableDictionary* toBeReturned =
        
        //[prevSavedJSON removeObjectForKey:(NSMutableData*)toBeRem];
        
        //[prevSavedJSON removeObjectForKey:@"sketches"];
        
        NSMutableDictionary* tempS = [[prevSavedJSON objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:aSketch]];
        
        //NSLog(@"theThingToBeRemovedIs %@", [[[prevSavedJSON objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:aSketch]] objectForKey:@"sketch"]);
        
        //[prevSavedJSON removeObjectForKey:[[[prevSavedJSON objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:aSketch]] objectForKey:@"sketch"]];
        
        //[prevSavedJSON removeObjectForKey:tempS];
        
        //[prevSavedJSON removeObjectForKey: [tempS objectForKey: "@sketch"]];
        
        //[prevSavedJSON removeObjectForKey:<#(id)#>]
        
        //[innerJSON removeObjectForKey:@"sketch"];
        
        ////[prevSavedJSON removeObjectForKey:[prevSavedJSON [innerJSON objectForKey:@"sketch"]]];
        
        NSMutableDictionary* innerJSON = [[prevSavedJSON objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:aSketch]];
        
        NSLog(@"!!!!!!!the test stuff %@", [[[prevSavedJSON objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:aSketch]] objectForKey:@"sketch"]);
        
        [resultingSketches addObject:innerJSON];
        
      }
      
      //actually add them to the object that will be returned.
      else{
        //NSLog(@"???????the test stuff &@", [[[prevSavedJSON objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:aSketch]] objectForKey:@"sketch"]);
        
        NSLog(@"???????the test stuff %@", [[prevSavedJSON objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:aSketch]]);
        
        NSMutableDictionary* innerJSON = [[prevSavedJSON objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:aSketch]];
        
        [resultingSketches addObject:[[prevSavedJSON objectForKey:@"sketches"] objectAtIndex:[(NSMutableArray*)sketches indexOfObject:aSketch]]];
        
        NSLog(@"resultingSketches before is %@", resultingSketches);
      }
    }
    
    NSLog(@"resultingSketches is %@", resultingSketches);
    
    NSLog(@"prevSavedJsonSketches is %@", prevSavedJSON);
    
    resultingSketches = [prevSavedJSON valueForKey:@"sketches"];
    
    //NSLog(@"everySketch is %@", everySketch);
    
  }
  
  //[filemgr release];
  
  return [resultingSketches mutableCopy];
  
}
@end
