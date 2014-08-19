//
//  ITModel.m
//  MidTermProject
//
//  Created by astomusic on 2014. 8. 12..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITModel.h"

@implementation ITModel
{
    NSMutableArray *jsonData;
    NSData* responseData;
    char* charData;
    Reachability* reachability;
    NSMutableDictionary* imageUrlKey;
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
        
        reachability = [Reachability reachabilityWithHostName:@"www.naver.com"];
        [reachability startNotifier];
    }
    
    return self;
}

- (void) handleNetworkChange:(NSNotification *)notice
{
    
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
        NSLog(@"no");
        [self initWithOffLine];
    }
    else if (remoteHostStatus == ReachableViaWiFi) {
        NSLog(@"wifi");
        [self initWithUrl];
    }
    else if (remoteHostStatus == ReachableViaWWAN) {
        NSLog(@"cell");
        [self initWithUrl];
    }
}

-(void) initWithUrl
{
    NSString *aURLString = @"http://125.209.194.123/json.php";
    NSURL *aURL = [NSURL URLWithString:aURLString];
    NSData* data = [NSData dataWithContentsOfURL:aURL];
    NSError *error;
    NSArray* temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    jsonData = [NSMutableArray arrayWithArray:temp];
    NSLog(@"%@", jsonData);
    
    [self completedLoad];
    
    imageUrlKey = [[NSMutableDictionary alloc]init];
    
    for(id item in jsonData) {
        NSString* imageUrl = [item objectForKey:@"image"];
        
        [imageUrlKey setValue:imageUrl forKey:imageUrl];
        
        NSURL *aURL = [NSURL URLWithString:imageUrl];
        NSURLRequest *aRequest = [NSURLRequest requestWithURL:aURL];
        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:aRequest delegate:self startImmediately:YES];
    }
}

-(void) initWithOffLine
{
    charData = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},\ {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},\ {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},\ {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},\ {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},\ {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},\ {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},\ {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},\ {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"},\ {\"title\":\"나비\",\"image\":\"10.jpg\",\"date\":\"20140218\"}]";

    int size = [self lengthOfData:charData];

    responseData = [NSData dataWithBytes:(const void *)charData length:sizeof(unsigned char)*size];

    NSError *error;
    NSArray* temp = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    jsonData = [NSMutableArray arrayWithArray:temp];
    NSLog(@"%@", jsonData);
    
    [self completedLoad];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:
(NSData *)data
{
    NSLog(@"didReceiveData");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
}

-(void)completedLoad
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"initData"
                                                        object:nil];
}

-(void)deletetAtIndex:(NSUInteger)index
{
    NSLog(@"deletetAtIndex");
    [jsonData removeObjectAtIndex:index];

}

-(void)sortByDate
{
    NSSortDescriptor *dateSoter = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *temp = [NSArray arrayWithObject:dateSoter];
    NSArray *sortedArray = [jsonData sortedArrayUsingDescriptors:temp];
    jsonData = [NSMutableArray arrayWithArray:sortedArray];
    NSLog(@"%@", jsonData);
    [self completedLoad];
}
-(int)lengthOfData:(char*)str
{
    int i = 0;
    
    while(*(str++)){
    	i++;
    	if(i == INT_MAX)
    	    return -1;
    }
    
    return i;
}

-(NSInteger)numberOfData
{
    return [jsonData count];
}

-(NSDictionary*)objectAtIndex:(NSUInteger)index
{
    return jsonData[index];
}

@end
