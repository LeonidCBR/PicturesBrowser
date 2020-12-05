//
//  Extensions.m
//  PicBro
//
//  Created by Яна Латышева on 15.08.2020.
//  Copyright © 2020 Motodolphin. All rights reserved.
//

#import "Extensions.h"

@implementation UIView (Anchor)

-(void) setAnchorTop:(nullable NSLayoutYAxisAnchor *)top paddingTop:(CGFloat)paddingTop bottom:(nullable NSLayoutYAxisAnchor *)bottom paddingBottom:(CGFloat)paddingBottom leading:(nullable NSLayoutXAxisAnchor *)leading paddingLeading:(CGFloat)paddingLeading trailing:(nullable NSLayoutXAxisAnchor *)trailing paddingTrailing:(CGFloat)paddingTrailing centerX:(nullable NSLayoutXAxisAnchor *)centerX centerY:(nullable NSLayoutYAxisAnchor *)centerY {

    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (top) {
        [self.topAnchor constraintEqualToAnchor:top constant:paddingTop].active = YES;
    }
    
    if (bottom) {
        [self.bottomAnchor constraintEqualToAnchor:bottom constant:-paddingBottom].active = YES;
    }
    
    if (leading) {
        [self.leadingAnchor constraintEqualToAnchor:leading constant:paddingLeading].active = YES;
    }
    
    if (trailing) {
        [self.trailingAnchor constraintEqualToAnchor:trailing constant:-paddingTrailing].active = YES;
    }
    
    if (centerX) {
        [self.centerXAnchor constraintEqualToAnchor:centerX].active = YES;
    }
    
    if (centerY) {
        [self.centerYAnchor constraintEqualToAnchor:centerY].active = YES;
    }
    
}

@end
