//
//  XTPACameraGroupCell.m
//  XTlib
//
//  Created by teason23 on 2019/2/27.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "XTPACameraGroupCell.h"
#import <XTBase/XTBase.h>


@implementation XTPACameraGroupCell

- (void)setGroup:(PHAssetCollection *)group {
    _group = group;

    WEAK_SELF
    @autoreleasepool {
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:group options:nil];
        if (fetchResult.count > 0) {
            PHAsset *asset                 = (PHAsset *)fetchResult.firstObject;
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];

            [[PHImageManager defaultManager] requestImageForAsset:asset
                                                       targetSize:CGSizeMake(108, 108)
                                                      contentMode:PHImageContentModeAspectFill
                                                          options:options
                                                    resultHandler:^(UIImage *_Nullable result, NSDictionary *_Nullable info) {
                                                        weakSelf.img.image = result;
                                                    }];
        }

        NSString *strShow = [NSString stringWithFormat:@"%@（%lu）", group.localizedTitle, (unsigned long)fetchResult.count];
        _lb.text          = strShow;
    }
}

- (void)dealloc {
    _group = nil;
}

@end
