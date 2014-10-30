//
//  CalendarViewController.m
//  adv-WEEK3
//
//  Created by astomusic on 10/30/14.
//  Copyright (c) 2014 NEXT. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()
{
    float buttonSize;
    NSArray* week;
    NSCalendar *cal;
}
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    buttonSize = self.view.frame.size.width / 7;
    week = @[@"일", @"월", @"화", @"수", @"목", @"금", @"토"];
    cal = [NSCalendar currentCalendar];
    [cal setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Seoul"]];
    //[cal setLocale:[NSLocale currentLocale]];
    
    CGPoint pos;
    pos.x=1;
    pos.y=4;
    [self makeButton:@"10" withPosition:pos];
    [self makeMonth:10];
    [self setHeader];
    
    NSLog(@"%@", [NSTimeZone knownTimeZoneNames]);
}

- (void) setHeader {
    CGPoint pos;
    pos.y=1;
    for(int i=0 ; i < week.count ; i++) {
        pos.x=i+1;
        [self makeButton:week[i] withPosition:pos];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeMonth:(int)month {
    int firstday = [self getFirstDate:month];
    CGPoint pos;
    pos.y=2;
    pos.x=firstday;
    for(int i = 0 ; i < [self getLastDate:month] ; i++) {
        [self makeButton:[NSString stringWithFormat:@"%d",i+1] withPosition:pos];
        pos.x++;
        if((int)pos.x%8 == 0) {
            pos.y++;
            pos.x=1;
        }
    }
}

- (int)getFirstDate:(int)month {
    NSDateComponents *comps2 = [[NSDateComponents alloc] init];
    [comps2 setMonth:11];
    [comps2 setDay:1];
    [comps2 setYear:2014];
    NSDate *tDateMonth = [cal dateFromComponents:comps2];
    NSLog(@"%@", tDateMonth);
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:2014];
    NSDate *firstDay = [cal dateFromComponents:comps];
    NSDateComponents* comp = [cal components:NSCalendarUnitWeekday fromDate:firstDay];
    NSLog(@"first %d", [comp weekday]);
    return [comp weekday];
}

- (int)getLastDate:(int)month {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month+1];
    [comps setDay:0];
    [comps setYear:2014];
    NSDate *lastDay = [cal dateFromComponents:comps];
    NSDateComponents* comp = [cal components:NSCalendarUnitDay fromDate:lastDay];
    NSLog(@"last %d", [comp day]);
    return [comp day];
}



- (void)makeButton:(NSString*)day withPosition:(CGPoint)pos {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[button addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:day forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    CGRect buttonFrame = button.frame;
    buttonFrame.size = CGSizeMake(buttonSize, buttonSize);
    button.frame = buttonFrame;
    CGPoint pixel = [self coodinationToPixel:pos];
    button.center= CGPointMake(pixel.x, pixel.y);
    //button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}

- (CGPoint)coodinationToPixel:(CGPoint)coodi {
    CGPoint result;
    result.x = coodi.x * (buttonSize) - (buttonSize/2);
    result.y = coodi.y * (buttonSize) - (buttonSize/2);
    return result;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
