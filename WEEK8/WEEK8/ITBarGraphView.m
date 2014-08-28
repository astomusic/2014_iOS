//
//  ITBarGraphView.m
//  WEEK8
//
//  Created by astomusic on 2014. 8. 28..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITBarGraphView.h"

@implementation ITBarGraphView

-(void)drawRect:(CGRect)rect
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(1, 3), 2);
    
    for(int i=0; i<[_jsonData count]; i++) {
        NSString* title = [[_jsonData objectAtIndex:i] objectForKey:@"title"];
        int value = [[[_jsonData objectAtIndex:i] objectForKey:@"value"] intValue];
        UIBezierPath *path = [self drawLine:title value:value index:i];
        
        [[self setColor:10 green:10 blue:250] setStroke];

        [path stroke];
        CGFloat x = 0;
        CGFloat y = i*20 + 10;
        CGPoint startPoint = CGPointMake(x, y);
        [[self drawText:title] drawAtPoint:startPoint];
    }
}

-(UIBezierPath*) drawLine:(NSString*)title value:(int)value index:(int)index
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat x = 40;
    CGFloat y = index*20 + 15;
    CGPoint startPoint = CGPointMake(x, y);
    [path moveToPoint:startPoint];
    x = x + value*5;
    CGPoint nextPoint = CGPointMake(x, y);
    [path addLineToPoint:nextPoint];
    [path setLineWidth:10.0];

    return path;
}

-(NSAttributedString*) drawText:(NSString*) text
{
    UIFont* font = [UIFont fontWithName:@"Arial" size:8];
    UIColor* textColor = [self setColor:0 green:0 blue:0];
    NSDictionary* stringAttrs = @{ NSFontAttributeName : font, NSForegroundColorAttributeName : textColor };
    
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:text attributes:stringAttrs];
    
    return attrStr;
}

-(UIColor*) setColor:(int)red green:(int)green blue:(int)blue
{
    UIColor* color = [UIColor colorWithRed:red/256.0 green:green/256.0 blue:blue/256.0 alpha:1];
    return color;
}
@end
