//
//  MPTestView.h
//  
//
//  Created by teason23 on 2018/5/15.
//https://www.jianshu.com/p/4f7b3c9801f5


#import <UIKit/UIKit.h>

@protocol MPTestViewProtocol <NSObject>
@optional
@property(nonatomic, weak)  UILabel *label;
@property(nonatomic, weak)  UIButton *button;
@property(nonatomic, weak)  UITableView *tableView;
@end

@interface MPTestView : UIView <MPTestViewProtocol>
@property(nonatomic, weak) IBOutlet UILabel *label;
@property(nonatomic, weak) IBOutlet UIButton *button;
@property(nonatomic, weak) IBOutlet UITableView *tableView;
@end
