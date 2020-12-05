//
//  MainCell.m
//  PicBro
//
//  Created by Яна Латышева on 15.08.2020.
//  Copyright © 2020 Motodolphin. All rights reserved.
//

#import "MainCell.h"
#import "Extensions.h"

@implementation MainCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.removable = NO;
        self.imagePath = nil;
        
        // MARK: Configure Image View
        self.imageView = [UIImageView new];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        
        [self addSubview:_imageView];
        [self.imageView setAnchorTop:self.topAnchor paddingTop:0 bottom:self.bottomAnchor paddingBottom:0 leading:self.leadingAnchor paddingLeading:0 trailing:self.trailingAnchor paddingTrailing:0 centerX:nil centerY:nil];
        
    }
    return self;
}

@end
