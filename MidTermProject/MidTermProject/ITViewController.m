//
//  ITViewController.m
//  MidTermProject
//
//  Created by astomusic on 2014. 8. 12..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITViewController.h"

@interface ITViewController ()

@end

@implementation ITViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"%@, %@, %@", _recipeDate, _recipeImage, _recipeTitle);
    
    _detailTitle.text = _recipeTitle;
    _detailDate.text = _recipeDate;
    UIImage *picture = [UIImage imageNamed:_recipeImage];
    [_detailImage setImage:picture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
