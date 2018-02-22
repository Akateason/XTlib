//
//  Movie.m
//  XTkit
//
//  Created by teason on 2017/4/21.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Movie.h"

@implementation Movie
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"id" : @"idMovie"} ;
}
@end
