//
//  Movie.h
//  XTkit
//
//  Created by teason on 2017/4/21.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Rating, Images;


@interface Movie : NSObject

@property (nonatomic) NSUInteger idMovie;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *original_title;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *alt; //url
@property (nonatomic, strong) Rating *rating;
@property (nonatomic, strong) Images *images;

@end
