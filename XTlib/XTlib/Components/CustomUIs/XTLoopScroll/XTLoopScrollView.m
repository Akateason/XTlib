//
//  XTLoopScrollView.m
//  XTLoopScroll
//
//  Created by TuTu on 15/10/30.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTLoopScrollView.h"
#import <XTBase/XTBase.h>

static int IMAGEVIEW_COUNT = 3;


@interface XTLoopScrollView () <UIScrollViewDelegate> {
    UIScrollView *_scrollView;

    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;

    UIPageControl *_pageControl;
    UILabel *_label;

    int _imageCount;
    BOOL _bLoop;
    NSInteger _durationOfScroll;

    NSTimer *_timerLoop;     // 控制循环
    NSTimer *_timerOverflow; // 控制手动后的等待时间
    BOOL bOpenTimer;         // 开关
}
@property (nonatomic) int currentImageIndex;
@property (nonatomic, copy) NSArray *imglist; //dataSource list , string .

@end


@implementation XTLoopScrollView
@synthesize color_currentPageControl = _color_currentPageControl,
            color_pageControl        = _color_pageControl;

#pragma - Property
- (void)setColor_pageControl:(UIColor *)color_pageControl {
    _color_pageControl = color_pageControl;

    _pageControl.pageIndicatorTintColor = _color_pageControl;
}

- (UIColor *)color_pageControl {
    if (!_color_pageControl) {
        _color_pageControl = [UIColor grayColor];
    }
    return _color_pageControl;
}

- (void)setColor_currentPageControl:(UIColor *)color_currentPageControl {
    _color_currentPageControl = color_currentPageControl;

    _pageControl.currentPageIndicatorTintColor = _color_currentPageControl;
}

- (UIColor *)color_currentPageControl {
    if (!_color_currentPageControl) {
        _color_currentPageControl = [UIColor darkGrayColor];
    }
    return _color_currentPageControl;
}

#pragma - Initial
- (instancetype)initWithFrame:(CGRect)frame
                 andImageList:(NSArray *)imglist
                      canLoop:(BOOL)canLoop
                     duration:(NSInteger)duration {
    self = [super init];
    if (self) {
        self.frame           = frame;
        _imglist             = imglist;
        _imageCount          = (int)self.imglist.count;
        _bLoop               = canLoop;
        _durationOfScroll    = duration;
        self.backgroundColor = [UIColor whiteColor];
        [self setup];

        if (_bLoop) {
            [self loopStart];
        }
    }

    return self;
}

- (void)setup {
    //添加滚动控件
    [self addScrollView];
    //添加图片控件
    [self addImageViews];
    //添加分页控件
    [self addPageControl];
    //添加图片信息描述控件
    [self addLabel];
    //加载默认图片
    [self setDefaultImage];
}

- (void)loopStart {
    _timerLoop = [NSTimer timerWithTimeInterval:_durationOfScroll
                                         target:self
                                       selector:@selector(loopAction)
                                       userInfo:nil
                                        repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:_timerLoop
                                 forMode:NSDefaultRunLoopMode];
}

- (void)loopAction {
    int leftImageIndex, rightImageIndex;
    _currentImageIndex     = (_currentImageIndex + 1) % _imageCount;
    _centerImageView.image = [UIImage imageNamed:_imglist[_currentImageIndex]];

    leftImageIndex  = (_currentImageIndex + _imageCount - 1) % _imageCount;
    rightImageIndex = (_currentImageIndex + 1) % _imageCount;

    _leftImageView.image  = [UIImage imageNamed:_imglist[leftImageIndex]];
    _rightImageView.image = [UIImage imageNamed:_imglist[rightImageIndex]];

    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:NO];

    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_centerImageView.layer addAnimation:animation forKey:nil];

    _pageControl.currentPage = _currentImageIndex;
    NSString *imageName      = _imglist[_currentImageIndex];
    _label.text              = imageName;

    //    NSLog(@"auto loop at index : %d",_currentImageIndex) ;
}

#pragma mark 添加控件
- (void)addScrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    CGRect rect       = CGRectZero;
    rect.size         = self.frame.size;
    _scrollView.frame = rect;

    _scrollView.delegate = self;
    //设置contentSize
    _scrollView.contentSize = CGSizeMake(IMAGEVIEW_COUNT * _scrollView.frame.size.width, _scrollView.frame.size.height);
    //设置当前显示的位置为中间图片
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:NO];

    _scrollView.pagingEnabled                  = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;

    [self addSubview:_scrollView];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)];
    [_scrollView addGestureRecognizer:tapGesture];
}

