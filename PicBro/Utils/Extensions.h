//
//  Extensions.h
//  PicBro
//
//  Created by Яна Латышева on 15.08.2020.
//  Copyright © 2020 Motodolphin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Anchor)

-(void) setAnchorTop:(nullable NSLayoutYAxisAnchor *)top paddingTop:(CGFloat)paddingTop bottom:(nullable NSLayoutYAxisAnchor *)bottom paddingBottom:(CGFloat)paddingBottom leading:(nullable NSLayoutXAxisAnchor *)leading paddingLeading:(CGFloat)paddingLeading trailing:(nullable NSLayoutXAxisAnchor *)trailing paddingTrailing:(CGFloat)paddingTrailing centerX:(nullable NSLayoutXAxisAnchor *)centerX centerY:(nullable NSLayoutYAxisAnchor *)centerY;

@end

NS_ASSUME_NONNULL_END
