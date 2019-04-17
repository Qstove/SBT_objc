//
//  ClothTypeCell_R.m
//  tableView_oppositeCells
//
//  Created by Анатолий Кустов on 09/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "ClothTypeCell_R.h"

@interface ClothTypeCell_R ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraint;

@end

@implementation ClothTypeCell_R


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _coverImageView = [UIImageView new];
        _coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview: _coverImageView];
        
        
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.numberOfLines = 1;
        _titleLabel.minimumScaleFactor=0.5;
        _titleLabel.font = [UIFont systemFontOfSize:40 weight:1];
        [self.contentView addSubview: _titleLabel];
        
        _subtitleLabel = [UILabel new];
        _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitleLabel.adjustsFontSizeToFitWidth = YES;
        _subtitleLabel.numberOfLines = 1;
        _subtitleLabel.minimumScaleFactor=0.5;
        _subtitleLabel.font = [UIFont systemFontOfSize:20 weight:0.5];
        [self.contentView addSubview: _subtitleLabel];
        
        [self makeConstraintWithRightAligment];
    }
    return self;
}

- (void) makeConstraintWithRightAligment
{
    
        [NSLayoutConstraint activateConstraints:@[
                                                  [_coverImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                                  [_coverImageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10.0f],
                                                  [_coverImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10],
                                                  [_coverImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-10],
                                                  [_coverImageView.heightAnchor constraintEqualToAnchor:_coverImageView.widthAnchor],
                                                  
                                                  [_titleLabel.trailingAnchor constraintEqualToAnchor:_coverImageView.leadingAnchor constant:-20.0f],
                                                  [_titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
                                                  [_titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                                  [_titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:20.0f],
                                                  
                                                  
                                                  [_subtitleLabel.topAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                                  [_subtitleLabel.trailingAnchor constraintEqualToAnchor:_coverImageView.leadingAnchor constant:-20.0f],
                                                  [_subtitleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-(CGRectGetHeight(self.contentView.frame) - 40)/2],
                                                  [_subtitleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:20.0f],

                                                  ]
         ];
}

- (void)setDataFromClothTypeModel:(ClothTypeObject *)clothType
{
    self.titleLabel.text = clothType.clothTypeTitle;
    self.subtitleLabel.text = clothType.clothTypeDescription;
    [self.coverImageView setImage:clothType.clothTypeImage];
}

@end
