//
//  Algorithm.h
//  XTkit
//
//  Created by teason23 on 2017/11/4.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^Sort)(int x, int y) ;

@interface Algorithm : NSObject

+ (void)bubbleSortWithArray:(NSMutableArray *)arr
                    andSort:(Sort)sort ;

@end
