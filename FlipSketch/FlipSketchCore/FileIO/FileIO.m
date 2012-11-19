//
//  FileIO.m
//  FlipSketch
//
//  Created by Brandon Headrick on 11/18/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//

#import "FileIO.h"

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

- (void)saveData
{
  
  NSLog(@"in Save");
  
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
  
  NSDictionary *sketchData = [NSDictionary dictionaryWithObjectsAndKeys:@"NamedSketch", @"name", @"ThisDescription", @"desc", @"001", @"id", shapeDataArray, @"pages", nil];
  
  NSArray *sketchDataArray = [[NSArray alloc] initWithObjects:sketchData, nil];
  
  NSDictionary *sketchWrapper = [[NSDictionary alloc] initWithObjectsAndKeys:sketchDataArray, @"sketch", nil];
  
  NSArray *sketchesArray = [[NSArray alloc] initWithObjects:sketchWrapper, nil];
  
  NSDictionary *sketchesWrapper = [[NSDictionary alloc] initWithObjectsAndKeys:sketchesArray, @"sketches", nil];
  
  NSError *writeError = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sketchesWrapper options:NSJSONWritingPrettyPrinted error:&writeError];
  
  NSFileManager *filemgr;
  //NSData *databuffer;
  NSString *dataFile;
  NSString *docsDir;
  NSArray *dirPaths;
  
  filemgr = [NSFileManager defaultManager];
  
  dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  docsDir = [dirPaths objectAtIndex:0];
  
  dataFile = [docsDir stringByAppendingPathComponent: @"datafile.dat"];
  
  [jsonData writeToFile:dataFile atomically:true];
  
}


- (void)processData:(NSDictionary *) JSONObject{
  NSString        *sketches = [JSONObject valueForKey:@"sketches"];
  NSString        *sketch    = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"];
  NSString        *pages = [[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"pages"]objectAtIndex:0];
  NSString        *transformations =[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"pages"]objectAtIndex:0] objectForKey:@"trans"];
  NSLog(@"sketches: %@", sketches);
  /*
  NSLog(@"sketch: %@", sketch);
  NSLog(@"pages: %@",pages);
  NSLog(@"trans: %@",transformations);
   */
  
}


@end
