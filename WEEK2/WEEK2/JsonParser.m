//
//  JsonParser.m
//  WEEK2
//
//  Created by astomusic on 2014. 7. 17..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "JsonParser.h"

@implementation JsonParser

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
         NSLog(@"%@",data);
        
        NSRange range  = [ data rangeOfString:@" " ];
        [data deleteCharactersInRange:range];
    }
    
//    NSRange openBracket = [json rangeOfString:@"\""];
//    NSRange closeBracket = [json rangeOfString:@"\""];
//    NSRange numberRange = NSMakeRange(openBracket.location + 1, closeBracket.location - openBracket.location - 1);
//    NSString *numberString = [json substringWithRange:numberRange];
//    
//    NSLog(@"%@",numberString);
    
    return result;
}

@end
