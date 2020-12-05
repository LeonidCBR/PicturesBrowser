//
//  AppDelegate.m
//  PicBro
//
//  Created by Яна Латышева on 14.08.2020.
//  Copyright © 2020 Motodolphin. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "Presenter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Check version of operating system
    NSOperatingSystemVersion ios13_0_0 = (NSOperatingSystemVersion){13, 0, 0};
    if (![[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:ios13_0_0]) {

        // Init window only if iOS version below 13.0
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.rootViewController = [Presenter.shared getHomeController];
        [_window makeKeyAndVisible];
    }

    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options API_AVAILABLE(ios(13.0)) {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions API_AVAILABLE(ios(13.0)) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
