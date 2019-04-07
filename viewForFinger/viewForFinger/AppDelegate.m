//
//  AppDelegate.m
//  viewForFinger
//
//  Created by Анатолий Кустов on 07/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ViewController *rootVC = [ViewController new];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
