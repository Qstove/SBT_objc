//
//  Granson.m
//  BorshDelegate
//
//  Created by Анатолий Кустов on 02/03/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "Grandson.h"
#import <Foundation/Foundation.h>
#define LUNCH_START     14
#define LUNCH_FINISH    16


@implementation Grandson


/** Принятие решения есть ли борщ
 (Проверка, что текущее время от 14:00 до 16:00)
 */
- (BOOL)checkLunchTime
{
    NSDate              *dateNow = [NSDate date];
    NSCalendar          *calendar = [NSCalendar currentCalendar];
    NSDateComponents    *components = [calendar components:NSCalendarUnitHour fromDate:dateNow];
    
    NSInteger hours = [components hour];
    if(hours >= LUNCH_START && hours <= LUNCH_FINISH) {
        return YES;
    } else {
        return NO;
    }
}


- (BOOL)borshServed
{
    if([self checkLunchTime]){
        // есть борщ при соблюдении условия
        // сообщить нужно ли мыть посуду, если борщ был съеден
        NSLog(@"Внук: как вкусно!");
        return YES;
    } else {
        NSLog(@"Внук: Алло! Разве сейчас время обедать?");
        return NO;
    }
}

@end
