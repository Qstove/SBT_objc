//
//  ClothTypeObject.h
//  tableView_oppositeCells
//
//  Created by Анатолий Кустов on 09/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClothTypeObject : NSObject

@property (nonatomic, strong) NSString *clothTypeTitle;
@property (nonatomic, strong) NSString *clothTypeDescription;
@property (nonatomic, strong) UIImage *clothTypeImage;

- (instancetype) initWithImage:(UIImage*)image title:(NSString*)title subtitle:(NSString*)description;

@end

NS_ASSUME_NONNULL_END
