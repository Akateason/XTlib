//
//  MovieCell.m
//  XTkit
//
//  Created by teason on 2017/4/24.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "MovieCell.h"
#import "Movie.h"
#import "Images.h"
#import "Rating.h"
#import "UIImageView+WebCache.h"

@interface MovieCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbYear;
@property (weak, nonatomic) IBOutlet UILabel *lbRate;
@end

@implementation MovieCell

// UI and Layout
- (void)prepareUI
{
    self.imgView.contentMode = UIViewContentModeScaleAspectFit ;
    self.lbYear.textColor = [UIColor grayColor] ;
    
    self.imgView.layer.shadowOffset = CGSizeMake(0, 15);
    self.imgView.layer.shadowOpacity = 0.75;
    self.clipsToBounds = YES;
    
    self.lbTitle.backgroundColor = [UIColor clearColor];
    self.lbTitle.layer.shadowOffset = CGSizeMake(0, 2);
    self.lbTitle.layer.shadowOpacity = 0.5;
    //rasterize
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
//我们可以使用shouldRasterize来缓存图层内容。这将会让图层离屏之后渲染一次然后把结果保存起来，直到下次利用的时候去更新（见清单12.2）。
}

// set model
- (void)configure:(id)model ;
{
    Movie *movie = model ;
    if (!movie) return ;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:movie.images.medium]] ;
    self.lbTitle.text = movie.title ;
    self.lbYear.text = movie.year ;
    self.lbRate.text = [NSString stringWithFormat:@"评分 : %@",@(movie.rating.average)] ;
}

// height
+ (CGFloat)cellHeight ;
{
    return 143. ;
}


@end
