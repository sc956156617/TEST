//
//  BaseViewController.m
//  TXChatDemo
//
//  Created by Cloud on 15/6/1.
//  Copyright (c) 2015年 IST. All rights reserved.
//

#import "BaseViewController.h"
//#import "AppDelegate.h"
#import "NoNetworkViewController.h"
#import "UILabel+ContentSize.h"
#import "TXCustomAlertWindow.h"
#import "AppDelegate.h"
#import "UIBarButtonItem+Item.h"

#define  swappableImageViewBadgeViewTag 800101

#define NetworkErrorHeight 44


@interface BaseViewController ()
{
    UILabel *_titleLb;
    UIView *_connectView;           //网络状态视图
    
    BOOL isNetworkError;
    
}

@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicatorView;

@end

@implementation BaseViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (id)init{
    self = [super init];
    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReachabilityStatus:) name:kReachabilityStatus object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onShowNetwokError) name:TX_NOTIFICATION_NOT_REACHABLE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onHideNetwokError) name:TX_NOTIFICATION_REACHABLE object:nil];
        
        _navigationBarViewType = NavigationBarTitleViewType;
        _shouldLimitTitleLabelWidth = NO;
        
        isNetworkError = NO;
    }
    return self;
    
}

//网络状态
- (void)onReachabilityStatus:(NSNotification *)notification{
    NSDictionary *dic = notification.object;
    BOOL isConnected = [dic[@"status"] boolValue];
    if (_titleLb && ![_titleLb.text isEqualToString:@"无法连接网络"]) {
        _titleLb.text = isConnected?_titleStr:@"网络未连接";
        if (_connectView) {
            [self.view bringSubviewToFront:_connectView];
            [self.view bringSubviewToFront:_customNavigationView];
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _connectView.minY = isConnected?_customNavigationView.maxY - 44:_customNavigationView.maxY;
            } completion:^(BOOL finished) {
            }];
        }
    }
}


-(void)onShowNetwokError
{
    if (! self.isShowNetworkError) {
        return;
    }
    
    if (isNetworkError) {
        return;
    }
    
    isNetworkError = YES;
    
    [self showNetwokError:YES];
}

-(void)onHideNetwokError
{
    if (! self.isShowNetworkError) {
        return;
    }
    
    if (!isNetworkError) {
        return;
    }
    
    isNetworkError = NO;
    
    [self showNetwokError:NO];
}

-(void)showNetwokError:(BOOL) flag
{
    if (_connectView) {
        
        _connectView.layer.opacity = 0;
        
        _connectView.minY = _customNavigationView.maxY;
        
        [self.view bringSubviewToFront:_connectView];
        
        //[self.view bringSubviewToFront:_customNavigationView];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //_connectView.minY = flag?_customNavigationView.maxY:_customNavigationView.maxY - NetworkErrorHeight;
            
            _connectView.layer.opacity = flag?1:0;//不透明度
            
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = kColorBackground;
}
- (UIActivityIndicatorView *)loadingIndicatorView
{
    if (!_loadingIndicatorView) {
        _loadingIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _loadingIndicatorView.center = _customNavigationView.center;
        [_customNavigationView addSubview:_loadingIndicatorView];
    }
    return _loadingIndicatorView;
}
- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    _titleLb.text = _titleStr;
    if (_navigationBarViewType == NavigationBarLoadingViewType) {
        //设置位置
        CGFloat width = [UILabel widthForLabelWithText:_titleStr maxHeight:kNavigationHeight font:kFontSuper_b];
        self.loadingIndicatorView.center = CGPointMake(_customNavigationView.width / 2 - width / 2 - 20, _customNavigationView.height - kNavigationHeight / 2);
    }
}
- (void)setNavigationBarViewType:(NavigationBarViewType)type
{
    if (_navigationBarViewType == type) {
        return;
    }
    _navigationBarViewType = type;
    if (_navigationBarViewType == NavigationBarTitleViewType) {
        [self.loadingIndicatorView stopAnimating];
        self.loadingIndicatorView.hidden = YES;
    }else if (_navigationBarViewType == NavigationBarLoadingViewType) {
        [self.loadingIndicatorView startAnimating];
        self.loadingIndicatorView.hidden = NO;
        //设置位置
        CGFloat width = [UILabel widthForLabelWithText:_titleStr maxHeight:kNavigationHeight font:kFontSuper_b];
        self.loadingIndicatorView.center = CGPointMake(_customNavigationView.width / 2 - width / 2 - 20, _customNavigationView.height - kNavigationHeight / 2);
    }
}

