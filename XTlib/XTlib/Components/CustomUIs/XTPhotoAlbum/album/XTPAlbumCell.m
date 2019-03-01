//
//  XTPAlbumCell.m
//  XTlib
//
//  Created by teason23 on 2019/2/27.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "XTPAlbumCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <XTBase/XTBase.h>


@implementation XTPAlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _img.contentMode      = UIViewContentModeScaleAspectFill;
    _img_picSelect.hidden = NO;
}

#pragma mark - Prop

- (void)setPicSelected:(BOOL)picSelected {
    _picSelected = picSelected;

    NSString *imgStr     = picSelected ? @"ab_selected" : @"ab_select";
    _img_picSelect.image = [UIImage imageNamed:imgStr inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
}

- (void)setIsSingleChoosenMode:(BOOL)isSingleChoosenMode {
    _isSingleChoosenMode = isSingleChoosenMode;

    self.img_picSelect.hidden = isSingleChoosenMode;
}

@end
