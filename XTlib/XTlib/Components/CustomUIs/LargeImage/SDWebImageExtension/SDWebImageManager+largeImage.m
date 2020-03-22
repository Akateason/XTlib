//
//  SDWebImageManager+largeImage.m
//  owl
//
//  Created by teason23 on 2020/2/26.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import "SDWebImageManager+largeImage.h"

@implementation SDWebImageManager (largeImage)

+ (instancetype)sharedManagerForLargeImage {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] setup];
    });
    return instance;
}

- (nonnull instancetype)setup {
    SDImageCache *cache = [[SDImageCache alloc] init];
    cache.config.shouldCacheImagesInMemory = NO;
    SDWebImageDownloader *downloader = [[SDWebImageDownloader alloc] init];
    return [self initWithCache:cache loader:downloader];
}

@end
