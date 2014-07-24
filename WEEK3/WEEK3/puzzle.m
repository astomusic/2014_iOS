//
//  puzzle.m
//  WEEK3
//
//  Created by astomusic on 2014. 7. 24..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "puzzle.h"

@implementation puzzle

-(void)makeBoard:(int)number
{
    _board = [[NSMutableArray alloc]init];
    _size = number;
    int i, j;
    
    for(i =0 ; i < _size ; i++ ) {
        [_board addObject:[[NSMutableArray alloc]init]];
        for(j = 0 ; j < _size ; j++) {
            int value = (i*_size)+(j+1);
            if(value == _size*_size) {
                [_board[i] addObject:@0];
            } else {
                NSNumber *temp = [NSNumber numberWithInt:value];
                [_board[i] addObject:temp];
            }
        }
    }
    
    
    for(i =0 ; i < _size*_size ; i++ ) {
        [self shuffleBoard];
    }
    NSLog(@"%@", _board);
}

-(void)viewBoard
{
    NSMutableString* result = [[NSMutableString alloc]init];
    for(int i =0 ; i < _size ; i++ ) {
        for(int j =0 ; j < _size ; j++ ) {
            NSNumber* temp = _board[i][j];
            [result stringByAppendingFormat:@"%@", temp];
        }
        [result stringByAppendingString:@"\n"];
    }
    NSLog(@"view : %@", result);
    [result release];
}

-(void)shuffleBoard
{
    srand48(time(0));
    int r1 = arc4random() % _size;
    int r2 = arc4random() % _size;
    
    int r3 = arc4random() % _size;
    int r4 = arc4random() % _size;
    
    NSNumber* temp = _board[r1][r2];
    _board[r1][r2] = _board[r3][r4];
    _board[r3][r4] = temp;
}

-(void)inputKey
{
    int key;
    NSLog(@"input key");
    scanf("%i", &key);
    
    NSLog(@"%d",key);
}

@end
