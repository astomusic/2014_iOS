//
//  ViewController.m
//  adv-WEEK3
//
//  Created by astomusic on 10/30/14.
//  Copyright (c) 2014 NEXT. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)button:(id)sender {
    UIStoryboard* secondStoryBoard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    SecondViewController* secondViewController = [secondStoryBoard instantiateViewControllerWithIdentifier:@"second"];
    
    [self presentViewController:secondViewController animated:NO completion:nil];
}

@end
