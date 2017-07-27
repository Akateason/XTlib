//
//  XTArchive.h
//  XTkit
//
//  Created by teason23 on 2017/7/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTArchive : NSObject

+ (void)archiveTheObject:(id)obj andPath:(NSString *)path ;

+ (id)getObjUnarchivePath:(NSString *)path ;

@end
