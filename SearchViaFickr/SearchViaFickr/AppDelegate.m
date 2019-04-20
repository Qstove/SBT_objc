//
//  AppDelegate.m
//  SearchViaFickr
//
//  Created by Qstove on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "AppDelegate.h"
#import "SVFViewController.h"
#import "SVFNotificationService.h"



@import UserNotifications;

@interface AppDelegate () 

@end

@implementation AppDelegate 


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    SVFViewController *svfViewController = [SVFViewController new];
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:svfViewController];
    self.window.rootViewController = navigationController;
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = svfViewController;
    UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
    [center requestAuthorizationWithOptions:options
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!granted)
                              {
                                  NSLog(@"Доступ не дали");
                              }
                          }];

   
   // [[UINavigationBar appearance] setBarTintColor:UIColor.grayColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application
{
    [SVFNotificationService sheduleLocalNotificationWithInterval];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}



@end
