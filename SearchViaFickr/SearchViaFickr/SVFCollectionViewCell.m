//
//  SVFCollectionViewCell.m
//  SearchViaFickr
//
//  Created by Анатолий Кустов on 18/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "SVFCollectionViewCell.h"

@implementation SVFCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _imageView = [[UIImageView alloc]initWithFrame:frame];
    [self.contentView addSubview:_imageView];
    _imageView.backgroundColor = UIColor.blackColor;
    self.contentView.backgroundColor = UIColor.blackColor;
    return self;
}

- (void)layoutSubviews
{
    self.imageView.frame = self.contentView.bounds;
    [self.contentView bringSubviewToFront:self.imageView];
}

- (void)prepareForReuse
{
    self.imageView.image = nil;
}

- (void)configureWith:(UIImage *)image
{
    self.imageView.image = image;
}

@end
