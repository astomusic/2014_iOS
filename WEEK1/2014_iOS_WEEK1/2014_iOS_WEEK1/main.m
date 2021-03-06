//
//  main.m
//  2014_iOS_WEEK1
//
//  Created by astomusic on 2014. 7. 10..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import <Foundation/Foundation.h>
NSMutableArray* NXDisplayAllFilesAtPath(NSString *path);
Boolean isExistFilename(NSString *fName, NSString *path);
NSArray* NXSortedFiles(NSString *path, Boolean ascending);
void checkExistFiles(NSArray* files, NSString *path);

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Boolean result;
        NSString* path = @"/Users/astomusic/Desktop";
        NSArray *files = [[NSArray alloc] initWithObjects: @"test.txt", @"test1.txt", @"text9.txt", nil];
        
        result = isExistFilename(@"test.txt", path);
        
        NXSortedFiles(path, YES);
        NXSortedFiles(path, NO);
        
        checkExistFiles(files, path);

    }
    return 0;
}

NSMutableArray* NXDisplayAllFilesAtPath(NSString *path) {
    NSFileManager *fm;
    NSDirectoryEnumerator *dirEnum;
    NSMutableArray *dirArray = [[NSMutableArray alloc]init];
    NSString *file;
    
    fm = [NSFileManager defaultManager];
    
    dirEnum = [fm enumeratorAtPath:path];
    NSLog(@"currnet directory : %@", path);
    while ((file = [dirEnum nextObject]) != nil) {
        [dirArray addObject:(NSString*)file];
        NSLog(@"%@", file);
    }
    return dirArray;
}

Boolean isExistFilename(NSString *fName, NSString *path) {
    NSMutableArray *dirArray;
    dirArray = NXDisplayAllFilesAtPath(path);
    
    if([dirArray containsObject:fName]){
        NSLog(@"<%@> is included in <%@>", fName, path);
        return YES;
    }
    
    NSLog(@"<%@> is not included in <%@>", fName, path);
    return NO;
}

NSArray* NXSortedFiles(NSString *path, Boolean ascending) {
    NSMutableArray *dirArray;
    NSArray *sortedArray;
    dirArray = NXDisplayAllFilesAtPath(path);
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:ascending];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    sortedArray = [dirArray sortedArrayUsingDescriptors:sortDescriptors];
    
    int i;
    for (i = 0; i < [sortedArray count]; i++) {
        NSLog(@"index %d has %@.", i, [sortedArray objectAtIndex: i] );
    }
    
    return sortedArray;
}

void checkExistFiles(NSArray* files, NSString *path) {
    
}




