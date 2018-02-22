//
//  StatSender.m
//  XTkit
//
//  Created by teason23 on 2017/7/8.
//  Copyright © 2017年 teason. All rights reserved.
//
// 发射器. 设计首包, 无埋点的上传 .


#import "StatSender.h"
#import <SSZipArchive/SSZipArchive.h>
#import "NSDate+XTTick.h"
#import "XTJson.h"

#import "ApplicationEvent.h"
#import "CtrllerEvent.h"
#import "ListEvent.h"
#import "CommonFunc.h"

@implementation StatSender

- (void)setup {
    
}

- (void)combine {
    NSArray *appEventList       = [ApplicationEvent selectWhere:@"uploaded = '0'"] ;
    NSArray *ctrllerEventList 	= [CtrllerEvent     selectWhere:@"uploaded = '0'"] ;
    NSArray *listEventList      = [ListEvent        selectWhere:@"uploaded = '0'"] ;
    NSDictionary *dic = @{
                          @"ApplicationEvent"   : appEventList ,
                          @"CtrllerEvent"       : ctrllerEventList ,
                          @"ListEvent"          : listEventList ,
                          } ;
    NSString *jsonStr = [XTJson getStrWithJson:dic] ;
    NSString *appendTick = [NSString stringWithFormat:@"/xtStat%@.txt",[[NSDate date] xt_getStr]] ;
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:appendTick] ;
    [jsonStr writeToFile:path
              atomically:YES
                encoding:NSUTF8StringEncoding
                   error:nil] ;
    NSString *zipPath = [path stringByAppendingString:@".zip"] ;
    if ([SSZipArchive createZipFileAtPath:zipPath
                         withFilesAtPaths:@[path]]) {
        NSLog(@"make zip success : %@",zipPath) ;
        // make sure send to server .
        // update uploaded from lists .
        // end .
    }
    else {
        NSLog(@"make zip fail") ;
    }
}


@end





