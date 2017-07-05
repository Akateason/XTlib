//
//  RootCtrl.m
//  Teason
//
//  Created by ; on 14-8-21.
//  Copyright (c) 2014年 TEASON. All rights reserved.
//

#import "RootCtrl.h"

@interface RootCtrl ()

@end

@implementation RootCtrl

#pragma mark --
#pragma mark - Life

- (void)dealloc
{
    NSString *title = self.navigationItem.title;
    if (title) {
        NSLog(@"%@\n%@\ndealloc",self.description,title) ;
    }
    else {
        NSLog(@"%@\ndealloc",self.description) ;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning] ;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil] ;
    if (self) {
        
    }
    return self ;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    // Do any additional setup after loading the view.
    [self prepareUI] ;
}

- (void)prepareUI
{
    self.view.backgroundColor = [UIColor whiteColor] ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated] ;
}


@end











