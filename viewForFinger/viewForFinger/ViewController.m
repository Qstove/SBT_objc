//
//  ViewController.m
//  viewForFinger
//
//  Created by Анатолий Кустов on 07/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "ViewController.h"
#import "MovableView.h"

@interface ViewController ()

@property (nonatomic, strong) MovableView *movableSquare;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
#pragma mark - creating movable square
    self.movableSquare = [[MovableView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.movableSquare.center = self.view.center;
    self.movableSquare.backgroundColor = [UIColor colorWithRed:4.0f/255.0f green:51.0f/255.0f blue:255.0f/255.0f alpha:1];
    [self.view addSubview:self.movableSquare];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint mainViewPoint = [touch locationInView:self.view];
    CGFloat coordX = mainViewPoint.x;
    CGFloat propCoordX = coordX / self.view.frame.size.width;
    self.view.backgroundColor = [UIColor colorWithRed:propCoordX green:propCoordX blue:propCoordX alpha:1];
}

@end
