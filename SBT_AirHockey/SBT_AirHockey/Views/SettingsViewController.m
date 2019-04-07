//
//  SettingsView.m
//  SBT_AirHockey
//
//  Created by Анатолий Кустов on 29/03/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController()

@property (nonatomic,strong) UIButton *resumeGameButton;

@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, strong) UIPickerView *difficultChoice;

@property (nonatomic,strong) NSArray *pickerData;
@end


@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.pickerData = @[@"Изи",@"Ну такое",@"А ты хорош!",@"Читак - БАН!"];
    [self addResumeGameButton];
    [self addDifficultChoice];
    
    
}

-(void)addResumeGameButton
{
#pragma mark - settingsButton_UI
    self.resumeGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.resumeGameButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.resumeGameButton setTitle:@"Возобновить игру" forState:UIControlStateNormal];
    self.resumeGameButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.resumeGameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.resumeGameButton.backgroundColor = UIColor.redColor;
    [self.resumeGameButton addTarget:self action:@selector(tapResumeGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.resumeGameButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.resumeGameButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0 constant:0.0f
                              ]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.resumeGameButton
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0 constant:-30.0f
                              ]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.resumeGameButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0 constant:50
                              ]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.resumeGameButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0 constant:175
                              ]];
    self.resumeGameButton.layer.cornerRadius = 20;
}

-(void)addDifficultChoice
{
    UILabel *settingsLabel = [UILabel new];
    settingsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    settingsLabel.text = @"Настройки";
    
    UILabel *diffLabel = [UILabel new];
    diffLabel.translatesAutoresizingMaskIntoConstraints = NO;
    diffLabel.text = @"Сложность:";
    diffLabel.textColor = UIColor.blackColor;
    diffLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:diffLabel];
/*
    [self.view.leadingAnchor constraintEqualToAnchor:diffLabel.leadingAnchor constant:-15.0f].active = YES;
    [self.view.topAnchor constraintEqualToAnchor:diffLabel.topAnchor constant:-15.0f].active = YES;
    [diffLabel.widthAnchor constraintEqualToAnchor:diffLabel.widthAnchor constant:150.0f].active = YES;
    [diffLabel.heightAnchor constraintEqualToAnchor:diffLabel.heightAnchor constant:50.0f].active = YES;
todo разобраться с AutoLayout
 */

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:diffLabel
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0 constant:15.0f
                              ]];
     
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:diffLabel
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0 constant:15.0f
                              ]];
     
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:diffLabel
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0 constant:50
                              ]];
     
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:diffLabel
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0 constant:150
                              ]];
     
    
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.difficultChoice.frame), 44)];
    UIBarButtonItem *ok = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toolBarTapOK)];
    toolbar.items = @[ok];
    
    self.difficultChoice = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), CGRectGetMaxY(self.view.frame)/4)];
    self.difficultChoice.dataSource = self;
    self.difficultChoice.delegate = self;

    self.textfield = [UITextField new];
    self.textfield.translatesAutoresizingMaskIntoConstraints = NO;
    self.textfield.textColor = UIColor.blackColor;
    self.textfield.font = [UIFont systemFontOfSize:20];
    self.textfield.inputView = self.difficultChoice;
    self.textfield.inputAccessoryView = toolbar;
    //self.textfield.text = self.pickerData[self.option];
    
    [self.view addSubview: self.textfield];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textfield
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0 constant:0
                              ]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textfield
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0 constant:15.0f
                              ]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textfield
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0 constant:50
                              ]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textfield
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0 constant:130
                              ]];
}

- (void)tapResumeGame
{
     [self dismissViewControllerAnimated:YES completion:nil];
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
    self.textfield.text = self.pickerData[row];
    //self.option = (int)row;
}
-(void)toolBarTapOK
{
    
    [self.textfield resignFirstResponder];
}

@end
