//
//  Presenter.m
//  PicBro
//
//  Created by Яна Латышева on 17.08.2020.
//  Copyright © 2020 Motodolphin. All rights reserved.
//

#import "Presenter.h"
#import "MainViewController.h"

@implementation Presenter

+ (instancetype) shared {
    static Presenter *sharedObject = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedObject = [self new];
    });
    return sharedObject;
}


- (UINavigationController *)getHomeController {
    MainViewController *mainViewController = [MainViewController new];
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    return homeNavigationController;
}


- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message viewController:(UIViewController *)vc {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [vc presentViewController:alert animated:true completion:nil];
}

@end
