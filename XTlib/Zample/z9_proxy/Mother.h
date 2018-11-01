//
//  Mother.h
//  XTkit
//
//  Created by teason23 on 2017/10/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ClothesSize) {
    ClothesSizeSmall = 0,
    ClothesSizeMedium,
    ClothesSizeLarge
};

@protocol MotherBuyClothesProtocol <NSObject>
- (void)buyClothesWithSize:(ClothesSize)size;
@end


@interface Mother : NSObject

@end
