//
//  ITMasterViewController.m
//  WEEK7
//
//  Created by astomusic on 2014. 8. 21..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITMasterViewController.h"

#import "ITDetailViewController.h"

@interface ITMasterViewController () 
{
    NSMutableArray *_objects;
    NSMutableData *_data;
    NSDate *_date;
}
@end

@implementation ITMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (ITDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [self searchForSite];

}

- (IBAction)searchForSite
{
    NSString *urlStr = @"127.0.0.1";
    if (![urlStr isEqualToString:@""]) {
        NSURL *website = [NSURL URLWithString:urlStr];
        if (!website) {
            NSLog(@"%@ is not a valid URL", website);
            return;
        }
        
        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;
        CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)urlStr, 7000, &readStream, &writeStream);
        
        NSInputStream *inputStream = (__bridge_transfer NSInputStream *)readStream;
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
            len = [(NSInputStream *)stream read:buf maxLength:1024];
            if(len) {
                [_data appendBytes:(const void *)buf length:len];
                buf[len] = '\0';
                NSTimeInterval time = atol((const char*)buf);
                _date = [NSDate dateWithTimeIntervalSince1970:time];
                NSLog(@"%@", _date);
                [_objects insertObject:_date atIndex:0];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                
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

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
