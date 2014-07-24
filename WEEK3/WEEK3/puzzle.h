//
//  puzzle.h
//  WEEK3
//
//  Created by astomusic on 2014. 7. 24..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface puzzle : NSObject

@property (strong, nonatomic) NSMutableArray* board;
@property int size;


-(void)makeBoard:(int)number;
-(void)viewBoard;
-(void)shuffleBoard;
-(void)inputKey;

@end
