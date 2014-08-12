//
//  ITViewController.h
//  MidTermProject
//
//  Created by astomusic on 2014. 8. 12..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITViewController : UIViewController
@property (weak, nonatomic) NSString *recipeTitle;
@property (weak, nonatomic) NSString *recipeDate;
@property (weak, nonatomic) NSString *recipeImage;

@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *detailDate;


@end
