
//
//  SCBandsViewController.m
//  SHENCHAO
//
//  Created by cb on 2017/6/21.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "SCBandsViewController.h"
#import "HJCarouselViewLayout.h"
#import "CentreView.h"  //中间视图
#import "SCVerticalIndexView.h"  //  abcd 选择视图
#import "InfoDetailViewController.h"
//#import "XLSphereView.h"
#import "BrandModel.h"


//下部弹出视图
#import "BottomPoppingView.h"
#import "SnailPopupController.h"
#import "BottomPoppingLabel.h"
#define k320CenterCellWidth 300.f
#define k320CenterCellHeight 180.f

//320屏宽和当前手机屏宽的比例
#define k320ScreenWidthScale      [UIScreen mainScreen].bounds.size.width / 320.f
//375屏宽和当前手机屏宽的比例
#define k375ScreenWidthScale      [UIScreen mainScreen].bounds.size.width / 375.f
//414屏宽和当前手机屏宽的比例
#define k414ScreenWidthScale      [UIScreen mainScreen].bounds.size.width / 414.f
@interface SCBandsViewController ()<CentreViewDelegate,SCVerticalIndexViewDelegate>
{

   UIImageView *_backgroundView;
    CentreView *_centreView;

}

//@property (nonatomic,strong) XLSphereView *sphereView;

@property (nonatomic, strong)   UIButton *showBandsBTemp;  //提示按钮
@property (nonatomic, strong)   UIButton *showBandsB;  //显示品牌按钮

@property (nonatomic, assign) CGFloat defaultOffsetX;
@property (nonatomic, assign) CGFloat defaultOffsetY;
@property (nonatomic, assign) CGFloat centerCellHeight;
@property (nonatomic, assign) CGFloat centerCellWidth;
@property(strong,nonatomic)NSArray * arr;
@end

@implementation SCBandsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareData];
    [self setUI];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:0 forKey:kAnimationType];
//    self.tableView.showsVerticalScrollIndicator   = NO;
//    self.tableView.showsHorizontalScrollIndicator = NO;
//    _arr=[NSMutableArray array];
//    
//    for (int i=0; i<100; i++) {
//        [_arr  addObject:[NSString stringWithFormat:@"%d",i]];
//    }
}
-(void)prepareData{

    BrandModel *modle = [BrandModel new];
    modle.thumbnail = @"https://gdp.alicdn.com/imgextra/i2/263817957/TB2SCybvR0lpuFjSszdXXcdxFXa-263817957.jpg";
    modle.detailurl = @"https://gdp.alicdn.com/imgextra/i1/263817957/TB2Q6dbvCBjpuFjSsplXXa5MVXa-263817957.jpg";
    modle.type = @"0";
    modle.detailtype =@"0";
    self.arr = @[modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,modle,];
}
-(void)setUI{
    [self  creatCollectionView];   //创建主视图
    //筛选大按钮
    self.showBandsB = Button.xywh(kScreenW-50, kScreenH/2-32, 50, 50).bgColor(@"189,79,70").borderRadius(25.0f).img(@"menu").onClick(@"pushMethod:").addTo(self.view);
    //选择品牌按钮
    self.showBandsBTemp =  Button.img(@"menu").str(@"选择品牌").highColor(@"brown").color(@"white").bgColor(@"23,11,100").gap(10).xywh(kScreenW-100,0,100, 30).fitSize.addTo(self.view); // horizontal span  .
}

