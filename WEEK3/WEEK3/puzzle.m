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
    
    
    [self shuffleBoard:9];
    [self getZeroPos];
    
    NSLog(@"%d %d", _zeroPos.x, _zeroPos.y);
}

-(void)viewBoard
{
    NSMutableString* result = [[NSMutableString alloc]init];
    for(int i =0 ; i < _size ; i++ ) {
        for(int j =0 ; j < _size ; j++ ) {
            NSNumber* temp = _board[i][j];
            [result appendFormat:@"%@", temp];
        }
        [result appendString:@"\n"];
    }
    NSLog(@"<view>\n%@", result);
    [result release];
}

-(void)shuffleBoard:(int)number
{
    srand48(time(0));
    position pos1;
    position pos2;
    for(int i =0 ; i < number ; i++ ) {
        pos1.x = arc4random() % _size;
        pos1.y = arc4random() % _size;
        
        pos2.x = arc4random() % _size;
        pos2.y = arc4random() % _size;
        
        [self swapPositon:pos1 with:pos2];
    }
    
}

-(void)swapPositon:(struct position)pos1 with:(struct position)pos2
{
    NSNumber* temp = _board[pos1.x][pos1.y];
    _board[pos1.x][pos1.y] = _board[pos2.x][pos2.y];
    _board[pos2.x][pos2.y] = temp;
}

-(void)getZeroPos
{
    for(int i =0 ; i < _size ; i++ ) {
        for(int j =0 ; j < _size ; j++ ) {
            if([_board[i][j] isEqualToNumber:@0]) {
                _zeroPos.x = i;
                _zeroPos.y = j;
            }
        }
    }
}

-(void)inputKey
{
    char key;
    NSString* result;
    
    while(1) {
        NSLog(@"input key");
        scanf("%1s", &key);
        result = [NSString stringWithUTF8String:&key];
        result = [result lowercaseString];
        
        if([result isEqualToString:@"q"]) break;
        if([result isEqualToString:@"w"]) [self pressKeyUp];
        else if([result isEqualToString:@"a"]) [self pressKeyLeft];
        else if([result isEqualToString:@"s"]) [self pressKeyDown];
        else if([result isEqualToString:@"d"]) [self pressKeyRight];
        else NSLog(@"wrong key");
    }
    
}

-(void)pressKeyUp
{
    if(_zeroPos.x == _size-1) {
        return;
    } else {
        position pos;
        pos.x = _zeroPos.x + 1;
        pos.y = _zeroPos.y;
        [self swapPositon:pos with:_zeroPos];
        _zeroPos = pos;
    }
    [self viewBoard];
}

-(void)pressKeyDown
{
    if(_zeroPos.x == 0) {
        return;
    } else {
        position pos;
        pos.x = _zeroPos.x - 1;
        pos.y = _zeroPos.y;
        [self swapPositon:pos with:_zeroPos];
        _zeroPos = pos;
    }
    [self viewBoard];
}

-(void)pressKeyLeft
{
    if(_zeroPos.y == _size-1) {
        return;
    } else {
        position pos;
        pos.x = _zeroPos.x;
        pos.y = _zeroPos.y + 1;
        [self swapPositon:pos with:_zeroPos];
        _zeroPos = pos;
    }
    [self viewBoard];
}

-(void)pressKeyRight
{
    if(_zeroPos.y == 0) {
        return;
    } else {
        position pos;
        pos.x = _zeroPos.x;
        pos.y = _zeroPos.y - 1;
        [self swapPositon:pos with:_zeroPos];
        _zeroPos = pos;
    }
    [self viewBoard];
}

@end
