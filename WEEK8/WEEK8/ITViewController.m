//
//  ITViewController.m
//  WEEK8
//
//  Created by astomusic on 2014. 8. 26..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITViewController.h"
#import "ITBarGraphView.h"
#import "ITPieGraphView.h"

@interface ITViewController ()
@property (weak, nonatomic) IBOutlet ITBarGraphView *BarGraphView;
@property (weak, nonatomic) IBOutlet ITPieGraphView *PieGraphView;

@end

@implementation ITViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    char* rawdata = "[{\"title\":\"April\", \"value\":5},{\"title\":\"May\", \"value\":12},{\"title\":\"June\", \"value\":18},{\"title\":\"July\",\"value\":11},{\"title\":\"August\", \"value\":15},{\"title\":\"September\", \"value\":9},{\"title\":\"October\",\"value\":17},{\"title\":\"November\", \"value\":25},{\"title\":\"December\", \"value\":31}]";
    
    int size = [self lengthOfData:rawdata];
    
    NSData* responseData = [NSData dataWithBytes:(const void *)rawdata length:sizeof(unsigned char)*size];
    
    NSError *error;
    NSArray* temp = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSMutableArray* jsonData = [NSMutableArray arrayWithArray:temp];
    
    _BarGraphView.jsonData = jsonData;
    _PieGraphView.jsonData = jsonData;
}

-(int)lengthOfData:(char*)str
{
    int i = 0;
    
    while(*(str++)){
    	i++;
    	if(i == INT_MAX)
    	    return -1;
    }
    
    return i;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
