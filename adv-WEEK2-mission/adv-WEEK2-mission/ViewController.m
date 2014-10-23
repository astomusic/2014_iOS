//
//  ViewController.m
//  adv-WEEK2-mission
//
//  Created by astomusic on 10/23/14.
//  Copyright (c) 2014 NEXT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView *imageView;
    CGPoint center;
    CGPoint initPosition;
    CGPoint lastCenterPosition;
    float boxSize;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    boxSize = 100;
    float width = self.view.bounds.size.width;
    float height = self.view.bounds.size.height;
    
    center.x = (width)/2;
    center.y = (height)/2;
    
    initPosition.x = center.x-(boxSize/2);
    initPosition.y = center.y-(boxSize/2);
    
    lastCenterPosition = center;
    
    CGRect box = CGRectMake(initPosition.x,initPosition.y,boxSize,boxSize);
    imageView = [[UIImageView alloc] initWithFrame:box];
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:panRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(tapGesture:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapRecognizer];
    
    UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [self.view addGestureRecognizer:pinchRecognizer];
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        NSLog(@"shake");
        imageView.center =  center;
        lastCenterPosition = center;
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)panGesture:(UIPanGestureRecognizer*)rec {
    CGPoint trans = [rec translationInView:self.view];
    trans.x = trans.x + lastCenterPosition.x;
    trans.y = trans.y + lastCenterPosition.y;
    NSLog(@"%f", trans.x);
    NSLog(@"%f", trans.y);
    imageView.center = trans;
    if (rec.state == UIGestureRecognizerStateEnded){
        imageView.center =  center;
        lastCenterPosition = center;
    }
}

- (void)tapGesture:(UITapGestureRecognizer*)rec {
    if (rec.state == UIGestureRecognizerStateEnded){
        NSLog(@"tap");
        imageView.center = [rec locationInView:self.view];
        lastCenterPosition = [rec locationInView:self.view];
    }
}

- (void)pinchGesture:(UIPinchGestureRecognizer*)rec {
    NSLog(@"pinch");
    NSLog(@"%f",rec.scale);
    int newboxSize = boxSize*rec.scale;
    CGRect rect = CGRectMake(lastCenterPosition.x-(newboxSize/2),lastCenterPosition.y-(newboxSize/2),newboxSize,newboxSize);
    [imageView setFrame:rect];
    if (rec.state == UIGestureRecognizerStateEnded){
        CGRect box = CGRectMake(lastCenterPosition.x-boxSize/2,lastCenterPosition.y-boxSize/2,boxSize,boxSize);
        [imageView setFrame:box];
    }
}


@end
