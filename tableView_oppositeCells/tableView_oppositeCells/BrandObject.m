//
//  BrandObject.m
//  tableView_oppositeCells
//
//  Created by Анатолий Кустов on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "BrandObject.h"


@implementation BrandObject

- (instancetype)initWithBrand:(NSString*)name brand:(NSString *)description brand:(UIImage *)image {
    self = [super init];
    if (self) {
        _brandTitle = name;
        _brandDescription = description;
        _brandImage = image;
    }
    return self;
}

@end
