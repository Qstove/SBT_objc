//
//  SVFNotificationService.h
//  SearchViaFickr
//
//  Created by Анатолий Кустов on 4/20/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SVFNotificationService : NSObject

+ (void)sheduleLocalNotificationWithInterval;

- (void)sheduleLocalNotificationWithDate;

@end

