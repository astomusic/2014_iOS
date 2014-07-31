//
//  ITModel.m
//  WEEK4
//
//  Created by astomusic on 2014. 7. 31..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITModel.h"

@implementation ITModel

- (id)init
{
    self = [super init];
    return self;
}

- (void)randomize
{
    int random = arc4random() % 3;
    NSLog(@"%d", random);
    
    NSDictionary *userInfo = @{ @"randomValue": [NSNumber numberWithInt:random] };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"randomChanged-notification"
                                                        object:nil
                                                      userInfo:userInfo];
}

@end