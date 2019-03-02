//
//  Granny.h
//  BorshDelegate
//
//  Created by Анатолий Кустов on 02/03/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "BorshDelegate.h"

/**
 Класс, представляющий бабушку, которая может накормить любого человека,
 умеющего взаимодействовать с борщом, и помыть за ним посуду.
 */
@interface Granny : NSObject

@property (nonatomic, weak, nullable) id<BorshDelegate> borshDelegate;    /**< текущий делегат бабушки, которому будет предложено отведать борщ */

/**
 Приготовить и подать обед.
 */
- (void)serveLunch;
- (void)washDishes;
- (void)makeLunch;


@end
