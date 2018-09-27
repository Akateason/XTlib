//
//  TestDemoVC.m
//  XTlib
//
//  Created by teason23 on 2018/9/12.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "TestDemoVC.h"
#import "XTlib.h"
#import "UIImageView+WebCache.h"


@interface TestDemoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@end

@implementation TestDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *urlStr = @"https://drive.shimodev.com/drive-api/files/HjcJASWo7YAlCxvj/thumbnail" ;
    NSURL *url = [NSURL URLWithString:urlStr] ;
    
//    获取有header的image
    
    // 方法1
    SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader] ;
    [manager setValue:@"shimo_dev_sid=s%3A1F6uUxbCD4mk4a4yQ1GWn66kUliPiVp7.%2FfsvAGZzTpviU%2BXQTJKYVjXMi96UhY5ZVOMN%2FeGbSks" forHTTPHeaderField:@"Cookie"] ;
    [_imageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }] ;
    
    // 方法2
    [XTRequest downLoadFileWithSavePath:XT_DOCUMENTS_PATH_TRAIL_(@"test2") fromUrlString:urlStr header:@{@"Cookie":@"shimo_dev_sid=s%3A1F6uUxbCD4mk4a4yQ1GWn66kUliPiVp7.%2FfsvAGZzTpviU%2BXQTJKYVjXMi96UhY5ZVOMN%2FeGbSks"} downLoadProgress:^(float progressVal) {
        
    } success:^(id response, id dataFile) {
        UIImage *image = [UIImage imageWithData:dataFile] ;
        _bottomImageView.image = image ;
    } fail:^(NSError *error) {
        
    }] ;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
