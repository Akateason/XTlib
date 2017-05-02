//
//  ShareUtils.m
//  SuBaoJiang
//
//  Created by apple on 15/7/24.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "ShareUtils.h"
#import "AppDelegate.h"
#import "DigitInformation.h"
#import "CommonFunc.h"
#import "WXMediaMessage+messageConstruct.h"
#import "SendMessageToWXReq+requestWithTextOrMediaMessage.h"

@implementation ShareUtils

/**
 *  appdelegate
 */
- (BOOL)handleOpenUrl:(NSURL *)url
{
    NSLog(@"url : %@",url.absoluteString) ;
    if ([url.absoluteString hasPrefix:@"wx"]) {
        return [WXApi handleOpenURL:url delegate:self] ;
    }
    else if ([url.absoluteString hasPrefix:@"wb"]) {
        return [WeiboSDK handleOpenURL:url delegate:self] ;
    }
    return YES ;
}


+ (BOOL)wx_sendLinkURL:(NSString *)urlString
               TagName:(NSString *)tagName
                 Title:(NSString *)title
           Description:(NSString *)description
            ThumbImage:(UIImage *)thumbImage
               InScene:(enum WXScene)scene
{
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlString;
    WXMediaMessage *message = [WXMediaMessage messageWithTitle:title
                                                   Description:description
                                                        Object:ext
                                                    MessageExt:nil
                                                 MessageAction:nil
                                                    ThumbImage:thumbImage
                                                      MediaTag:tagName];
    
    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
                                                   OrMediaMessage:message
                                                            bText:NO
                                                          InScene:scene];
    return [WXApi sendReq:req];
}


+ (void)wb_sendTitleAndUrl:(NSString *)titleAndUrl
          thumbImage:(UIImage *)thumbImage
{
//    image = [CommonFunc getSuBaoJiangWaterMask:image] ;
//    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate] ;
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request] ;
    authRequest.redirectURI = WB_REDIRECTURL ;
    authRequest.scope = @"all" ;
    
    WBMessageObject *message = [WBMessageObject message] ;
    message.text = titleAndUrl ;
    WBImageObject *imageObj = [WBImageObject object] ;
    imageObj.imageData = UIImageJPEGRepresentation(thumbImage,1) ;
    message.imageObject = imageObj ;
//    NSLog(@"weibo access token %@",myDelegate.wbtoken) ;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message
                                                                                  authInfo:authRequest                                                                              access_token:nil] ;
    [WeiboSDK sendRequest:request] ;
}

#pragma mark --
#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response ;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken) {
//            self.wbtoken = accessToken ;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
//            self.wbCurrentUserID = userID ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (sendMessageToWeiboResponse.statusCode == WeiboSDKResponseStatusCodeSuccess)
            {
                NSLog(@"weibo 分享成功") ;
                // [XTHudManager showWordHudWithTitle:WD_HUD_SHARE_SUCCESS] ;
            }
        }) ;
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
//        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
//        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
//        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
        
//        NSDictionary *userInfoDic = [ServerRequest getWeiboUserInfoWithToken:self.wbtoken AndWithUid:self.wbCurrentUserID] ;
//        
//        NSString *userName = [userInfoDic objectForKey:@"screen_name"] ; //用户名
//        NSString *avatar_large = [userInfoDic objectForKey:@"avatar_large"] ; //大头图
//        NSNumber *gender = @0 ; //性别
//        NSString *genderStr = [userInfoDic objectForKey:@"gender"] ;
//        if ([genderStr hasPrefix:@"m"]) {
//            gender = @1 ;
//        }
//        else if ([genderStr hasPrefix:@"f"]) {
//            gender = @2 ;
//        }
//        NSString *descrip = [userInfoDic objectForKey:@"description"] ; //描述
//        
//        [ServerRequest loginUnitWithCategory:mode_WeiBo
//                                    wxopenID:nil
//                                   wxUnionID:nil
//                                    nickName:userName
//                                      gender:gender
//                                    language:nil
//                                     country:nil
//                                    province:nil
//                                        city:nil
//                                     headpic:avatar_large
//                                       wbuid:self.wbCurrentUserID
//                                 description:descrip
//                                    username:nil
//                                    password:nil
//                                     Success:^(id json) {
//                                         
//                                         ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
//                                         [CommonFunc logSussessedWithResult:result
//                                                          AndWithController:self.thirdLoginCtrller] ;
//                                         [CommonFunc bindWithBindMode:mode_weibo] ;
//                                         
//                                     } fail:^{
//                                         dispatch_async(dispatch_get_main_queue(), ^{
//                                             [XTHudManager showWordHudWithTitle:WD_HUD_FAIL_RETRY] ;
//                                         }) ;
//                                     }] ;
    }
}




@end
