//
//  PublicEnum.h
//  subao
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#ifndef subao_PublicEnum_h
#define subao_PublicEnum_h

/*
 页面跳转. (系统通知,首页banner)
 **/
typedef NS_ENUM(NSInteger , MODE_skipCategory)
{
    mode_advertise = 1, //广告 h5
    mode_activity ,     //活动 h5
    mode_topic ,        //话题 t_id
    mode_detail         //详情 a_id
} ;

/**
 category
 用户分类，1为微信，2为微博，3为用户名密码登录
 */
typedef NS_ENUM(NSInteger , MODE_LOGIN_CATE)
{
    mode_WeiXin = 1 ,
    mode_WeiBo  ,
    mode_Local
} ;

/**
 举报类型，1为文章，2为用户
 */
typedef enum {
    mode_Article = 1 ,
    mode_User  ,
} MODE_TYPE_REPORT ;


#endif
