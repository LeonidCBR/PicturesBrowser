//
//  Presenter.h
//  PicBro
//
//  Created by Яна Латышева on 17.08.2020.
//  Copyright © 2020 Motodolphin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Presenter : NSObject

+ (instancetype) shared;

- (UINavigationController *)getHomeController;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message viewController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
