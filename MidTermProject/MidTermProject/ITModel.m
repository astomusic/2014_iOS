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
    NSArray *jsonData;
    char* charData;
}

- (id)init
{
    self = [super init];
    if (self) {
        charData = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},\ {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},\ {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},\ {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},\ {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},\ {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},\ {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},\ {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},\ {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"},\ {\"title\":\"나비\",\"image\":\"10.jpg\",\"date\":\"20140218\"}]";
        
        int size = [self lengthOfData:charData];

        NSData* data = [NSData dataWithBytes:(const void *)charData length:sizeof(unsigned char)*size];
        
        NSError *error;
        jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"%@", jsonData);
    }
    
    return self;
}

-(void)completedLoad
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"initData"
                                                        object:nil];
}

-(void)sortByDate
{
    NSSortDescriptor *dateSoter = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *temp = [NSArray arrayWithObject:dateSoter];
    NSArray *sortedArray = [jsonData sortedArrayUsingDescriptors:temp];
    jsonData = sortedArray;
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
