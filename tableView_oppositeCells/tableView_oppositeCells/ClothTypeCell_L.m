//
//  ClothTypeCell_L.m
//  tableView_oppositeCells
//
//  Created by Анатолий Кустов on 09/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "ClothTypeCell_L.h"

@interface ClothTypeCell_L ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraint;

@end

@implementation ClothTypeCell_L


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
        [self.contentView addSubview: _titleLabel];
        
        _subtitleLabel = [UILabel new];
        _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitleLabel.numberOfLines = 0;
        [self.contentView addSubview: _subtitleLabel];
        
        [self makeConstraintWithLeftAligment];
    }
    return self;
}

- (void) makeConstraintWithLeftAligment
{
        [NSLayoutConstraint activateConstraints:@[
                                                  [_coverImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                                  [_coverImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10.0f],
                                                  [_coverImageView.widthAnchor constraintEqualToConstant:40.0f],
                                                  [_coverImageView.heightAnchor constraintEqualToConstant:40.0f],
                                                  
                                                  [_titleLabel.leadingAnchor constraintEqualToAnchor:_coverImageView.trailingAnchor constant:20.0f],
                                                  [_titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:(CGRectGetHeight(self.contentView.frame) - 40)/2],
                                                  
                                                  [_subtitleLabel.leadingAnchor constraintEqualToAnchor:_coverImageView.trailingAnchor constant:20.0f],
                                                  [_subtitleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-(CGRectGetHeight(self.contentView.frame) - 40)/2]
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


