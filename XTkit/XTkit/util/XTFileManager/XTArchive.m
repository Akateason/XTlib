//
//  XTArchive.m
//  XTkit
//
//  Created by teason23 on 2017/7/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTArchive.h"

@implementation XTArchive

+ (void)archiveTheObject:(id)obj andPath:(NSString *)path {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:path];
    if (success) {
        NSLog(@"xtArchive : %@\n success in path : %@",obj,path) ;
    }
}

+ (id)getObjUnarchivePath:(NSString *)path {
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:path] ;
    return obj;
}

@end
