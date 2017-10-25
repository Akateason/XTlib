//
//  Mother.m
//  XTkit
//
//  Created by teason23 on 2017/10/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Mother.h"

@interface Mother () <MotherBuyClothesProtocol>
@end

@implementation Mother

- (void)buyClothesWithSize:(ClothesSize)size {
    NSString *sizeStr;
    switch (size) {
        case ClothesSizeLarge:
            sizeStr = @"large size";
            break;
        case ClothesSizeMedium:
            sizeStr = @"medium size";
            break;
        case ClothesSizeSmall:
            sizeStr = @"small size";
            break;
        default:
            break;
    }
    NSLog(@"bought some clothes of %@",sizeStr);
}

@end
