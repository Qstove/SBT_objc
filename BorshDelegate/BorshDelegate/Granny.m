//
//  Granny.m
//  BorshDelegate
//
//  Created by Анатолий Кустов on 02/03/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Granny.h"


@implementation Granny

- (void)serveLunch
{
    // приготовить обед
    [self makeLunch];
    // переложить работу по употреблению обеда делегату
    if ([self.borshDelegate borshServed]) {     // проверить решение делегата
        NSLog(@"Борщ съеден, посуда грязная.");
        // исходя из решения вызывает или не вызывает метод для мытья посуды
        [self washDishes];
    };
}


/**
 Помыть посуду
 */
- (void)washDishes
{
    NSLog(@"Посуда моется");
}


/**
 Сделать обед
 */
- (void)makeLunch
{
    NSLog(@"Бабушка приготовила обед и зовет внука есть");
}

@end


