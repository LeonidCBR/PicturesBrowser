//
//  MainCell.h
//  PicBro
//
//  Created by Яна Латышева on 15.08.2020.
//  Copyright © 2020 Motodolphin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;
@property (weak, atomic) NSString *imagePath;
@property (nonatomic) bool removable;
@property (nonatomic) bool loading;

@end

NS_ASSUME_NONNULL_END
