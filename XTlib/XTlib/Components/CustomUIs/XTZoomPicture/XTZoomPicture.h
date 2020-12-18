//
//  XTZoomPicture.h
//  XTZoomPicture
//
//  Created by teason on 15/12/3.
//  Copyright © 2015年 teason. All rights reserved.
//
// XTZoomPicture
// 处理小图片的缩放, 不适合大图渲染
// 需要 setImageView
/* e.g.
    XTZoomPicture *zp = [[XTZoomPicture alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:zp];
    [zp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [zp.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2943767315,2930939798&fm=26&gp=0.jpg"]
                    placeholderImage:nil
                             options:(0)
                            progress:nil
                           completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [zp reset];
    }];
*/


#import <UIKit/UIKit.h>


@interface XTZoomPicture : UIScrollView
@property (nonatomic, strong) UIImageView *imageView;
- (void)onTapped:(void(^)(void))tapped;
- (void)reset; // 回到初始化状态 , 例如: 在外部异步处理后调用

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (instancetype)init ;
@end