-(void)setCustomRightWithRoundedRect
{
    self.btnRight.layer.borderWidth = 1;
    self.btnRight.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.btnRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.btnRight.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.btnRight.frame = CGRectMake(kScreenW -70, kNavigationHeight - 15, 60, 25);
}

- (void)createCustomNavBar{
//    CGFloat navHeight = IOS7_OR_LATER?kNavigationHeight + kStatusBarHeight:kNavigationHeight;
//    self.customNavigationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, navHeight)];
//    _customNavigationView.userInteractionEnabled = YES;
//    _customNavigationView.contentMode = UIViewContentModeScaleAspectFill;
//    _customNavigationView.clipsToBounds = YES;
//    //_customNavigationView.image = [UIImage imageNamed:@"navBar"];
//    _customNavigationView.backgroundColor = kNavBarColor;
//    [self.view addSubview:_customNavigationView];
//    
////    UIImageView *topLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, navHeight -1, kScreenWidth, 1)];
////    topLineView.image = [UIImage imageNamed:@"01顶部横线"];
////    [_customNavigationView addSubview:topLineView];
//    
//    [self createConnectView];
//    [UIColor colorWithHexString:@"#FFFFFF"];
//    CGFloat segmentWidth = 85;
//    
//    // 左按钮
//    _btnLeft = [[CustomButton alloc] initWithFrame:CGRectMake(0, _customNavigationView.height - kNavigationHeight, segmentWidth, kNavigationHeight)];
//    _btnLeft.showBackArrow = YES;
//    _btnLeft.tag = TopBarButtonLeft;
//    _btnLeft.adjustsImageWhenHighlighted = NO;
//    _btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _btnLeft.titleLabel.font = kFontMiddle;
//    _btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, kEdgeInsetsLeft + 5, 0, 0);
//    _btnLeft.imageEdgeInsets = UIEdgeInsetsMake(0, kEdgeInsetsLeft -5, 0, 0);
//    //_btnLeft.exclusiveTouch = YES;
//    
////    [_btnLeft setBackgroundImage:[UIImage imageNamed:@"barButtonItem_back"] forState:UIControlStateNormal];
//    
//    //[_btnLeft setTitle:@"返回" forState:UIControlStateNormal];
//    [_btnLeft addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btnLeft setTitleColor:kColorWhite forState:UIControlStateNormal];
//    [_btnLeft setTitleColor:kColorLightGray forState:UIControlStateDisabled];
//    [_customNavigationView addSubview:_btnLeft];
//    // 右按钮
//    _btnRight = [[CustomButton alloc] initWithFrame:CGRectMake(_customNavigationView.width - segmentWidth, _customNavigationView.height - kNavigationHeight, segmentWidth, kNavigationHeight)];
//    _btnRight.showBackArrow = NO;
//    _btnRight.tag = TopBarButtonRight;
//    _btnRight.adjustsImageWhenHighlighted = NO;
//    _btnRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    _btnRight.titleLabel.font = kFontMiddle;
//    _btnRight.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kEdgeInsetsLeft);
//    _btnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kEdgeInsetsLeft);
//    _btnRight.exclusiveTouch = YES;
//    [_btnRight addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btnRight setTitleColor:kColorWhite forState:UIControlStateNormal];
//    [_btnRight setTitleColor:kColorLine forState:UIControlStateDisabled];
//    [_customNavigationView addSubview:_btnRight];
//    
//    _titleLb = [[UILabel alloc] initClearColorWithFrame:CGRectMake(0, 0, _customNavigationView.width - _btnLeft.width - _btnRight.width, kNavigationHeight)];
//    _titleLb.frame = CGRectMake(0, 0,_shouldLimitTitleLabelWidth ? _customNavigationView.width - _btnLeft.width / 2  : _customNavigationView.width, kNavigationHeight);
//    _titleLb.center = CGPointMake(_customNavigationView.center.x, _customNavigationView.height - kNavigationHeight / 2);
//    _titleLb.font = kFontSuper_b;
//    _titleLb.textColor = kColorWhite;
//    _titleLb.textAlignment = NSTextAlignmentCenter;
//    [_customNavigationView addSubview:_titleLb];
//    
//    _titleLb.text = _titleStr;
}

