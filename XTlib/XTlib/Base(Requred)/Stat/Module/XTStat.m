//
//  XTStat.m
//  XTkit
//
//  Created by teason23 on 2017/7/8.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTStat.h"
#import "XTFMDB.h"
#import "ApplicationEvent.h"
#import "CtrllerEvent.h"
#import "ListEvent.h"
#import "ValetManager.h"
#import "DevInfo.h"

@implementation XTStat

- (void)prepare {
    [ApplicationEvent xt_createTable] ;
    [CtrllerEvent     xt_createTable] ;
    [ListEvent        xt_createTable] ;
    // uuid
    [[ValetManager sharedInstance] prepareUUID] ;
}

- (void)UploadFirstTimeDeviceInfoIfNeeded {
    DevInfo *devInfo = [DevInfo new] ;
    devInfo.UUID = [[ValetManager sharedInstance] UUID] ;
//    devInfo.
}

@end
