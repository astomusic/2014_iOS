//
//  ITTableViewController.m
//  WEEK11
//
//  Created by astomusic on 2014. 9. 18..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITTableViewController.h"
#import <sqlite3.h>


@implementation ITTableViewController
{
    NSMutableArray * records;
    NSMutableArray * feeds;
    sqlite3* database;
    sqlite3* databaseforNewsFeed;
    
    NSMutableString* nowTagStr;
    NSMutableString* txtBuffer;
    NSMutableDictionary* feed;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString* documentsDirectory = [paths lastObject];
    NSString* databasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"top25.db"];
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        NSLog(@"Opened sqlite database at %@", databasePath);
        [self selectAll];
    } else {
        NSLog(@"Failed to open database at %@ with error %s", databasePath, sqlite3_errmsg(database));
        sqlite3_close (database);
    }
    
    feeds = [[NSMutableArray alloc]init];
    
    NSURL *myURL = [NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
	NSXMLParser *myParser = [[NSXMLParser alloc] initWithContentsOfURL:myURL];
    [myParser setDelegate:self];
    [myParser parse];
    
    NSLog(@"%@", feeds);
    NSString* databasePathforNewsFeed = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"newsfeed.db"];
    
    if(sqlite3_open([databasePathforNewsFeed UTF8String], &databaseforNewsFeed) == SQLITE_OK) {
        NSLog(@"Opened sqlite database at %@", databasePathforNewsFeed);
        [self insertAll];
    } else {
        NSLog(@"Failed to open database at %@ with error %s", databasePathforNewsFeed, sqlite3_errmsg(databaseforNewsFeed));
        sqlite3_close (databaseforNewsFeed);
    }
}

-(void) selectAll
{
    records =[[NSMutableArray alloc] init];
    sqlite3_stmt* stmt =NULL;

    NSString* query = @"SELECT * from tbl_songs";
    
    if((sqlite3_prepare(database, [query UTF8String], -1, &stmt, NULL) == SQLITE_OK)) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSNumber* id = [NSNumber numberWithInt:sqlite3_column_int(stmt, 0)];
            NSString* title = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 1)];
            NSString* category = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 2)];
            NSString* image = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 3)];
            
            NSDictionary *song =[[NSDictionary alloc] initWithObjectsAndKeys:id,@"id", title,@"title", category,@"category", image,@"image", nil];
            [records addObject:song];
        }
    }
}

-(void)insertAll
{
    int key = 0;
    int rc = 0;
    NSNumber *keyNumber;
    for(NSMutableDictionary* newfeed in feeds) {
        key++;
        keyNumber = [NSNumber numberWithInt:key];
        //http://stackoverflow.com/questions/5700488/insert-data-from-text-fields-into-sqlite-database
        NSString* query = [[NSString alloc]initWithFormat:@"INSERT INTO tbl_newsfeed values(%@, \"%@\", \"%@\", \"%@\", DATETIME('NOW'));", keyNumber, [newfeed objectForKey:@"title"], [newfeed objectForKey:@"link"],[newfeed objectForKey:@"description"]];
        NSLog(@"%@", query);
        char * errMsg;
        rc = sqlite3_exec(databaseforNewsFeed, [query UTF8String] ,NULL,NULL,&errMsg);
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to insert record  rc:%d, msg=%s",rc,errMsg);
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *object = records[indexPath.row];
    cell.textLabel.text = [object objectForKey:@"title"];
    cell.detailTextLabel.text = [object objectForKey:@"category"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *object = records[indexPath.row];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[object objectForKey:@"image"]]];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
	nowTagStr = [NSMutableString stringWithString:@""];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	if([elementName isEqualToString:@"item"]){
        feed = [[NSMutableDictionary alloc]init];
    }
    if([elementName isEqualToString:@"title"]){
		nowTagStr = [NSMutableString stringWithString:elementName];
		txtBuffer = [NSMutableString stringWithString:@""];
    }
    if([elementName isEqualToString:@"link"]){
        nowTagStr = [NSMutableString stringWithString:elementName];
		txtBuffer = [NSMutableString stringWithString:@""];
    }
    if([elementName isEqualToString:@"description"]){
        nowTagStr = [NSMutableString stringWithString:elementName];
		txtBuffer = [NSMutableString stringWithString:@""];
    }
    if([elementName isEqualToString:@"pubDate"]){
        nowTagStr = [NSMutableString stringWithString:elementName];
		txtBuffer = [NSMutableString stringWithString:@""];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	if ([nowTagStr isEqualToString:@"item"]) {}
    if ([nowTagStr isEqualToString:@"title"]) {
        [txtBuffer appendString:string];
    }
    if ([nowTagStr isEqualToString:@"link"]) {
        [txtBuffer appendString:string];
    }
    if ([nowTagStr isEqualToString:@"description"]) {
        [txtBuffer appendString:string];
    }
    if ([nowTagStr isEqualToString:@"pubDate"]) {
        [txtBuffer appendString:string];
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	if([elementName isEqualToString:@"item"]){
        [feeds addObject:feed];
    }
    if([elementName isEqualToString:@"title"]){
        [feed setObject:txtBuffer forKey:nowTagStr];
    }
    if([elementName isEqualToString:@"link"]){
        [feed setObject:txtBuffer forKey:nowTagStr];
    }
    if([elementName isEqualToString:@"description"]){
        [feed setObject:txtBuffer forKey:nowTagStr];
    }
    if([elementName isEqualToString:@"pubDate"]){
        [feed setObject:txtBuffer forKey:nowTagStr];
    }
}


@end
