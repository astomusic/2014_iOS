//
//  MyView.m
//  adv-WEEK2
//
//  Created by astomusic on 10/23/14.
//  Copyright (c) 2014 NEXT. All rights reserved.
//

#import "MyView.h"
#import "MyGestureRecognizer.h"

@implementation MyView
{
    float start_x;
    float start_y;
    UIColor* bg_color;
}
- (id)initWithCoder:(NSCoder *)aCoder{
    if(self = [super initWithCoder:aCoder]){
        NSLog(@"init");
        bg_color = [UIColor redColor];
        self.backgroundColor = bg_color;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(respondToTapGesture:)];
        // Specify that the gesture must be a single tap
        tapRecognizer.numberOfTapsRequired = 1;
        tapRecognizer.numberOfTouchesRequired = 3;
        // Add the tap gesture recognizer to the view
        [self addGestureRecognizer:tapRecognizer];
        
        MyGestureRecognizer *vTapRecognizer = [[MyGestureRecognizer alloc]initWithTarget:self action:@selector(respondToVTapGesture:)];
        [self addGestureRecognizer:vTapRecognizer];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    start_x = touchLocation.x;
    start_y = touchLocation.y;
    if ([[event touchesForView:self] count] == 2) {
        
        NSLog(@"began two");
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    float alpha = [self gapToAlpha:touchLocation.x withY:touchLocation.y];
    [self setBackgroundColor:[bg_color colorWithAlphaComponent:alpha]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesEnded");
    if ([[event touchesForView:self] count] == 2) {
        bg_color = [self randomColor];
        self.backgroundColor = bg_color;
        NSLog(@"end two");
    } else {
        [self setBackgroundColor:[bg_color colorWithAlphaComponent:1.0]];
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesCancelled");
}

- (float)gapToAlpha:(float)x withY:(float)y {
    float gap_x = start_x - x;
    float gap_y = start_y - y;
    float gap = gap_x*gap_x + gap_y*gap_y;
    NSLog(@"%f", gap);
    float alpha = 90880/(90880+gap);
    return alpha;
}

-(UIColor*) randomColor
{
    CGFloat red = ( arc4random() % 256 / 256.0 );
    CGFloat green = ( arc4random() % 256 / 256.0 );
    CGFloat blue = ( arc4random() % 256 / 256.0 );
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    NSLog(@"%f", red);
    return color;
}

- (void)respondToTapGesture:(UITapGestureRecognizer*)rec {
    if (rec.state == UIGestureRecognizerStateEnded){
        bg_color = [UIColor grayColor];
        self.backgroundColor = bg_color;
    }
}

- (void)respondToVTapGesture:(MyGestureRecognizer*)rec {
    if (rec.state == UIGestureRecognizerStateRecognized){
        NSLog(@"vtap");
        bg_color = [UIColor blackColor];
        self.backgroundColor = bg_color;
    }
}

@end
