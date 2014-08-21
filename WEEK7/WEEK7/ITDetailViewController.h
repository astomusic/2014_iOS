//
//  ITDetailViewController.h
//  WEEK7
//
//  Created by astomusic on 2014. 8. 21..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITDetailViewController : UIViewController <UISplitViewControllerDelegate, NSStreamDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *DetailImage;

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
