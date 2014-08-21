//
//  ITMasterViewController.h
//  WEEK7
//
//  Created by astomusic on 2014. 8. 21..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ITDetailViewController;

@interface ITMasterViewController : UITableViewController <NSStreamDelegate>

@property (strong, nonatomic) ITDetailViewController *detailViewController;

@end
