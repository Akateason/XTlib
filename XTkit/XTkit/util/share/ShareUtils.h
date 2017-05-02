//
//  ShareUtils.h
//  SuBaoJiang
//
//  Created by apple on 15/7/24.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WeiboSDK.h"


@interface ShareUtils : NSObject <WXApiDelegate,WeiboSDKDelegate>

//weibo
//@property (strong, nonatomic) NSString *wbtoken ;
//@property (strong, nonatomic) NSString *wbCurrentUserID ;
//@property (strong, nonatomic) NSString *wbRefreshToken ;

/**
 *  appdelegate weixin
 */
- (BOOL)handleOpenUrl:(NSURL *)url ;

/**
 *  weixin
 */
+ (BOOL)wx_sendLinkURL:(NSString *)urlString
               TagName:(NSString *)tagName
                 Title:(NSString *)title
           Description:(NSString *)description
            ThumbImage:(UIImage *)thumbImage
               InScene:(enum WXScene)scene ;

/**
 *  weibo
 */
+ (void)wb_sendTitleAndUrl:(NSString *)titleAndUrl
                thumbImage:(UIImage *)thumbImage ;




@end
