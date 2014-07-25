//
//  puzzle.h
//  WEEK3
//
//  Created by astomusic on 2014. 7. 24..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface puzzle : NSObject

struct position {
    int x;
    int y;
};

typedef struct position position;

@property (strong, nonatomic) NSMutableArray* board;
@property int size;
@property position zeroPos;

-(void)makeBoard:(int)number;
-(void)viewBoard;
-(void)shuffleBoard:(int)number;
-(void)inputKey;

@end