- (void)createConnectView{
    _connectView = [[UIView alloc] initWithFrame:CGRectMake(0,_customNavigationView.maxY - NetworkErrorHeight, _customNavigationView.width, NetworkErrorHeight)];
    _connectView.backgroundColor = [UIColor colorWithHexString:@"#FFFCD5"];
    [self.view insertSubview:_connectView belowSubview:_customNavigationView];
    
    UILabel *connectLb = [[UILabel alloc] initClearColorWithFrame:CGRectMake((_connectView.width - 100)/2, 0, 100, _connectView.height)];
    connectLb.font = kFontNormal;
    connectLb.textAlignment = NSTextAlignmentCenter;
    //connectLb.backgroundColor = [UIColor greenColor];
    
    connectLb.textColor = [UIColor colorWithHexString:@"#FF6600"];
    connectLb.text = @"网络连接异常";
    
    CGSize size = [connectLb.text sizeWithFont:connectLb.font ];
    
    connectLb.frame = CGRectMake((_connectView.width - size.width)/2, 0, size.width, _connectView.height);
    
    [_connectView addSubview:connectLb];
    
    UIImageView *imageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01网络异常"]];
    
    imageView.frame = CGRectMake((_connectView.width - size.width)/2 - 21 - 8 , (_connectView.height -21)/2, 21, 21);
    
     [_connectView addSubview:imageView];
    
//    UIButton *connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    connectBtn.frame = connectLb.frame;
//    
//    
//    [_connectView addSubview:connectBtn];

}

- (void)onClickBtn:(UIButton *)sender{
}


-(void)gotoLoginPage
{
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication].delegate;
//    [delegate alertViewLogin];
    
}

