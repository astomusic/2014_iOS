//
//  main.m
//  WEEK2
//
//  Created by astomusic on 2014. 7. 17..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonParser.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        JsonParser *parser = [[JsonParser alloc]init];
        //target
        NSString *test0 = @"{ \"id\":007, \"name\":\"james\", \"weapons\":[ \"gun\", \"pen\" ] }";
        NSString *test1 = @"[ { \"id\": \"001\", \"name\" : \"john\" },{ \"id\": \"007\", \"name\" : \"james\" } ]";
        
        //NSArray to Json String
        NSArray *test2 = @[@"id", @"name", @"weapons"];
        NSString *result2 = [parser ArrayToJson:test2];
        NSLog(@"%@",result2);
        
        //NSDictionary to Json String
        NSDictionary *test3 = @{@"id" : @"007",@"name" : @"james"};
        NSString *result3 = [parser DicToJson:test3];
        NSLog(@"%@",result3);
        
        
        NSString *test4 = @"[ \"gun\", \"pen\" ]";
        NSArray *result4 = [parser JsonToArray:test4];
        NSLog(@"%@",result4);
        
    return 0;
        
    }
}

