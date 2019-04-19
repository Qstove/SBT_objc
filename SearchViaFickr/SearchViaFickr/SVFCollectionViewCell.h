//
//  SVFCollectionViewCell.h
//  SearchViaFickr
//
//  Created by Анатолий Кустов on 18/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SVFCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

- (void)configureWith:(UIImage *)image;

@end

