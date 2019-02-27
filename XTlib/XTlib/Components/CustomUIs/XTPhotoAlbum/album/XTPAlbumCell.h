//
//  XTPAlbumCell.h
//  XTlib
//
//  Created by teason23 on 2019/2/27.
//  Copyright © 2019 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *identifierAlbumnCell = @"XTPAlbumCell";


@interface XTPAlbumCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *img_picSelect;

//Attrs
@property (nonatomic) BOOL isSingleChoosenMode; // single choosen or multy choosen .
@property (nonatomic) BOOL picSelected;         // only in multy choosen .
@end

NS_ASSUME_NONNULL_END
