//
//  JsonParser.m
//  WEEK2
//
//  Created by astomusic on 2014. 7. 17..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "JsonParser.h"

@implementation JsonParser

-(id)init
{
    self = [super init];
    return self;
}

-(NSString*)MakeJson:(id) data
{
    NSMutableString* result = [[NSMutableString alloc]init];
    if([data isKindOfClass:[NSArray class]]){
        //Is array
    }else if([data isKindOfClass:[NSDictionary class]]){
        //is dictionary
    }else{
        //is something else
    }
    
    return result;
}

-(id)JsonParsing:(NSString*) data
{
    id result;
    //NSRange temp = [data rangeOfString:@"{"];
    NSString* firstChar =[data substringToIndex:1];
    
    NSDictionary *resultDic;
    NSArray *resultArray;
    
    if([firstChar isEqualToString:@"{"]) {
        NSLog(@"dic");
        NSRange openBracket = [data rangeOfString:@"["];
        NSRange closeBracket = [data rangeOfString:@"]"];
        NSRange numberRange = NSMakeRange(openBracket.location, closeBracket.location - openBracket.location + 1);
        NSString *numberString = [data substringWithRange:numberRange];
        
        NSArray* temp = [self JsonToArray:numberString];
        data = [data stringByReplacingCharactersInRange:numberRange withString:@"@"];
        
        resultDic = [self JsonToDic:data];
        
        for(id key in resultDic){
            if([[resultDic objectForKey:key] isEqualToString:@"@"]) {
                [resultDic setValue:temp forKey:key];
            }
        }
        return resultDic;
    } else if([firstChar isEqualToString:@"["]) {
        NSLog(@"array");
        resultArray = [self JsonToArray:data];
        return resultArray;
    }

    
    return result;
}

-(NSString*)ArrayToJson:(NSArray *) data
{
    NSMutableString* result = [[NSMutableString alloc]init];
    [result appendString:@"["];
    for (id object in data) {
        [result appendString:@"\""];
        [result appendString:object];
        [result appendString:@"\""];
        [result appendString:@","];
    }

    [result deleteCharactersInRange:NSMakeRange([result length]-1, 1)];
    [result appendString:@"]"];
    return result;
}

-(NSString*)DicToJson:(NSDictionary *) data
{
    NSMutableString* result = [[NSMutableString alloc]init];
    [result appendString:@"{"];
    
    for(id key in data){
        [result appendString:@"\""];
        [result appendString:key];
        [result appendString:@"\":\""];
        [result appendString:[data objectForKey:key]];
        [result appendString:@"\""];
        [result appendString:@","];
    }
    
    [result deleteCharactersInRange:NSMakeRange([result length]-1, 1)];
    [result appendString:@"}"];
    return result;
}

-(NSArray*)JsonToArray:(NSString*) json
{
    NSMutableArray* result = [[NSMutableArray alloc]init];
    
    NSMutableString* tempjson = [NSMutableString stringWithString:json];
    
    NSArray *components = [tempjson componentsSeparatedByString: @","];
    
    for(id data in components){
        NSString* temp = [NSString stringWithString:data];
        temp = [temp stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@" " withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"[" withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"]" withString:@""];
        
        [result addObject:temp];
    }
    return result;
}

-(NSDictionary*)JsonToDic:(NSString*) json
{
    NSMutableDictionary* result = [[NSMutableDictionary alloc]init];
    
    NSMutableString* tempjson = [NSMutableString stringWithString:json];
    
    NSArray *components = [tempjson componentsSeparatedByString: @","];
    
    for(id data in components){
        NSString* temp = [NSString stringWithString:data];
        temp = [temp stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@" " withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"{" withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"}" withString:@""];
        
        NSArray *keyValue = [temp componentsSeparatedByString: @":"];
        [result setObject:keyValue[1] forKey:keyValue[0]];
    }
    return result;
}

@end
