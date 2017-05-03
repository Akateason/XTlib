//
//  RootCtrl.m
//  Teason
//
//  Created by ; on 14-8-21.
//  Copyright (c) 2014年 TEASON. All rights reserved.
//

#import "RootCtrl.h"
#import "SDImageCache.h"
//#import "MobClick.h"‘

@interface RootCtrl ()

@end

@implementation RootCtrl

#pragma mark --
#pragma mark - Life

- (void)dealloc {}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    [[SDImageCache sharedImageCache] clearMemory] ; // sd clear cache
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil] ;
    if (self)
    {
        // Custom initialization
    }
    return self ;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor] ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
//    [MobClick beginLogPageView:self.myTitle] ;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self judgeIsSelfDismiss] ; //  click back button in NavgationBar
    
    [super viewWillDisappear:animated] ;
//    [MobClick endLogPageView:self.myTitle] ;
}

- (void)judgeIsSelfDismiss
{
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
    {
        if ([self respondsToSelector:@selector(navigationBackButtonOnClick)])
        {
            [self navigationBackButtonOnClick] ;
        }
    }
}



#pragma mark --
#pragma mark - click back button in NavgationBar
- (void)navigationBackButtonOnClick
{
    // rewrite this in subClass if necessary .
}


#pragma mark --
#pragma mark - Set No Back BarButton
- (void)deleteAllNavigationBarButtons:(BOOL)isDel
{
    if (isDel == TRUE)
    {
        self.navigationItem.leftBarButtonItem = nil ;
        self.navigationItem.backBarButtonItem = nil ;
    }
}

#pragma mark --
#pragma mark - title for Umeng Anaylize .
- (NSString *)myTitle
{
    if (!_myTitle)
    {
        _myTitle = self.title ;
    }
    return _myTitle ;
}



@end











