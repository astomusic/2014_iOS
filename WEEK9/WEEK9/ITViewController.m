//
//  ITViewController.m
//  WEEK9
//
//  Created by astomusic on 2014. 9. 2..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITViewController.h"

@interface ITViewController ()
{
    dispatch_queue_t mainQueue;
}

@end

@implementation ITViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    

}
- (IBAction)bookButtonClicked:(id)sender {
    _progressBar.progress = 0;
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); dispatch_async(aQueue, ^{
        [self workingProgress];
    });
}

-(void)workingProgress {
    NSString *bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"bookfile" ofType:@".txt"]  encoding:NSUTF8StringEncoding error:nil];
    int length = (int)bookfile.length;
    int spaceCount = 0;
    float progress = 0;
    
    unichar aChar;
    for (int nLoop=0; nLoop<length; nLoop++) {
        aChar = [bookfile characterAtIndex:nLoop];
        if (aChar==' ') {
            spaceCount++;
        }
        progress = (float)nLoop / (float)length;
        mainQueue = dispatch_get_main_queue();
        dispatch_sync(mainQueue, ^{
            _progressBar.progress = progress;
        });
    }
    dispatch_sync(mainQueue, ^{
        [[[UIAlertView alloc] initWithTitle:@"완료"
                                    message:[NSString stringWithFormat:@"찾았다 %d개",spaceCount]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    });
    
}

- (IBAction)pushButton:(id)sender {
    CGRect oFrame = [sender frame];
    NSString* oText = [sender titleLabel].text;
    int oAlpha = [sender alpha];
    UIColor* oColor = [sender backgroundColor];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         _testButton.backgroundColor = [UIColor redColor];
                         _testButton.alpha = 0.5;
                         CGRect frame;
                         frame.origin.x = 400;
                         frame.origin.y = 100;
                         frame.size.height = 10;
                         frame.size.width = 10;
                         _testButton.frame = frame;
                         _testButton.titleLabel.text = @"test";
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                         _testButton.backgroundColor = oColor;
                         _testButton.alpha = oAlpha;
                         _testButton.frame = oFrame;
                         _testButton.titleLabel.text = oText;
                     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
