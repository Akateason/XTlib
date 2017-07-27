//
//  StatSender.h
//  XTkit
//
//  Created by teason23 on 2017/7/8.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatSender : NSObject

- (NSString *)writeToFile:(NSArray *)list ;

- (BOOL)archiveZip:(NSString *)zipPath withDirectory:(NSString *)filePath ;

- (NSData *)unarchiveZip:(NSString *)zipPath ;

- (NSArray *)readFromFile:(NSString *)filePath ;

@end
