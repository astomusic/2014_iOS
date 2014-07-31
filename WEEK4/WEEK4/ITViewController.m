//
//  ITViewController.m
//  WEEK4
//
//  Created by astomusic on 2014. 7. 31..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITViewController.h"

@interface ITViewController ()

@end

@implementation ITViewController
{
    ITModel* _myModel;
    int randomValue;
    NSArray* imageArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNotification:)
                                                 name:@"randomChanged-notification"
                                               object:nil];
    
    imageArray = [[NSArray alloc] initWithObjects:@"1.png", @"2.png", @"3.png", nil];
    
    _myModel = [[ITModel alloc] init];
    
    [_myModel addObserver:self forKeyPath:@"KVOrandom" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//
//    [_myModel randomize];
//    
//    UIImage *image = [UIImage imageNamed:imageArray[randomValue]];
//    _mainImage.image = image;
    
    
}

- (void)didReceiveNotification:(NSNotification *)notification
{
    NSString *message = [notification.userInfo objectForKey:@"randomValue"];
    NSLog(@"I've got the randomValue %@", message);
    randomValue = [message intValue];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [_myModel randomize];
        UIImage *image = [UIImage imageNamed:imageArray[randomValue]];
        _mainImage.image = image;
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (BOOL)canBecomeFirstResponder
{ return YES; }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context
{
    NSLog(@"%@, %@, %@, %@", keyPath, object, change, context);
    randomValue = [object KVOrandom];
    UIImage *image = [UIImage imageNamed:imageArray[randomValue]];
    _mainImage.image = image;
}

@end
