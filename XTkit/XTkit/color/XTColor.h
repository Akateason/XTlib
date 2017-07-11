//
//  XTColor.h
//  XTkit
//
//  Created by teason23 on 2017/7/11.
//  Copyright © 2017年 teason. All rights reserved.
//

#ifndef XTColor_h
#define XTColor_h

#import "XTColorFetcher.h"
#import "XTColorFetcher+Dynamic.h"

#define UIColorWithKey(__name__)        [[XTColorFetcher sharedInstance] fetchColor:(__name__)]



#endif /* XTColor_h */
