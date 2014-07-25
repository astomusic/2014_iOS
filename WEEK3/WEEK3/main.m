//
//  main.m
//  WEEK3
//
//  Created by astomusic on 2014. 7. 24..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "puzzle.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {

        puzzle* p = [[puzzle alloc]init];
        [p makeBoard:3];
        [p viewBoard];
        
        [p inputKey];
        
        [p release];
    }
    
    return 0;
}

