//
//  AppDelegate.m
//  tableView_oppositeCells
//
//  Created by Анатолий Кустов on 09/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *rootVC = [ViewController new];
    UINavigationController *rootNavigationViewController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = rootNavigationViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
