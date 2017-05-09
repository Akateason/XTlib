//
//  XTReqResonse.h
//  XTkit
//
//  Created by teason23 on 2017/5/8.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTReqResonse : NSObject

@property (nonatomic)           NSInteger       errCode     ;
@property (nonatomic,copy)      NSString        *message    ;
@property (nonatomic,strong)    NSDictionary    *info       ;

@end
