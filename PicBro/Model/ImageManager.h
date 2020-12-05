//
//  ImageManager.h
//  PicBro
//
//  Created by Яна Латышева on 18.08.2020.
//  Copyright © 2020 Motodolphin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageManager : NSObject

- (void)clearCache;

- (void)downloadImageWithPath:(NSString *)imagePath completionHandler:(void (^)(UIImage * _Nullable image, NSString * imagePath, NSString * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
