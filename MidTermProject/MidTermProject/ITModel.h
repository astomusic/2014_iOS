//
//  ITModel.h
//  MidTermProject
//
//  Created by astomusic on 2014. 8. 12..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface ITModel : NSObject <NSURLConnectionDataDelegate>

-(NSInteger)numberOfData;
-(NSDictionary*)objectAtIndex:(NSUInteger)index;
-(void)deletetAtIndex:(NSUInteger)index;
-(void)completedLoad;
-(void)sortByDate;

@end
