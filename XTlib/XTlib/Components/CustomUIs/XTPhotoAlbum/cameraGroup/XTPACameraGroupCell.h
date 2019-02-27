//
//  XTPACameraGroupCell.h
//  XTlib
//
//  Created by teason23 on 2019/2/27.
//  Copyright © 2019 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *identifierCameraGroupCell = @"XTPACameraGroupCell";


@interface XTPACameraGroupCell : UITableViewCell
@property (nonatomic, strong) PHAssetCollection *group;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lb;

@end

NS_ASSUME_NONNULL_END
