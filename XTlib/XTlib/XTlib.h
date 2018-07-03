//
//  XTlib.h
//  XTlib
//
//  Created by xtc on 2018/1/29.
//  Copyright © 2018年 teason. All rights reserved.
//

#ifndef XTlib_h
#define XTlib_h

#define xt_DEBUG    1

#if xt_DEBUG
#define NSLog(format, ...) do {                                             \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "🏀🏀🏀🏀🏀\n");                                           \
} while (0)

#else
#   define NSLog(...)
#endif

// header
#import "ArchiveHeader.h"
#import "KeyChainHeader.h"
#import "NotificationCenterHeader.h"
#import "PictureHeader.h"
#import "PublicEnum.h"
#import "UrlRequestHeader.h"
#import "WordsHeader.h"
#import "ScreenHeader.h"
#import "DeviceSysHeader.h"
#import "FastCodeHeader.h"

// Root
#import "RootTableView.h"
#import "RootTableCell.h"
#import "RootRefreshHeader.h"
#import "RootRefreshFooter.h"
#import "RootCollectionCell.h"
#import "RootCollectionView.h"
#import "RootCustomView.h"
//#import "MyNavCtrller.h"
//#import "MySearchBar.h"
//#import "MyTabbar.h"
//#import "MyTabbarCtrller.h"
//#import "MyTextField.h"
//#import "MyTextView.h"
//#import "MyWebController.h"
//#import "RootCtrl.h"

// Category
#import "UIFont+FontAdapter.h"
#import "NSNumber+Round.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "NSDate+XTTick.h"
#import "NSDate+NSCalendar.h"
#import "NSObject+Reflection.h"
#import "NSObject+Runtime.h"
#import "NSString+Extend.h"
#import "UIButton+Countdown.h"
#import "UIButton+ExtendTouchRect.h"
#import "UIImage+AddFunction.h"
#import "UIImageView+QNExtention.h"
#import "UIView+Sizes.h"
#import "UIView+XTAddition.h"
#import "UIViewController+XTAddition.h"
#import "UIResponder+ChainHandler.h"
#import "NSTimer+Addition.h"
#import "UILabel+Calculate.h"
#import "UILabel+Addition.h"
#import "UIAlertController+XTAddition.h"

// DataBase
#import "XTFMDB.h"

// Color
#import "XTColor.h"

// Request
#import "XTReq.h"

// UIs
#import "XTZoomPicture.h"
#import "ParallaxHeaderView.h"
#import "PlaceHolderTextView.h"
//#import "XTBarrageItemView.h"
#import "XTlineSpaceLabel.h"
#import "XTLoopScrollView.h"
#import "XTMultipleTables.h"
#import "XTTableViewRootHandler.h"
#import "XTNetReloader.h"
#import "XTSegment.h"
#import "XTStretchSegment.h"
#import "XTSIAlertView.h"

// Util
#import "NSString+MD5.h"
#import "Base64.h"
#import "PlistUtil.h"
#import "IsFirstTime.h"
#import "CommonFunc.h"
#import "ShareDigit.h"
#import "XTAnimation.h"
#import "XTFileManager.h"
#import "XTArchive.h"
#import "ValetManager.h"
#import "XTJson.h"
#import "XTVerification.h"


#endif /* XTlib_h */