- (void)tapScrollView {
    //    NSLog(@"tap : %d",self.currentImageIndex) ;
    [self.delegate tapingCurrentIndex:self.currentImageIndex];
}

#pragma mark 添加图片三个控件
- (void)addImageViews {
    _leftImageView             = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_leftImageView];
    _centerImageView             = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_centerImageView];
    _rightImageView             = [[UIImageView alloc] initWithFrame:CGRectMake(2 * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_rightImageView];
}

#pragma mark 设置默认显示图片
- (void)setDefaultImage {
    //加载默认图片
    // set default center
    _centerImageView.image = [UIImage imageNamed:_imglist[0]];

    if (_imageCount > 1) {
        _leftImageView.image  = [UIImage imageNamed:_imglist[_imageCount - 1]];
        _rightImageView.image = [UIImage imageNamed:_imglist[1]];
    }

    _currentImageIndex = 0;

    //设置当前页
    _pageControl.currentPage = _currentImageIndex;
    NSString *imageName      = _imglist[_currentImageIndex];
    _label.text              = imageName;
}


#pragma mark 添加分页控件
- (void)addPageControl {
    _pageControl = [[UIPageControl alloc] init];
    //注意此方法可以根据页数返回UIPageControl合适的大小
    CGSize size         = [_pageControl sizeForNumberOfPages:_imageCount];
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 10);
    //设置颜色
    _pageControl.pageIndicatorTintColor = self.color_pageControl;
    //设置当前页颜色
    _pageControl.currentPageIndicatorTintColor = self.color_currentPageControl;
    //设置总页数
    _pageControl.numberOfPages = _imageCount;

    [self addSubview:_pageControl];
}


#pragma mark 添加信息描述控件
- (void)addLabel {
    _label               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor     = [UIColor redColor];

    [self addSubview:_label];
}

#pragma mark 滚动停止事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //重新加载图片
    [self reloadImage];
    //移动到中间
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:NO];
    //设置分页
    _pageControl.currentPage = _currentImageIndex;

    NSString *imageName = _imglist[_currentImageIndex];
    _label.text         = imageName;
}

#pragma mark 重新加载图片
- (void)reloadImage {
    [self resumeTimerWithDelay];


    int leftImageIndex, rightImageIndex;
    CGPoint offset = [_scrollView contentOffset];

    if (offset.x > self.frame.size.width) { //向右滑动
        _currentImageIndex = (_currentImageIndex + 1) % _imageCount;
    }
    else if (offset.x < self.frame.size.width) { //向左滑动
        _currentImageIndex = (_currentImageIndex + _imageCount - 1) % _imageCount;
    }

    _centerImageView.image = [UIImage imageNamed:_imglist[_currentImageIndex]];

    //    NSLog(@"manual move at index : %d",_currentImageIndex) ;

    //重新设置左右图片
    leftImageIndex        = (_currentImageIndex + _imageCount - 1) % _imageCount;
    rightImageIndex       = (_currentImageIndex + 1) % _imageCount;
    _leftImageView.image  = [UIImage imageNamed:_imglist[leftImageIndex]];
    _rightImageView.image = [UIImage imageNamed:_imglist[rightImageIndex]];
}

- (void)resumeTimerWithDelay {
    [_timerLoop xt_pause];

    if (!bOpenTimer) {
        if ([_timerOverflow isValid]) {
            [_timerOverflow invalidate];
        }

        _timerOverflow = [NSTimer timerWithTimeInterval:_durationOfScroll
                                                 target:self
                                               selector:@selector(timerIsOverflow)
                                               userInfo:nil
                                                repeats:NO];

        [[NSRunLoop currentRunLoop] addTimer:_timerOverflow
                                     forMode:NSDefaultRunLoopMode];
    }
}

- (void)timerIsOverflow {
    bOpenTimer = YES;

    if (bOpenTimer) {
        [_timerLoop xt_resume];
        bOpenTimer = NO;

        [_timerOverflow invalidate];
        _timerOverflow = nil;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
