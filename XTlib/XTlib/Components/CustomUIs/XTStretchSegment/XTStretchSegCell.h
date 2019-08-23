//
//  XTStretchSegCell.h
//  XTlib
//
//  Created by teason23 on 2019/8/20.
//  Copyright © 2019 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface XTStretchSegCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@property (strong, nonatomic) UIView *phView;
@end

NS_ASSUME_NONNULL_END
