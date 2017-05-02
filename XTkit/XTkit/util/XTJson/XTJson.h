//
//  XTJson.h
//  subao
//
//  Created by TuTu on 16/1/7.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTJson : NSObject

+ (id)getJsonObj:(NSString *)jsonStr ;
+ (NSString *)getJsonStr:(id)jsonObj ;

@end
