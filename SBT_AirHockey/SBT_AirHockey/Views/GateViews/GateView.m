//
//  GateView.m
//  SBT_AirHockey
//
//  Created by Qstove on 28/03/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "GateView.h"

extern const CGFloat borderWidth;
static float oldX = 0.0f;
static BOOL dragging = NO;


@implementation GateView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    CGPoint oldCoord = [touch locationInView:self];
    dragging = YES;
    oldX = oldCoord.x;
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    CGPoint newCoord = [touch locationInView:self];
    if (dragging)
    {
        CGRect frame = self.frame;
        frame.origin.x =  self.frame.origin.x + newCoord.x - oldX;
        if( (CGRectGetMinX(frame) >= CGRectGetMinX(self.superview.frame) + borderWidth) &&
            (CGRectGetMaxX(frame) <= CGRectGetMaxX(self.superview.frame) - borderWidth) )
        {
            self.frame = frame;
        }
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dragging = NO;
}
@end
