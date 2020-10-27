//
//  Human.h
//  XTlib
//
//  Created by teason23 on 2020/10/27.
//  Copyright © 2020 teason23. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Human : NSObject

@property (nonatomic ,strong) NSString *name;

+ (instancetype)humanWithName:(NSString *)n;

@end

NS_ASSUME_NONNULL_END
