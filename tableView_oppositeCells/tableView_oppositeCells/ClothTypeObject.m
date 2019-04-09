//
//  ClothTypeObject.m
//  tableView_oppositeCells
//
//  Created by Анатолий Кустов on 09/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "ClothTypeObject.h"

@implementation ClothTypeObject

-(instancetype) initWithImage:(UIImage*)image title:(NSString*)title subtitle:(NSString*)description
{
    self = [super init];
    _clothTypeImage = image;
    _clothTypeTitle = title;
    _clothTypeDescription = description;
    return self;
}

@end
