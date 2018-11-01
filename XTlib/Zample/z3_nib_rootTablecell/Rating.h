//
//  Rating.h
//  XTkit
//
//  Created by teason on 2017/4/21.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Rating : NSObject
@property (nonatomic) float max;
@property (nonatomic) float average;
@property (nonatomic) float min;
@property (nonatomic, copy) NSString *stars;
@end
