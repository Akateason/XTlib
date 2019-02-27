//
//  XTPAlbumCell.h
//  XTlib
//
//  Created by teason23 on 2019/2/27.
//  Copyright © 2019 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString     *identifierAlbumnCell   = @"AlbumnCell" ;

@interface XTPAlbumCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *img_picSelect;



//Attrs
@property (nonatomic) BOOL                       picSelected ;   // only in multyType

@end

NS_ASSUME_NONNULL_END
