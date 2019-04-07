//
//  ViewController.m
//  SBT_AirHockey
//
//  Created by Qstove on 28/03/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

/************************************
            PLAY FIELD:
 
               tlb       trb
         l   |=====____ =====| r
         e   |      ui       | i
         f   |     gates     | g
         t   |               | h
             |               | t
             |               |
         b   |       O       | b
         o   |      ball     | o
         r   |               | r
         d   |  player gates | d
         e   |     ____      | e
         r   |=====     =====| r
               blb       brb
 
 ************************************/

#import "ViewController.h"

#import "Views/GateViews/AIGateView.h"
#import "Views/SettingsView.h"

#define topAndBotBorderWidth    CGRectGetMaxX(self.view.frame)/5
#define gateWidth               1.5*topAndBotBorderWidth - fromBorder2GateX*2


@interface ViewController ()

@property (nonatomic, strong) UIView *leftBorder;
@property (nonatomic, strong) UIView *rightBorder;
@property (nonatomic, strong) UIView *topLeftBorder;
@property (nonatomic, strong) UIView *topRightBorder;
@property (nonatomic, strong) UIView *botLeftBorder;
@property (nonatomic, strong) UIView *botRightBorder;

@property (nonatomic, strong) UIButton *ball;
@property (assign, nonatomic) CGFloat dX;
@property (assign, nonatomic) CGFloat dY;
@property (assign, nonatomic) CGPoint checkPoint;

@property (nonatomic, strong) AIGateView *aiGate;
@property (nonatomic, strong) GateView *playerGate;

@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *settingsButton;
@property (nonatomic, strong) SettingsView *settingsView;

@property (strong, nonatomic) NSTimer *timer;

@end


@implementation ViewController

const CGFloat borderWidth = 20;
static const CGFloat fromBorder2GateX = 10;
static const CGFloat fromBorder2GateY = 5;
static const CGFloat ballRadius = 25;


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ice"]]];
    [self preparePlayField];
    [self addSetingsButton];
    self.settingsView = [SettingsView settingsView];
    [self.view addSubview:self.settingsView];
    [self.settingsView createUI];
}



-(void)preparePlayField
{
#pragma mark - playfield_borders
    CGRect leftBorderFrame = CGRectMake(0, 0, borderWidth, self.view.frame.size.height);
    self.leftBorder = [[UIView alloc]initWithFrame:leftBorderFrame];
    self.leftBorder.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.leftBorder];
    
    CGRect rightBorderFrame = CGRectMake(CGRectGetMaxX(self.view.frame) - borderWidth, 0, borderWidth, self.view.frame.size.height);
    self.rightBorder = [[UIView alloc]initWithFrame:rightBorderFrame];
    self.rightBorder.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.rightBorder];
    
    CGRect topLeftBorderFrame = CGRectMake(0, 0, topAndBotBorderWidth, borderWidth);
    self.topLeftBorder = [[UIView alloc]initWithFrame:topLeftBorderFrame];
    self.topLeftBorder.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.topLeftBorder];
    
    CGRect topRightBorderFrame = CGRectMake(CGRectGetMaxX(self.view.frame)-topAndBotBorderWidth, 0, topAndBotBorderWidth, borderWidth);
    self.topRightBorder= [[UIView alloc]initWithFrame:topRightBorderFrame];
    self.topRightBorder.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.topRightBorder];
    
    CGRect botLeftBorderFrame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-borderWidth, topAndBotBorderWidth, borderWidth);
    self.botLeftBorder = [[UIView alloc]initWithFrame:botLeftBorderFrame];
    self.botLeftBorder.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.botLeftBorder];
    
    CGRect botRightBorderFrame = CGRectMake(CGRectGetMaxX(self.view.frame)-topAndBotBorderWidth, CGRectGetMaxY(self.view.frame)-borderWidth, topAndBotBorderWidth, borderWidth);
    self.botRightBorder = [[UIView alloc]initWithFrame:botRightBorderFrame];
    self.botRightBorder.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.botRightBorder];
    
    
#pragma mark - playfield_gates
    CGPoint buffPoint;
    CGRect aiGateFrame = CGRectMake(CGRectGetMaxX(topLeftBorderFrame) + fromBorder2GateX, CGRectGetMaxY(topLeftBorderFrame) + fromBorder2GateY, gateWidth, borderWidth/2);
    self.aiGate = [[AIGateView alloc]initWithFrame:aiGateFrame];
    self.aiGate.backgroundColor = UIColor.redColor;
    self.aiGate.layer.cornerRadius = CGRectGetHeight(self.aiGate.frame)/2;

    buffPoint = self.aiGate.center;
    buffPoint.x = self.view.center.x;
    self.aiGate.center = buffPoint;
    [self.view addSubview:self.aiGate];

    CGRect playerGateFrame = CGRectMake(CGRectGetMaxX(botLeftBorderFrame) + fromBorder2GateX, CGRectGetMinY(botLeftBorderFrame) - borderWidth - fromBorder2GateY, gateWidth, borderWidth/2);
    self.playerGate = [[GateView alloc]initWithFrame:playerGateFrame];
    self.playerGate.backgroundColor = UIColor.redColor;
    self.playerGate.layer.cornerRadius = CGRectGetHeight(self.playerGate.frame)/2;
    buffPoint = self.playerGate.center;
    buffPoint.x = self.view.center.x;
    self.playerGate.center = buffPoint;
    [self.view addSubview:self.playerGate];
    
    