-(void)setTabBarBadgeImage:(NSUInteger)tabIndex isShow:(BOOL)isShow withNewNumber:(int)newNumber
{
    
    
    //拿到系统tabbar。
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UITabBarController *mainTabController;
//    = (UITabBarController*)delegate.mainController;
    
    if (mainTabController) {

        UIView *swappableImageView = [self swappableImageViewInTabBar:self.tabBarController.tabBar withIndex:tabIndex];
        UIButton *badgeView = [swappableImageView viewWithTag:swappableImageViewBadgeViewTag];
        if (badgeView) {
            [badgeView removeFromSuperview];
        }
        
        if (isShow) {
            swappableImageView = [self swappableImageViewInTabBar:mainTabController.tabBar withIndex:tabIndex];
            /*自定义View添加*/
//            badgeView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(swappableImageView.bounds) + 4,CGRectGetMinY(swappableImageView.bounds) , 7.5f, 7.5f)];// -5  - 7.5f/2
//            //badgeView.layer.cornerRadius = 7.5f/2.0f;
//            UIImageView *badgeImageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"00新消息"]];
//            badgeImageView.frame = CGRectMake(0, 0, 7.5f, 7.5f);
//            badgeImageView.layer.cornerRadius = 7.5f/2.0f;
//            [badgeView addSubview:badgeImageView];
            
            badgeView = [UIButton buttonWithType:UIButtonTypeCustom];
            badgeView.frame = CGRectMake(CGRectGetMaxX(swappableImageView.bounds)-3,CGRectGetMinY(swappableImageView.bounds)-4 , 16.0f, 16.0f);// -5  - 7.5f/2
//            [badgeView setBackgroundImage:[UIImage imageNamed:@"00新消息"] forState:UIControlStateNormal];
            badgeView.backgroundColor = [UIColor redColor];
            [badgeView setImageEdgeInsets:UIEdgeInsetsZero];
            badgeView.layer.cornerRadius = 16.0f/2.0f;
            [badgeView setTitleEdgeInsets:UIEdgeInsetsZero];
            
            [badgeView setTitle:[NSString stringWithFormat:@"%d",newNumber] forState:UIControlStateNormal];
            badgeView.titleLabel.font = [UIFont boldSystemFontOfSize:10];
           
            [badgeView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            badgeView.backgroundColor = [UIColor clearColor];
            badgeView.userInteractionEnabled = NO;
            badgeView.tag = swappableImageViewBadgeViewTag;
            [swappableImageView addSubview:badgeView];
        }
    }
}


/*取到第几个UITabBarItem的SwappableImageView*/
- (UIView *)swappableImageViewInTabBar:(UITabBar *)tabBar withIndex:(NSUInteger)index
{
    NSUInteger currentTabIndex = 0;
    for (UIView *subView in tabBar.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (currentTabIndex == index) {
                for (UIView *child in subView.subviews) {
                    if ([child isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                        return child;
                    }
                }
            } else {
                currentTabIndex++;
            }
        }
    }
    return nil;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertViewWithMessage:(NSString *)message andButtonItems:(ButtonItem *)buttonItem, ...{
    va_list args;
    va_start(args, buttonItem);
    
    NSMutableArray *buttonsArray = [NSMutableArray array];
    if(buttonItem)
    {
        [buttonsArray addObject:buttonItem];
        ButtonItem *nextItem;
        while((nextItem = va_arg(args, ButtonItem *)))
        {
            [buttonsArray addObject:nextItem];
        }
    }
    va_end(args);
}
//屏蔽特定error的弹窗
- (void)showAlertViewWithError:(NSError *)error andButtonItems:(ButtonItem *)buttonItem, ...{
    va_list args;
    va_start(args, buttonItem);
    
    NSMutableArray *buttonsArray = [NSMutableArray array];
    if(buttonItem)
    {
        [buttonsArray addObject:buttonItem];
        ButtonItem *nextItem;
        while((nextItem = va_arg(args, ButtonItem *)))
        {
            [buttonsArray addObject:nextItem];
        }
    }
    va_end(args);

}

//展示失败动画
- (void)showFailedHudWithError:(NSError *)error
{
    NSString *message ;
//    = error.userInfo[kErrorMessage];
    
    if ([message length]==0) {
        [self showFailedHudWithTitle:@"未知错误" showSuccessImage:NO];
    }else
    {
        [self showFailedHudWithTitle:message showSuccessImage:NO];
    }
    
}


- (void)showSuccessHudWithTitle:(NSString *)title
{
    [self showFailedHudWithTitle:title showSuccessImage:YES];
}

- (void)showFailedHudWithTitle:(NSString *)title
{
    [self showFailedHudWithTitle:title showSuccessImage:NO];
}

//展示失败动画
- (void)showFailedHudWithTitle:(NSString *)title
              showSuccessImage:(BOOL)showSuccessImage
{
    MBProgressHUD *failedHud = [[MBProgressHUD alloc] initWithView:self.view];
    //    failedHud.layer.cornerRadius = 5.f;
    //    failedHud.backgroundColor = RGBACOLOR(0, 0, 0, 0.7);
    //    [self.view addSubview:failedHud];
    [[TXCustomAlertWindow sharedWindow] showWithView:failedHud];
    
    //    finishHud.customView = customView;
    if (showSuccessImage) {
        failedHud.mode = MBProgressHUDModeCustomView;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_failed"]];
        failedHud.customView = imageView;
    }else{
        failedHud.mode = MBProgressHUDModeDeterminate;
    }
    
    //    finishHud.delegate = self;
    failedHud.labelText = title;
    
    [failedHud show:YES];
    //    [failedHud hide:YES afterDelay:1.5f];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [failedHud hide:YES];
        [[TXCustomAlertWindow sharedWindow] hide];
    });
}
-(void)setCustemLeftItem{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu"] highImage:[UIImage imageNamed:@"menu"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Toast弹窗

@end

@implementation CustomButton

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    if (self.showBackArrow) {
        [self setImage:[UIImage imageNamed:@"00返回"] forState:UIControlStateNormal];
    }else{
        [self setImage:nil forState:UIControlStateNormal];
    }
    [super setTitle:title forState:state];
}

@end



