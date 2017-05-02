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
- (void)prepare ;
{
    self.imgView.contentMode = UIViewContentModeScaleAspectFit ;
    self.lbYear.textColor = [UIColor grayColor] ;
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