#pragma mark - playfield_ball
    CGRect ballFrame = CGRectMake(0, 0, ballRadius, ballRadius);

    self.ball = [[UIButton alloc]initWithFrame:ballFrame];
    [self.ball setImage:[UIImage imageNamed:@"ball"] forState:UIControlStateNormal];
    [self.ball setHidden:YES];
    [self.view addSubview:self.ball];

}

-(void)addSetingsButton
{
#pragma mark - settingsButton_UI
    self.settingsButton = [UIButton new];
    self.settingsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.settingsButton setBackgroundImage:[UIImage imageNamed:@"settButton"] forState:UIControlStateNormal];
    [self.settingsButton addTarget:self action:@selector(tapSettings) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.settingsButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.settingsButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0 constant:borderWidth
                              ]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.settingsButton
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0 constant:borderWidth
                              ]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.settingsButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0 constant:35.0f
                              ]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.settingsButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0 constant:35.0f
                              ]];
#pragma mark - startButtonUI
    self.startButton = [UIButton new];
    [self.startButton setImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(startGameWithoutReset:) forControlEvents:UIControlEventTouchUpInside];
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: self.startButton];
    [self.startButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.startButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [self.startButton.widthAnchor constraintEqualToConstant:CGRectGetWidth(self.view.frame)/3].active = YES;
    [self.startButton.heightAnchor constraintEqualToConstant:CGRectGetWidth(self.view.frame)/3].active = YES;


}

- (void)tapSettings
{
    if (self.settingsView.isHide)
    {
        self.checkPoint = self.ball.center;
        [self.timer invalidate];
        [self.settingsView toggleViewSettings];
    }
    else
    {
        [self.settingsView toggleViewSettings];
        self.ball.center = self.checkPoint;
        [self startGameWithoutReset:YES];
    }
}

- (void)startGameWithoutReset:(BOOL)dontReset
{
    if(!dontReset)
    {
        self.checkPoint = self.view.center;
        self.dX = self.dY = 1.0;
        self.settingsView.score = 0;
    }
    self.ball.center = self.checkPoint;
    [self.startButton setHidden:YES];
    [self.ball setHidden:NO];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01f/self.settingsView.option target:self selector:@selector(ballAnimation) userInfo:nil repeats:YES];
}

- (void) ballAnimation
{
    CGRect virtualUIGateFrame = CGRectMake(self.ball.center.x - CGRectGetWidth(self.aiGate.frame)/2, self.aiGate.frame.origin.y, CGRectGetWidth(self.aiGate.frame), CGRectGetHeight(self.aiGate.frame));

    //проверка того, что AIGate не ушел за рамки
    if ( !(CGRectIntersectsRect(virtualUIGateFrame, self.leftBorder.frame) || CGRectIntersectsRect(virtualUIGateFrame, self.rightBorder.frame)) )
    {
        self.aiGate.center = CGPointMake(self.ball.center.x, self.aiGate.center.y);
    }
    
    //проверка на то, что шар не коснулся горизонтальных ограничений
    if (CGRectIntersectsRect(self.ball.frame, self.aiGate.frame) ||
        CGRectIntersectsRect(self.ball.frame, self.topRightBorder.frame) ||
        CGRectIntersectsRect(self.ball.frame, self.topLeftBorder.frame) ||
        CGRectIntersectsRect(self.ball.frame, self.botRightBorder.frame) ||
        CGRectIntersectsRect(self.ball.frame, self.botLeftBorder.frame))
    {

        self.dY *= -1;
    }
    if(CGRectIntersectsRect(self.ball.frame, self.playerGate.frame))
    {
        self.dY *= -1;
        self.settingsView.score += 10;
    }
    //проверка на то, что шар не коснулся вертикальных ограничений
    if (CGRectIntersectsRect(self.ball.frame, self.leftBorder.frame) || CGRectIntersectsRect(self.ball.frame, self.rightBorder.frame))
    {
        self.dX *= -1;
    }

    if(CGRectGetMaxY(self.ball.frame) >= CGRectGetMaxY(self.view.frame))   //очко компу - нам забили
    {
        [self.timer invalidate];
        [self.startButton setHidden:NO];
    }
    self.ball.center = CGPointMake(self.ball.center.x + self.dX, self.ball.center.y + self.dY);
}
@end



