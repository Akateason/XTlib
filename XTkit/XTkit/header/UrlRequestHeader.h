//
//  UrlRequestHeader.h
//  SuBaoJiang
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#ifndef SuBaoJiang_UrlRequestHeader_h
#define SuBaoJiang_UrlRequestHeader_h

//  服务器ip地址切换
static NSString *const G_IP_SERVER              = @"http://cms.subaojiang.com/" ;

//  通过ContentID访问文章h5页面
#define URL_SHOW_CONTENT_WITHID(CID)            [NSString stringWithFormat:@"http://cms.subaojiang.com/content/showContentH?contentId=%d",CID]

//  获取骑牛token
static NSString *const URL_QINIU_TOKEN          = @"Index/get_qiniu_token" ;

//  微猫
static NSString *const URL_WEMART_SIGN          = @"http://api3.subaojiang.com/Wemart/sign" ;

//  获取类型 列表 .                        i/h
static NSString *const URL_KIND_ALL             = @"kind/all" ;

//  获取内容列表    app                    i/h
static NSString *const URL_CONTENT_ALIST        = @"content/alist" ;

//  获取内容详情                            i/hP : 内容id .
static NSString *const URL_CONTENT_DETAIL       = @"content/detail" ;

//  搜索 获取内容列表
static NSString *const URL_CONTENT_SEARCH       = @"content/search" ;



//  标签 模糊搜索  返回列表            h
static NSString *const URL_TAG_SEARCH           = @"tag/search" ;

//  增加阅读数
static NSString *const URL_ADD_READ             = @"content/addRead" ;

//  速报酱
static NSString *const URL_SBJ_INDEX_TIMELINE   = @"http://api3.subaojiang.com/index/public_timeline_by_time" ;

// 一直播 列表
static NSString *const URL_YZB_LIST             = @"http://api.open.xiaoka.tv/openapi/live/get_hot_live_video" ;


//获取话题颜色
static NSString *const URL_CATE_COLOR           = @"http://api3.subaojiang.com/index/get_category_color" ;

//获取他人主页
static NSString *const URL_OTHER_HOMEPAGE       = @"http://api3.subaojiang.com/user/homepage" ;

//获取文章点赞集合
static NSString *const URL_DETAIL_PRAISE        = @"http://api3.subaojiang.com/index/show_detail_praise" ;

//获取文章详情
#define URL_ARTICLE_DETAIL                        @"http://api3.subaojiang.com/index/show_article_total"

//获取文章评论
#define URL_GET_COMMENT                           @"http://api3.subaojiang.com/index/show_detail_comment"

//举报
#define URL_REPORT                                @"http://api3.subaojiang.com/index/report_article"

#define SHARE_DETAIL_URL                          @"http://m.subaojiang.com/index/detail.html?id=%d"


#endif
