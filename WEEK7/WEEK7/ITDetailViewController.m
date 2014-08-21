//
//  ITDetailViewController.m
//  WEEK7
//
//  Created by astomusic on 2014. 8. 21..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITDetailViewController.h"

@interface ITDetailViewController ()
{
    NSMutableData *_data;
    long readBytes;
    long imageLen;
    BOOL initLen;
    NSInputStream *inputStream;
}
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation ITDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    initLen = NO;
    readBytes = 0;
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self searchForSite:@"10.73.39.74" withPort:8000];
}

- (void)searchForSite:(NSString*)url withPort:(int)port
{
    NSString *urlStr = url;
    if (![urlStr isEqualToString:@""]) {
        NSURL *website = [NSURL URLWithString:urlStr];
        if (!website) {
            NSLog(@"%@ is not a valid URL", website);
            return;
        }
        
        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;
        CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)urlStr, port, &readStream, &writeStream);
        
        inputStream = (__bridge_transfer NSInputStream *)readStream;
        NSOutputStream *outputStream = (__bridge_transfer NSOutputStream *)writeStream;
        [inputStream setDelegate:self];
        [outputStream setDelegate:self];
        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [inputStream open];
        [outputStream open];
        
    }
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    
    switch(eventCode) {
        case NSStreamEventHasBytesAvailable:
        {
            if(!_data) {
                _data = [[NSMutableData alloc]init];
            }

            uint8_t buf[1024];
            long len = 0;
            if (initLen == NO) {
                len = [(NSInputStream *)stream read:buf maxLength:8];
            } else {
                len = [(NSInputStream *)stream read:buf maxLength:1024];
            }
            
            if(len) {
                if(initLen == NO) {
                    //[_data appendBytes:(const void *)buf length:len];
                    NSLog(@"%ld", len);
                    buf[len] = '\0';
                    imageLen = atol((const char*)buf);
                    initLen = YES;
                } else {
                    [_data appendBytes:(const void *)buf length:len];
                    readBytes += len;
                    NSLog(@"readBytes %ld", readBytes);
                    NSLog(@"imageLen %ld", imageLen);
                    
                    if(readBytes >= imageLen) {
                        UIImage* image = [UIImage imageWithData:_data];
                        _DetailImage.image = image;
                        
                        [_data init];
                        readBytes = 0;
                        imageLen = 0;
                        initLen = NO;
                    }
                   
                }
                
            } else {
                NSLog(@"no buffer!");
            }
            break;
        }
        case NSStreamEventEndEncountered:
        {
            [stream close];
            [stream removeFromRunLoop:[NSRunLoop currentRunLoop]
                              forMode:NSDefaultRunLoopMode];
            stream = nil; // stream is ivar, so reinit it
            break;
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"hihihi");
    [inputStream close];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
