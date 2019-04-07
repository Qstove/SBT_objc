//
//  SettingsView.m
//  SBT_AirHockey
//
//  Created by Qstove on 02/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//


#import "SettingsView.h"

#define SETTINGSVIEW_HEIGHT CGRectGetHeight(self.superview.frame)/2
#define SETTINGSVIEW_WIDTH  CGRectGetWidth(self.superview.frame) - (settingsViewMarginLeadAndTrail*2)

static const CGFloat settingsViewMarginLeadAndTrail = 30;


@interface SettingsView ()

@property (nonatomic, strong) UILabel *settingsLabel;

@property (nonatomic, strong) UILabel *difficultyLabel;
@property (nonatomic, strong) UITextField *difficultyTextField;
@property (nonatomic, strong) UIPickerView *difficultyPickerView;

@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic,strong) UIButton *resumeGameButton;

@property (nonatomic,strong) NSArray *pickerData;

@property (nonatomic,strong) NSLayoutConstraint *widthConstraint;
@property (nonatomic,strong) NSLayoutConstraint *heightConstraint;

@end


@implementation SettingsView

+(SettingsView *) settingsView
{
    SettingsView *settingsView = [SettingsView new];
    //settingsView.backgroundColor = UIColor.whiteColor;
    [settingsView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"settings"]]];

    settingsView.layer.cornerRadius = 50;
    
    settingsView.layer.masksToBounds = YES;
    settingsView.layer.borderColor = UIColor.blackColor.CGColor;
    settingsView.layer.borderWidth = 5.0f;
    settingsView.translatesAutoresizingMaskIntoConstraints = NO;
    return settingsView;
}


-(void)createUI
{
    self.pickerData = @[@"Изи-пизи!",@"Ну такое..",@"А ты хорош!",@"Ну это бан."];
    self.isHide = YES;
    self.score = 0;
    self.option = EASY;
    
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.difficultyPickerView.frame), 44)];
    UIBarButtonItem *ok = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toolBarTapOK)];
    toolbar.items = @[ok];
    self.difficultyPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.superview.frame), CGRectGetMaxY(self.superview.frame)/4)];
    self.difficultyPickerView.dataSource = self;
    self.difficultyPickerView.delegate = self;
    
#pragma mark - self constraints
    [self.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;
    [self.centerYAnchor constraintEqualToAnchor:self.superview.centerYAnchor].active = YES;
    self.heightConstraint = [self.heightAnchor constraintEqualToConstant:0];
    self.widthConstraint = [self.widthAnchor constraintEqualToConstant:0];
    [NSLayoutConstraint activateConstraints:@[self.heightConstraint, self.widthConstraint]];

    
    
#pragma mark - settingsLabelUI + constraints
    self.settingsLabel = [UILabel new];
    self.settingsLabel.text = @"Настройки";
    self.settingsLabel.textColor = UIColor.whiteColor;
    self.settingsLabel.font = [UIFont systemFontOfSize:30];
    self.settingsLabel.textAlignment = NSTextAlignmentCenter;
    self.settingsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.settingsLabel];
    
    [self.settingsLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
    [self.settingsLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.settingsLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    
#pragma mark - settingsDifficultyUI + constraints
    self.difficultyLabel = [UILabel new];
    self.difficultyLabel.text = @"Сложность:";
    self.difficultyLabel.textColor = UIColor.whiteColor;
    self.difficultyLabel.font = [UIFont systemFontOfSize:20];
    self.difficultyLabel.textAlignment = NSTextAlignmentLeft;
    self.difficultyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.difficultyLabel];
    
    [self.difficultyLabel.topAnchor constraintEqualToAnchor:self.settingsLabel.bottomAnchor constant:10].active = YES;
    [self.difficultyLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
    
#pragma mark - settingsDifficultyTextFieldUI + constraints
    self.difficultyTextField = [UITextField new];
    self.difficultyTextField.text = self.pickerData[self.option-1];
    self.difficultyTextField.font = [UIFont systemFontOfSize:20];
    self.difficultyTextField.textColor = UIColor.whiteColor;
    self.difficultyTextField.textAlignment = NSTextAlignmentCenter;
    self.difficultyTextField.inputView = self.difficultyPickerView;
    self.difficultyTextField.inputAccessoryView = toolbar;
    self.difficultyTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.difficultyTextField];
    
    [self.difficultyTextField.topAnchor constraintEqualToAnchor:self.settingsLabel.bottomAnchor constant:10].active = YES;
    [self.difficultyTextField.leadingAnchor constraintEqualToAnchor:self.difficultyLabel.trailingAnchor constant:5].active = YES;
    [self.difficultyTextField.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;
    

    
    #pragma mark - settingsScoreLabel + constraints
    self.scoreLabel = [UILabel new];
    self.scoreLabel.text = [NSString stringWithFormat:@"Счёт:\t 0", self.score];
    self.scoreLabel.textColor = UIColor.whiteColor;
    //self.scoreLabel.textColor = [UIColor colorWithRed:118.0f/255.0f green:214.0f/255.0f blue:251.0f/255.0f alpha:1];
    self.scoreLabel.font = [UIFont boldSystemFontOfSize:30];
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.scoreLabel];
    
    [self.scoreLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10].active = YES;
    [self.scoreLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    
    
}


-(void)toggleViewSettings
{
    if(self.isHide) //если спрятан, то показываем
    {
        self.scoreLabel.text = [NSString stringWithFormat:@"Счёт:\t %u", self.score];
        [self.widthConstraint setConstant:SETTINGSVIEW_WIDTH];
        [self.heightConstraint setConstant:SETTINGSVIEW_HEIGHT];
        self.isHide = NO;
    }
    else    //если показан, то прячем
    {
        [self.widthConstraint setConstant:0];
        [self.heightConstraint setConstant:0];
        self.isHide = YES;
    }
    [SettingsView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    }];
    NSLog(@"Сложность - %u",self.option);
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}


// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerData[row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.difficultyTextField.text = self.pickerData[row];
    switch (row)
    {
        case 0:
            self.option = EASY;
            break;
        case 1:
            self.option = MEDIUM;
            break;
        case 2:
            self.option = HARD;
            break;
        case 3:
            self.option = NIGHTMARE;
            break;
            
        default:
            break;
    }
}


-(void)toolBarTapOK
{
    [self.difficultyTextField resignFirstResponder];
}


@end
