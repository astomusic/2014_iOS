//
//  ITPieGraphView.m
//  WEEK8
//
//  Created by astomusic on 2014. 8. 28..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITPieGraphView.h"

@implementation ITPieGraphView

-(void)drawRect:(CGRect)rect
{
    float total = 0;
    NSMutableArray* values = [[NSMutableArray alloc] init];
    for(int i=0; i<[_jsonData count]; i++) {
        NSLog(@"%@",[_jsonData objectAtIndex:i]);
        [values addObject:[[_jsonData objectAtIndex:i] objectForKey:@"value"]];
        total += [[[_jsonData objectAtIndex:i] objectForKey:@"value"] intValue];
    }
    
    
    float sdeg = 0;
    for(int i=0; i<[_jsonData count]; i++) {
        int value = [[[_jsonData objectAtIndex:i] objectForKey:@"value"] intValue];
        NSString* title = [[_jsonData objectAtIndex:i] objectForKey:@"title"];
        float edeg = (value*360)/total + sdeg;
        
        UIBezierPath *path = [self drawArc:sdeg endDeg:edeg];
        
        UIColor *color = [self randomColor];
        
        [color setFill];
        [color setStroke];
        
        [path stroke];
        [path fill];
        
        sdeg = edeg;
    }
    
    sdeg = 0;
    for(int i=0; i<[_jsonData count]; i++) {
        int value = [[[_jsonData objectAtIndex:i] objectForKey:@"value"] intValue];
        NSString* title = [[_jsonData objectAtIndex:i] objectForKey:@"title"];
        float edeg = (value*360)/total + sdeg;
        
        NSLog(@"%f",edeg);
        NSLog(@"%f",sdeg);
        float mid = (edeg + sdeg)/2;
        float resultY = 70 * sinf(mid / 180 * M_PI);
        float resultX = 70 * cosf(mid / 180 * M_PI);
        
        CGFloat x = resultX + 100;
        CGFloat y = resultY + 100;
        CGPoint startPoint = CGPointMake(x, y);
        [[self drawText:title] drawAtPoint:startPoint];
        
        sdeg = edeg;
    }
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

-(UIColor*) randomColor
{
    CGFloat red = ( arc4random() % 256 / 256.0 );
    CGFloat green = ( arc4random() % 256 / 256.0 );
    CGFloat blue = ( arc4random() % 256 / 256.0 );
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    return color;
}

-(UIBezierPath*) drawArc:(float)sdeg endDeg:(float)edeg
{
    float srad = [self degToRad:sdeg];
    float erad = [self degToRad:edeg];
    
    CGFloat rad = 90;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat x = 100;
    CGFloat y = 100;
    CGPoint startPoint = CGPointMake(x, y);
    
    [path moveToPoint:startPoint];
    
    [path addArcWithCenter:startPoint radius:rad startAngle:srad endAngle:erad clockwise:YES];
    
    [path setLineWidth:1.0];
    
    return path;
}

-(float) degToRad:(float)deg
{
    //deg : 360 = x : 2pi
    return (deg * 2 * M_PI) / 360;
}


@end
