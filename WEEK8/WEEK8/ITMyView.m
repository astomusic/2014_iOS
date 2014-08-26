//
//  ITMyView.m
//  WEEK8
//
//  Created by astomusic on 2014. 8. 26..
//  Copyright (c) 2014년 NEXT. All rights reserved.
//

#import "ITMyView.h"

@implementation ITMyView
{
    
}

-(void)drawRect:(CGRect)rect
{
    
    //[[UIColor redColor] setFill];
    //UIRectFill(self.bounds);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient = [self gradient];
    CGPoint startPoint
    = CGPointMake(CGRectGetMidX(self.bounds), 0.0);
    CGPoint endPoint
    = CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMaxY(self.bounds));
    CGContextDrawLinearGradient(context, gradient,
                                startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    
    for(int i=0 ; i<10 ; i++){
        UIBezierPath *path = [self drawLine];
        [path stroke];
    }
    
    for(int i=0 ; i<10 ; i++){
        UIBezierPath *path = [self drawArc];

        UIColor *color = [self randomColor];
        
        [color setFill];
        [color setStroke];
        
        [path stroke];
        [path fill];
    }
    
    UIFont* font = [UIFont fontWithName:@"Arial" size:72];
    UIColor* textColor = [self randomColor];
    NSDictionary* stringAttrs = @{ NSFontAttributeName : font, NSForegroundColorAttributeName : textColor };
    
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:@"Hello" attributes:stringAttrs];
    
    [attrStr drawAtPoint:[self randomPoint]];
    
}

-(CGGradientRef) gradient
{
    UIColor *color = [self randomColor];
    UIColor *color2 = [self randomColor];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)color.CGColor, (id)color2.CGColor, nil];
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, NULL);
    
    return gradient;
}

-(UIBezierPath*) drawLine
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startPoint = [self randomPoint];
    [path moveToPoint:startPoint];
    CGPoint nextPoint = [self randomPoint];
    [path addLineToPoint:nextPoint];
    [path setLineWidth:1.0];
    return path;
}

-(UIBezierPath*) drawArc
{
    CGFloat rad = ( arc4random() % 100 );

    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startPoint = [self randomPoint];

    [path addArcWithCenter:startPoint radius:rad startAngle:0 endAngle:360 clockwise:YES];

    [path setLineWidth:1.0];
    
    return path;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setNeedsDisplay];
}

-(UIColor*) randomColor
{
    CGFloat red = ( arc4random() % 256 / 256.0 );
    CGFloat green = ( arc4random() % 256 / 256.0 );
    CGFloat blue = ( arc4random() % 256 / 256.0 );
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    return color;
}

-(CGPoint) randomPoint
{
    CGFloat x = ( arc4random() % 320 );
    CGFloat y = ( arc4random() % 568 );
    CGPoint point = CGPointMake(x, y);
    
    return point;
}

@end
