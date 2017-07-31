//
//  MainPageViewController.m
//  LeftSlide
//
//  Created by huangzhenyu on 15/6/18.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "MainPageViewController.h"
#import "AppDelegate.h"
#import "AppDelegate+RootController.h"
#define vBackBarButtonItemName  @"backArrow.png"    //导航条返回默认图片名


#import "SCBandsViewController.h"
#import "SCPartsViewController.h"
#import "SCBestGoodsViewController.h"



@interface MainPageViewController ()
@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@end

@implementation MainPageViewController

#pragma mark 参数进入
-(NSArray *)setChaildViewController{
    
    
    
    SCBandsViewController * bands =[[SCBandsViewController alloc]init];
    return @[bands,[SCPartsViewController new],[SCBestGoodsViewController new]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
    [self setupUI];
    
}

-(void)baseSetting{
    
    self.navigationController.navigationBar.translucent = NO;
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 30) titles:@[@"品牌",@"精品",@"配件"] headStyle:SegmentHeadStyleSlide layoutStyle:MLMSegmentLayoutCenter];
    _segHead.fontSize = 14;
    _segHead.bottomLineHeight = 0;
    _segHead.headColor = [UIColor cyanColor];
    _segHead.selectColor = [UIColor whiteColor];
    _segHead.deSelectColor = [UIColor orangeColor];
    _segHead.slideColor = [UIColor grayColor];
    _segHead.equalSize = YES;
    _segHead.layer.cornerRadius = BIgMunecornerRadius;
    _segHead.layer.masksToBounds = YES;
    
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) vcOrViews:[self setChaildViewController]];
    _segScroll.loadAll = NO;
    SCWeakSelf(self);
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        weakself.navigationItem.titleView = _segHead;
        [weakself.view addSubview:_segScroll];
    }];
}


-(void)setupUI{
//    self.navigationController.navigationBar.hidden = YES;
    self.title = @"主界面";
    self.view.bgColor(@"white");
    UIButton *menuBtn = Button.insets(0, 0).xy(20, 18).img(@"menu").onClick(@"openOrCloseLeftList");
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
}



#pragma mark 滑动相关
- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}

@end
