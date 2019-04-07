//
//  MovableView.m
//  viewForFinger
//
//  Created by Анатолий Кустов on 07/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "MovableView.h"

@implementation MovableView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    CGPoint  point = [touch locationInView:self];
    NSLog(@"touchesBegan %.0f %.0f", point.x, point.y);
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    CGPoint  point = [touch locationInView:self];
    NSLog(@"touchesMoved %.0f %.0f", point.x, point.y);
    point.x =  point.x + self.frame.origin.x;
    point.y =  point.y + self.frame.origin.y;
    self.center = point;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    CGPoint  point = [touch locationInView:self];
    NSLog(@"touchesEnded %.0f %.0f", point.x, point.y);
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
}
@end
