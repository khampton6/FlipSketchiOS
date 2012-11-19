//
//  FileIO.m
//  FlipSketch
//
//  Created by Brandon Headrick on 11/18/12.
//  Copyright (c) 2012 Kevin Hampton. All rights reserved.
//


/**
 for shapes; starting page/ending page
 for xformations: x, y, pagenum
 **/

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
  
  NSMutableArray *points = [NSMutableArray array];
  for (NSInteger i = 0; i < 4; i++)
    [points addObject:[NSNumber numberWithInteger:i]];
  
  NSArray *transformations = [[NSArray alloc]init];
  
  NSNumber *x1 = [NSNumber numberWithInt:10];
  NSNumber *y1 = [NSNumber numberWithInt:11];
  NSNumber *x2 = [NSNumber numberWithInt:20];
  NSNumber *y2 = [NSNumber numberWithInt:21];
  
  NSDictionary *shapeData = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"shapeType", points, @"points", x1, @"x1", y1, @"y1", x2, @"x2", y2, @"y2", @"greenString", @"color", @"trueBool", @"isShapeFilled", transformations, @"transformations", nil];
  
  NSArray *shapeDataArray = [[NSArray alloc] initWithObjects:shapeData, nil];
  
  NSDictionary *sketchData = [NSDictionary dictionaryWithObjectsAndKeys:@"001", @"id", shapeDataArray, @"pages", nil];
  
  NSArray *sketchArray = [[NSArray alloc] initWithObjects:sketchData, nil];
  
  NSDictionary *sketchWrapper = [[NSDictionary alloc] initWithObjectsAndKeys:sketchArray, @"sketch", nil];
  
  NSArray *sketchesArray = [[NSArray alloc] initWithObjects:sketchWrapper, nil];
  
  NSDictionary *sketchesWrapper = [[NSDictionary alloc] initWithObjectsAndKeys:sketchesArray, @"sketches", nil];
  
  NSError *writeError = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sketchesWrapper options:NSJSONWritingPrettyPrinted error:&writeError];
  
  // parse the JSON data into what is ultimately an NSDictionary
  NSError *parseError = nil;
  
  id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&parseError];
  
  //NSLog(@"\n%@",jsonObject);
  
  // test that the object we parsed is a dictionary - perhaps you would test for something different
  if ([jsonObject respondsToSelector:@selector(objectForKey:)]) {
    //    NSLog(@"Response: %@", [jsonObject objectForKey:@"id"]);
    //    NSLog(@"Token: %@", [jsonObject objectForKey:@"name"]);
    /*
     NSLog(@"Response1: %@", [jsonObject objectForKey:@"sketches"]);
     NSLog(@"Response2: %@", [[[jsonObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"]);
     NSLog(@"Response3: %@", [[[[jsonObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0]);
     NSLog(@"Response4: %@", [[[[[jsonObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"pages"]);
     
     NSLog(@"Response5: %@", [[[[[[jsonObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"pages"]objectAtIndex:0]);
     
     NSLog(@"Response6: %@", [[[[[[[jsonObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"pages"]objectAtIndex:0] objectForKey:@"transformations"]);
     
     
     
     
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
      // Read (load) file contents and display in textBox
      NSData *databuffer;
      databuffer = [filemgr contentsAtPath: dataFile];
      
      NSString *datastring = [[NSString alloc] initWithData: databuffer encoding:NSASCIIStringEncoding];
      
      
      //this puts the data into something
      //textBox.text = datastring;
      
      NSLog(@"this is the loaded stuff: %@",datastring);
      
      [datastring release];
    }
    
    [filemgr release];
    //[super viewDidLoad];
  }
  
  NSFileManager *filemgr;
  //NSData *databuffer;
  NSString *dataFile;
  NSString *docsDir;
  NSArray *dirPaths;
  
  filemgr = [NSFileManager defaultManager];
  
  dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  docsDir = [dirPaths objectAtIndex:0];
  
  dataFile = [docsDir stringByAppendingPathComponent: @"datafile.dat"];
  
  //set the data to a databuffer for saving
  //databuffer = [textBox.text dataUsingEncoding: NSASCIIStringEncoding];
  NSString *str;
  str = @"fdafd";
  
  //databuffer = [jsonObject dataUsingEncoding: NSASCIIStringEncoding];
  
  str = [jsonObject objectForKey:@"sketches"];
  
  //databuffer = [str dataUsingEncoding:NSUTF8StringEncoding];
  
  //NSLog(@"bleh is%@",str);
  
  //databuffer = str;
  
  [jsonData writeToFile:dataFile atomically:true];
  
  //databuffer = [jsonArray.description dataUsingEncoding: NSASCIIStringEncoding];
  
  //[filemgr createFileAtPath: dataFile contents: databuffer attributes:nil];
  
  //[filemgr release];
}

- (NSDictionary* )fetchedData:(NSData *)responseData {
  //parse out the json data
  NSError* error;
  NSDictionary    *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
  //process the JSON Foundation object to the view.
  [self processData:json];
  return json;
}

- (NSDictionary *)convertToJson:(NSData *)responseData {
  
  //parse out the json data
  NSError* error;
  NSDictionary    *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
  //process the JSON Foundation object to the view.
  return json;
  
}

- (void)processData:(NSDictionary *) JSONObject{
  NSString        *sketches = [JSONObject valueForKey:@"sketches"];
  NSString        *sketch    = [[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"];
  NSString        *pages = [[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"pages"]objectAtIndex:0];
  NSString        *transformations =[[[[[[[JSONObject objectForKey:@"sketches"] objectAtIndex:0] objectForKey:@"sketch"] objectAtIndex: 0] objectForKey:@"pages"]objectAtIndex:0] objectForKey:@"transformations"];
  NSLog(@"sketches: %@", sketches);
  NSLog(@"sketch: %@", sketch);
  NSLog(@"pages: %@",pages);
  NSLog(@"transformations: %@",transformations);
  
}


@end
