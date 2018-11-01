//
//  MySon.h
//  XTkit
//
//  Created by teason23 on 2017/10/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Father.h"
#import "Mother.h"


@interface MySon : NSProxy <BasketballFatherProtocol, MotherBuyClothesProtocol>

+ (instancetype)sonProxy;

@end
