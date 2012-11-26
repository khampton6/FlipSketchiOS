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
  /*
  NSMutableArray *points = [NSMutableArray array];
  for (NSInteger i = 0; i < 4; i++)
    [points addObject:[NSNumber numberWithInteger:i]];
  
  //NSArray *transDataArray = [[NSArray alloc]init];
  
  NSNumber *x1 = [NSNumber numberWithInt:10];
  NSNumber *y1 = [NSNumber numberWithInt:11];
  NSNumber *x2 = [NSNumber numberWithInt:20];
  NSNumber *y2 = [NSNumber numberWithInt:21];
  
  NSNumber *tX = [NSNumber numberWithInt:40];
  NSNumber *tY = [NSNumber numberWithInt:41];
  NSNumber *tPageNum = [NSNumber numberWithInt:1];
  
  NSNumber *sPage = [NSNumber numberWithInt:0];
  NSNumber *ePage = [NSNumber numberWithInt:2];
  
  NSDictionary *transData = [NSDictionary dictionaryWithObjectsAndKeys:tX, @"xPos", tY, @"yPos", tPageNum, @"pageNum", nil];
  NSArray *transDataArray = [[NSArray alloc] initWithObjects:transData, nil];
  
  NSDictionary *shapeData = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"shapeType", points, @"points", x1, @"x1", y1, @"y1", x2, @"x2", y2, @"y2", @"greenString", @"color", @"trueBool", @"isShapeFilled", transDataArray, @"trans", sPage, @"startingPage", ePage, @"endingPage", nil];
  
  NSArray *shapeDataArray = [[NSArray alloc] initWithObjects:shapeData, nil];
  
  NSDictionary *sketchData = [NSDictionary dictionaryWithObjectsAndKeys:@"NamedSketch", @"name", @"ThisDescription", @"desc", @"001", @"id", shapeDataArray, @"shapesData", nil];
  
  NSArray *sketchDataArray = [[NSArray alloc] initWithObjects:sketchData, nil];
  
  NSDictionary *sketchWrapper = [[NSDictionary alloc] initWithObjectsAndKeys:sketchDataArray, @"sketch", nil];
  
  NSArray *sketchesArray = [[NSArray alloc] initWithObjects:sketchWrapper, nil];
  
  NSDictionary *sketchesWrapper = [[NSDictionary alloc] initWithObjectsAndKeys:sketchesArray, @"sketches", nil];
  */
  //NSError *writeError = nil;
  //NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sketchesWrapper options:NSJSONWritingPrettyPrinted error:&writeError];
  
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
  /*
  NSLog(@"sketch: %@", sketch);
  NSLog(@"pages: %@",pages);
  NSLog(@"trans: %@",transformations);
   */
  
  //NSLog(@"sketch 0%@", sketches);
  
  //NSLog(@"sketch 0%@", shapesData);

  //int l = [[JSONObject valueForKey:@"sketches"] length];
  
  //NSLog(@"%d",l);
  
  
  

  for (NSString *theSketches in sketches) {
  
    
    //NSString *theSketch = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"];
    
    NSString *theSketch = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"];
  
    NSString *theDesc = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"desc"];
    
    NSString *theId = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"id"];
    
    NSString *theName = [[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"name"];
    
    //NSString        *theSketch    = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"];
    
    //NSLog(@"theSketch is %@", theSketch);
    NSLog(@"theDesc is %@", theDesc);
    NSLog(@"theId is %@", theId);
    NSLog(@"theName is %@", theName);
    
    for (NSString *theShapesData in shapesData) {
      //NSString *theShapes = [[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[shapesData indexOfObject:theShapesData]];
      NSString *theShapes = [[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[shapesData indexOfObject:theShapesData]];
      
      NSString *theColor = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[shapesData indexOfObject:theShapesData]] objectForKey:@"color"];
      
      NSString *theStartingpage = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[shapesData indexOfObject:theShapesData]] objectForKey:@"startingPage"];
      
      NSString *theEndingPage = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[shapesData indexOfObject:theShapesData]] objectForKey:@"endingPage"];
      
      NSString *theIsShapeFilled = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[shapesData indexOfObject:theShapesData]] objectForKey:@"isShapeFilled"];
      
      NSString *thePoints = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[shapesData indexOfObject:theShapesData]] objectForKey:@"points"];
      
      NSString *theShapeType = [[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:[sketches indexOfObject:theSketches]] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"shapesData"]objectAtIndex:[shapesData indexOfObject:theShapesData]] objectForKey:@"shapeType"];
      
      //NSLog(@"theShapes is %@", theShapes);
      NSLog(@"theColor is %@", theColor);
      NSLog(@"theStartingPage is %@", theStartingpage);
      NSLog(@"theEndingpage is %@", theEndingPage);
      NSLog(@"theIsShapeFilled is %@", theIsShapeFilled);
      NSLog(@"thePoints is %@", thePoints);
      NSLog(@"theShapeType is %@", theShapeType);
      
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
  /*NSMutableArray *points = [NSMutableArray array];
  for (NSInteger i = 0; i < 4; i++)
    [points addObject:[NSNumber numberWithInteger:i]];
  
  //NSArray *transDataArray = [[NSArray alloc]init];
  
  NSNumber *x1 = [NSNumber numberWithInt:10];
  NSNumber *y1 = [NSNumber numberWithInt:11];
  NSNumber *x2 = [NSNumber numberWithInt:20];
  NSNumber *y2 = [NSNumber numberWithInt:21];
  
  NSNumber *tX = [NSNumber numberWithInt:40];
  NSNumber *tY = [NSNumber numberWithInt:41];
  NSNumber *tPageNum = [NSNumber numberWithInt:1];
  
  NSNumber *sPage = [NSNumber numberWithInt:0];
  NSNumber *ePage = [NSNumber numberWithInt:2];
  
  NSDictionary *transData = [NSDictionary dictionaryWithObjectsAndKeys:tX, @"xPos", tY, @"yPos", tPageNum, @"pageNum", nil];
  NSArray *transDataArray = [[NSArray alloc] initWithObjects:transData, nil];
  
  NSDictionary *shapeData = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"shapeType", points, @"points", x1, @"x1", y1, @"y1", x2, @"x2", y2, @"y2", @"greenString", @"color", @"trueBool", @"isShapeFilled", transDataArray, @"trans", sPage, @"startingPage", ePage, @"endingPage", nil];
  
  NSArray *shapeDataArray = [[NSArray alloc] initWithObjects:shapeData, nil];
  
  NSDictionary *sketchData = [NSDictionary dictionaryWithObjectsAndKeys:@"NamedSketch", @"name", @"thisNewDesc", @"desc", @"001", @"id", shapeDataArray, @"shapesData", nil];
  
  NSArray *sketchDataArray = [[NSArray alloc] initWithObjects:sketchData, nil];
  
  NSDictionary *sketches = [[NSDictionary alloc] initWithObjectsAndKeys:sketchDataArray, @"sketch", nil];
  
  NSArray *sketchesArray = [[NSArray alloc] initWithObjects:sketches, nil];
  
  NSDictionary *sketchesWrapper = [[NSDictionary alloc] initWithObjectsAndKeys:sketchesArray, @"sketches", nil];
  
  NSError *writeError = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sketchesWrapper options:NSJSONWritingPrettyPrinted error:&writeError];
  
  //NSLog( @" in AddSketchToJson%@", jsonData);
  
  return jsonData;
   */
  
  NSMutableArray *points = [NSMutableArray array];
  for (NSInteger i = 0; i < 4; i++)
    [points addObject:[NSNumber numberWithInteger:i]];
  
  //NSArray *transDataArray = [[NSArray alloc]init];
  
  NSNumber *x1 = [NSNumber numberWithInt:10];
  NSNumber *y1 = [NSNumber numberWithInt:11];
  NSNumber *x2 = [NSNumber numberWithInt:20];
  NSNumber *y2 = [NSNumber numberWithInt:21];
  
  NSNumber *tX = [NSNumber numberWithInt:40];
  NSNumber *tY = [NSNumber numberWithInt:41];
  NSNumber *tPageNum = [NSNumber numberWithInt:1];
  
  NSNumber *sPage = [NSNumber numberWithInt:0];
  NSNumber *ePage = [NSNumber numberWithInt:2];
  
  NSDictionary *transData = [NSDictionary dictionaryWithObjectsAndKeys:tX, @"xPos", tY, @"yPos", tPageNum, @"pageNum", nil];
  NSMutableArray *transDataArray = [[NSMutableArray alloc] initWithObjects:transData, nil];
  
  NSDictionary *shapeData = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"shapeType", points, @"points", x1, @"x1", y1, @"y1", x2, @"x2", y2, @"y2", @"greenString", @"color", @"trueBool", @"isShapeFilled", transDataArray, @"trans", sPage, @"startingPage", ePage, @"endingPage", nil];
  
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
  
  NSDictionary *transDatab = [NSDictionary dictionaryWithObjectsAndKeys:tXb, @"xPos", tYb, @"yPos", tPageNumb, @"pageNum", nil];
  NSMutableArray *transDataArrayb = [[NSMutableArray alloc] initWithObjects:transDatab, nil];
  
  NSDictionary *shapeDatab = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"shapeType", points, @"points", x1b, @"x1", y1b, @"y1", x2b, @"x2", y2b, @"y2", @"greenStringB", @"color", @"trueBool", @"isShapeFilled", transDataArrayb, @"trans", sPageb, @"startingPage", ePageb, @"endingPage", nil];
  
  NSMutableArray *shapeDataArrayb = [[NSMutableArray alloc] initWithObjects:shapeDatab, nil];
  
  NSDictionary *sketchDatab = [NSDictionary dictionaryWithObjectsAndKeys:@"NamedSketchb", @"name", @"thisNewDescb", @"desc", @"001b", @"id", shapeDataArrayb, @"shapesData", nil];
  
  NSMutableArray *sketchDataArrayb = [[NSMutableArray alloc] initWithObjects:sketchDatab, nil];
  
  //[sketchDataArray addObject:sketchDatab];
  
  NSDictionary *sketchesb = [[NSDictionary alloc] initWithObjectsAndKeys:sketchDataArrayb, @"sketch", nil];
  
  //NSMutableArray *sketchesArrayb = [[NSMutableArray alloc] initWithObjects:sketches, nil];
  
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
