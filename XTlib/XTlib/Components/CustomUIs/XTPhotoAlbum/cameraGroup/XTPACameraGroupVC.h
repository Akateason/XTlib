//
//  XTPACameraGroupVC.h
//  XTlib
//
//  Created by teason23 on 2019/2/26.
//  Copyright © 2019 teason23. All rights reserved.
//

#import <XTBase/XTBase.h>
@class PHAssetCollection;

NS_ASSUME_NONNULL_BEGIN
@protocol XTPACameraGroupVCDelegate <NSObject>
- (void)selectAlbumnGroup:(PHAssetCollection *)collection;
@end


@interface XTPACameraGroupVC : RootCtrl
@property (nonatomic, weak) id<XTPACameraGroupVCDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)cameraGroupAnimation:(BOOL)inOrOut onView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