-(void)pushMethod:(UIButton *)btn{
    
    NSArray *array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"X",@"Y",@"Z"];
    
    SCVerticalIndexView *sheet = [[SCVerticalIndexView alloc]initWithTitleArray:array];
    // 1. 代理方式
    sheet.delegate = self;
    // 2. Block 方式
    SCWeakSelf(self);
    sheet.ClickIndex = ^(NSInteger index){
        NSLog(@"Show Index %zi",index);
        [UIView animateWithDuration:0.3 animations:^{
            weakself.showBandsBTemp.x = self.showBandsBTemp.x+IndicatorSlideLength;
            weakself.showBandsB.frame = CGRectMake(kScreenW-50, kScreenH/2-32, 50, 50);
            weakself.showBandsB.layer.cornerRadius = 25.0f;
            weakself.showBandsB.alpha = 1.0f;
            
            
            BottomPoppingView *full = [self fullView];
            full.didClickFullView = ^(BottomPoppingView * _Nonnull fullView) {
                [weakself.sl_popupController dismiss];
            };
            
            full.didClickItems = ^(BottomPoppingView *fullView, NSInteger index) {
                weakself.sl_popupController.didDismiss = ^(SnailPopupController * _Nonnull popupController) {
                    //            [UIAlertController showAlert:fullView.items[index].textLabel.text];
                };
                
                [fullView endAnimationsCompletion:^(BottomPoppingView *fullView) {
                    [weakself.sl_popupController dismiss];
                }];
            };
            weakself.sl_popupController = [SnailPopupController new];
            weakself.sl_popupController.maskType = PopupMaskTypeClear;
            weakself.sl_popupController.allowPan = YES;
            [weakself.sl_popupController presentContentView:full];
        }];
    };
    [weakself.view addSubview:sheet];
    if (sheet.hidden == NO) {
        [UIView animateWithDuration:0.3 animations:^{
            weakself.showBandsBTemp.x = self.showBandsBTemp.x-IndicatorSlideLength;
            weakself.showBandsB.frame = CGRectMake(kScreenW-50, 0, 50, kScreenH-kNavigationheightAll);
            weakself.showBandsB.layer.cornerRadius = 0.0f;
            weakself.showBandsB.alpha = 0.1f;
        }];
   
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            weakself.showBandsBTemp.x = self.showBandsBTemp.x+IndicatorSlideLength;
            weakself.showBandsB.frame = CGRectMake(kScreenW-50, kScreenH/2-32, 50, 50);
            weakself.showBandsB.layer.cornerRadius = 25.0f;
        }];
    }
}
//- (void)buttonPressed:(UIButton *)btn
//{
//    
//    [_sphereView timerStop];
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        btn.transform = CGAffineTransformMakeScale(2., 2.);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.3 animations:^{
//            btn.transform = CGAffineTransformMakeScale(1., 1.);
//        } completion:^(BOOL finished) {
//            [_sphereView timerStart];
//        }];
//    }];
//    
//    [self.sphereView removeFromSuperview];
//
//}

- (void)actionSheet:(SCVerticalIndexView *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex{
    //    NSLog(@"Show Current Click Index %zi",buttonIndex);
    if (buttonIndex==1000) {
        [UIView animateWithDuration:0.3 animations:^{
            self.showBandsBTemp.x = self.showBandsBTemp.x+IndicatorSlideLength;
            self.showBandsB.frame = CGRectMake(kScreenW-50, kScreenH/2-32, 50, 50);
            self.showBandsB.layer.cornerRadius = 25.0f;
            self.showBandsB.alpha = 1.0f;
        }];

    }
}

- (void)creatCollectionView {
    
    //背景视图
    _backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kNavigationheightAll)];
    _backgroundView.image = [UIImage imageNamed:@"3"];
    _backgroundView.userInteractionEnabled = YES;
    [self.view addSubview:_backgroundView];
    
    
    //中间展示card视图
    HJCarouselViewLayout *layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimLinear];
    layout.itemSize = CGSizeMake(self.centerCellWidth, self.centerCellHeight);
    _centreView = [[CentreView alloc]initWithFrame:CGRectMake(0, 0, kScreenW,kScreenH - kNavigationheightAll) collectionViewLayout:layout];
    _centreView.data = self.arr;
    _centreView.centreViewDelegate = self;
    [_backgroundView addSubview:_centreView];
}
#pragma mark  CentreViewDelegate

//点击滑动
- (void)shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger scrollIndex = indexPath.item;
    NSInteger animationIndex = [[NSUserDefaults standardUserDefaults] integerForKey:kAnimationType];
    if (animationIndex == 4) {
        CGFloat x = self.defaultOffsetX + scrollIndex * self.centerCellWidth;
        [_centreView setContentOffset:CGPointMake(x, 0) animated:YES];
    } else {
        CGFloat y = self.defaultOffsetY + scrollIndex * self.centerCellHeight;
        [_centreView setContentOffset:CGPointMake(0, y) animated:YES];
    }
}

//主页面点击跳转
- (void)centreViewDidSelectpage{
  
    InfoDetailViewController *webVC = [[InfoDetailViewController alloc] init];
    webVC.urlString = @"http://www.baidu.com";
    webVC.isWKWebView = NO;
    webVC.webviewHeaderType = SCWebviewHeaderTypeNone;
    webVC.isNavHidden = NO;
    webVC.isHiddenProgressView = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

//监控滑动
-(void)centreViewDidScroll:(CGFloat)offsetY and:(CGFloat)contentSizeH{
    //    CGFloat y = self.defaultOffsetY + scrollIndex * self.centerCellHeight;
//    NSLog(@"%f==%f",offsetY, (offsetY+196.00001)/contentSizeH);/
    
    [self observeOffset:(offsetY+196.00001)/(contentSizeH)];
}
-(void)observeOffset:(CGFloat)contentY{
//    NSLog(@"%f",contentY);
    if ([NSThread isMainThread])
    {
        self.showBandsBTemp.y = (kScreenH-64-30)*contentY;
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.showBandsBTemp.y = (kScreenH-64-30)*contentY;
        });
    }
}
#pragma mark 懒加载
- (CGFloat)defaultOffsetY {
    
    if (!_defaultOffsetY) {
        
        _defaultOffsetY = -((kScreenH-kNavigationHeight-60.f)/2-self.centerCellHeight/2);
    }
    return _defaultOffsetY;
}

- (CGFloat)defaultOffsetX {
    
    if (!_defaultOffsetX) {
        
        _defaultOffsetX = -((kScreenW-0.f)/2-self.centerCellWidth/2);
    }
    return _defaultOffsetX;
}

- (CGFloat)centerCellWidth {
    
    if (!_centerCellWidth) {
        _centerCellWidth = k320ScreenWidthScale*k320CenterCellWidth;
    }
    return _centerCellWidth;
}

- (CGFloat)centerCellHeight {
    
    if (!_centerCellHeight) {
        _centerCellHeight = self.centerCellWidth*k320CenterCellHeight/k320CenterCellWidth;
    }
    return _centerCellHeight;
}
- (BottomPoppingView *)fullView {
    NSArray *array = @[ @"我的大神之路", @"宝马", @"马斯特丁",@"生活是一天的笑笑"];
    BottomPoppingView *fullView = [[BottomPoppingView alloc] initWithFrame:self.view.frame  withItemCount:array.count];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:array.count];
    for (NSString *string in array) {
        LableModel *item = [LableModel new];
        item.text = string;
        [models addObject:item];
    }
    fullView.models = models;
    return fullView;
}
@end
