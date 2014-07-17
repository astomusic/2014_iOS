//
//  JsonParser.h
//  WEEK2
//
//  Created by astomusic on 2014. 7. 17..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject

-(NSString*)MakeJson:(id) data;
-(id)JsonParsing:(NSString*) data;

-(NSString*)ArrayToJson:(NSArray *) data;
-(NSString*)DicToJson:(NSDictionary *) data;
-(NSArray*)JsonToArray:(NSString*) json;
-(NSDictionary*)JsonToDic:(NSString*) json;

@end
