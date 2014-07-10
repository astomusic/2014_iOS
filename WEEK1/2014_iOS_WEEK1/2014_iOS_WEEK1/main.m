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

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Boolean result;
        
        result = isExistFilename(@"test.txt", @"/Users/astomusic/Desktop");
    }
    return 0;
}

NSMutableArray* NXDisplayAllFilesAtPath(NSString *path) {
    NSFileManager *fm;
    NSDirectoryEnumerator *dirEnum;
    NSMutableArray *dirArray = [[NSMutableArray alloc]init];
    NSString *file;
    
    fm = [NSFileManager defaultManager];
    
    dirEnum= [fm enumeratorAtPath:path];
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
        return true;
    }
    
    NSLog(@"<%@> is not included in <%@>", fName, path);
    return false;
}


