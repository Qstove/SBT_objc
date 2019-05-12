//
//  SVFNotificationService.m
//  SearchViaFickr
//
//  Created by Анатолий Кустов on 4/20/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "SVFNotificationService.h"
#import "AppDelegate.h"
@import UserNotifications;

typedef NS_ENUM(NSInteger, LCTTriggerType) {
    LCTTriggerTypeInterval = 0,
    LCTTriggerTypeDate = 1,
    LCTTriggerTypeLocation = 2,
};

@implementation SVFNotificationService

+ (void)sheduleLocalNotificationWithInterval
{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Что за...";
    content.body = [NSString stringWithFormat:@"Алло, ты не искал %@ уже ровно минуту!\nAre you ok?!", [[NSUserDefaults standardUserDefaults] objectForKey:@"lastQuery"]];
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
    content.userInfo = @{
                         @"query": [[NSUserDefaults standardUserDefaults] objectForKey:@"lastQuery"]
                         };
    
    NSString *identifier = @"NotificationWithInterval";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content trigger:[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO]];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
     {
         if (error)
         {
             NSLog(@"Ошибочка вышла: %@",error);
         }
     }];
}

- (void)sheduleLocalNotificationWithDate
{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"БУ! Уже полночь!";
    content.body = @"Почему бы не начать новый день с поиска картинок?";
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
    NSString *query = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastQuery"];
    if(query)
    {
    content.userInfo = @{
                         @"query": [[NSUserDefaults standardUserDefaults] objectForKey:@"lastQuery"]
                         };
    }
    else
    {
        content.userInfo = @{
                             @"query": @""
                             };
    }
    UNNotificationTrigger *intervalTrigger = [self triggerWithType:LCTTriggerTypeDate];
    NSString *identifier = @"NotificationWithInterval";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content trigger:intervalTrigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
     {
         if (error)
         {
             NSLog(@"Ошибочка вышла: %@",error);
         }
     }];
}

#pragma mark - Triggers
- (UNNotificationTrigger *)triggerWithType:(LCTTriggerType)triggerType
{
    switch (triggerType)
    {
        case LCTTriggerTypeInterval:
            return [self intervalTrigger];
        case LCTTriggerTypeLocation:
            return [self locationTrigger];
        case LCTTriggerTypeDate:
            return [self dateTrigger];
        default:
            break;
    }
    return nil;
}

- (UNTimeIntervalNotificationTrigger *)intervalTrigger
{
    return [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60 repeats:NO];
}

- (UNCalendarNotificationTrigger *)dateTrigger
{
    /* Если мы хотим сделать повторяющийся пуш каждый день в одно время, в dateComponents
     должны быть только часы/минуты/секунды */
    NSDate * midnight = [[NSCalendar currentCalendar] startOfDayForDate: [NSDate date]];
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                     components:NSCalendarUnitHour + NSCalendarUnitMinute +
                                     NSCalendarUnitSecond fromDate:midnight];
    return [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
}

- (UNLocationNotificationTrigger *)locationTrigger
{
    return nil;
}


@end
