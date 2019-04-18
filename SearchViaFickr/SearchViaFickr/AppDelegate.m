//
//  AppDelegate.m
//  SearchViaFickr
//
//  Created by Qstove on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "AppDelegate.h"
#import "SVFViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SVFViewController *svfViewController = [SVFViewController new];
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:svfViewController];
    self.window.rootViewController = navigationController;
   // [[UINavigationBar appearance] setBarTintColor:UIColor.grayColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
