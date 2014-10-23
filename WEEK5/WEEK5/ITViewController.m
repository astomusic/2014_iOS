//
//  ITViewController.m
//  WEEK5
//
//  Created by astomusic on 2014. 8. 7..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITViewController.h"

@interface ITViewController ()

@end

@implementation ITViewController
{
    NSMutableArray *imageArray;
    NSMutableArray *imageViewArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	imageArray = [[NSMutableArray alloc]init];
    imageViewArray = [[NSMutableArray alloc]init];
    
    for(int i=1 ; i < 23 ; i++) {
        NSMutableString *fileName = [[NSMutableString alloc]init];
        NSString *number = [NSString stringWithFormat:@"%02d", i];
        [fileName appendString:number];
        [fileName appendString:@".jpg"];
        
        [imageArray addObject:fileName];
    }
    
    for(int i=0; i<22 ; i++) {
        [imageViewArray insertObject:[NSNull null] atIndex:i];
    }
    
    _scrollview.contentSize = CGSizeMake(_scrollview.frame.size.width, _scrollview.frame.size.height * [imageArray count]);
    
    for (int i = 0 ; i < 2 ; i++) {
        CGRect rect;
        rect.origin.x = 0;
        rect.origin.y = self.scrollview.frame.size.height * i;
        rect.size = self.scrollview.frame.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        
        [imageViewArray replaceObjectAtIndex:i withObject:imageView];
        
        [self.scrollview addSubview:imageView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f", [self.scrollview contentOffset].y);
    
    int num = [self.scrollview contentOffset].y / _scrollview.frame.size.height;
    int max = num+1>[imageArray count]?(int)[imageArray count]:num+1;
    int min = num-1<0?0:num-1;
    
    NSLog(@"%d", num);
    
    [self setImageViewToScollView:min to:max];
}

- (void)setImageViewToScollView:(int)start to:(int)end
{
    for(int i=0; i<[imageArray count]; i++) {
        [imageViewArray objectAtIndex:i];
        if(i <= end && i >= start) {
            CGRect rect;
            rect.origin.x = 0;
            rect.origin.y = self.scrollview.frame.size.height * i;
            rect.size = self.scrollview.frame.size;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
            imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
            
            [imageViewArray replaceObjectAtIndex:i withObject:imageView];
            
            [self.scrollview addSubview:imageView];
        } else {
            if([[imageViewArray objectAtIndex:i] isKindOfClass:[UIImageView class]]){
                [[imageViewArray objectAtIndex:i] removeFromSuperview];
                [imageViewArray replaceObjectAtIndex:i withObject:[NSNull null]];
            }
        }
    }
    
    NSLog(@"%@", imageViewArray);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
