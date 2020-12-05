//
//  ImageManager.m
//  PicBro
//
//  Created by Яна Латышева on 18.08.2020.
//  Copyright © 2020 Motodolphin. All rights reserved.
//

#import "ImageManager.h"

@interface ImageManager ()

@property (strong, atomic) NSCache *cacheImages;
@property (strong, atomic) NSMutableDictionary *loadingState;

@end


@implementation ImageManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cacheImages = [NSCache new];
        self.loadingState = [NSMutableDictionary new];
    }
    return self;
}


- (void)clearCache {
    self.cacheImages = [NSCache new];
}


- (void)downloadImageWithPath:(NSString *)imagePath completionHandler:(void (^)(UIImage * _Nullable image, NSString * imagePath, NSString * _Nullable error))completionHandler {

    // Check cache
    UIImage *cachedImage = [self.cacheImages objectForKey:imagePath];
    if (cachedImage) {
        completionHandler(cachedImage, imagePath, nil);
        return;
    }
    
    // There is no image in cache. Downloading...
    NSURL *imageURL = [NSURL URLWithString:imagePath];

    // Check loading status to prevent multiple downloads
    if ([[self.loadingState objectForKey:imagePath] boolValue] == YES) {
        return;
    }
    
    // Set loading status
    [self.loadingState setObject:@YES forKey:imagePath];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForResource = 300; // 5 mins
    if (@available(iOS 11.0, *)) {
        configuration.waitsForConnectivity = YES;
    }
    
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [urlSession downloadTaskWithURL:imageURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {

  
        if (error) {
            [self.loadingState setObject:@NO forKey:imagePath];
            NSString *errorMsg = error.localizedDescription;
            completionHandler(nil, imagePath, errorMsg);
            return;
        }
        
        if (!location) {
            [self.loadingState setObject:@NO forKey:imagePath];
            NSString *errorMsg = NSLocalizedString(@"Cannot find location.", nil);
            completionHandler(nil, imagePath, errorMsg);
            return;
        }
        
        // Get Data
        NSData *data = [NSData dataWithContentsOfURL:location];
        if (!data) {
            [self.loadingState setObject:@NO forKey:imagePath];
            NSString *errorMsg = NSLocalizedString(@"Cannot get data from location.", nil);
            completionHandler(nil, imagePath, errorMsg);
            return;
        }
        
        // Get Image
        UIImage *downloadedImage = [UIImage imageWithData:data];
        if (!downloadedImage) {
            [self.loadingState setObject:@NO forKey:imagePath];
            NSString *errorMsg = NSLocalizedString(@"Cannot get image from data.", nil);
            completionHandler(nil, imagePath, errorMsg);
            return;
        }
           
        // Save image to cache
        [self.cacheImages setObject:downloadedImage forKey:imagePath];
        
        completionHandler(downloadedImage, imagePath, nil);

        // Unset loading flag
        [self.loadingState setObject:@NO forKey:imagePath];

        
    }]; //completionHandler
    

    [downloadTask resume];
    
}


@end
