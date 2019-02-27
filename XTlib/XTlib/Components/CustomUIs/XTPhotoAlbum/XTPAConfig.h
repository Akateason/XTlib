//
//  XTPAConfig.h
//  XTlib
//
//  Created by teason23 on 2019/2/26.
//  Copyright © 2019 teason23. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface XTPAConfig : NSObject

@property (nonatomic) int albumSelectedMaxCount;          // default 5 .
@property (nonatomic) int albumColumnCount;               // default 4 .
@property (nonatomic) float albumItemFlex;                // flex of album cell items .
@property (readonly, nonatomic) BOOL isSingleChoosenMode; // single image picker when maxcount is 1 .
@property (strong, nonatomic) UIColor *tintColor;

@end

NS_ASSUME_NONNULL_END
