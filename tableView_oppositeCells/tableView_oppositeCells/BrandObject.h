//
//  BrandObject.h
//  tableView_oppositeCells
//
//  Created by Анатолий Кустов on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrandObject : NSObject

@property (nonatomic, strong) NSString *brandTitle;
@property (nonatomic, strong) NSString *brandDescription;
@property (nonatomic, strong) UIImage *brandImage;

@end

NS_ASSUME_NONNULL_END
