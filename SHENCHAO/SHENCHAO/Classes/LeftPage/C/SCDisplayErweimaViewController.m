//
//  SCDisplayErweimaViewController.m
//  zhitongti
//
//  Created by yuhongtao on 16/8/31.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "SCDisplayErweimaViewController.h"
#import "UIView+Extension.h"
#import "SCActionSheet.h"
#import "PhotoStore.h"
#import "MyScanView.h"

#define kSize [[UIScreen mainScreen]bounds].size
@interface SCDisplayErweimaViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, strong)UIView *viewX;
@end

@implementation SCDisplayErweimaViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.title=@"二维码详情";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"fengmian"] highImage:[UIImage imageNamed:@"fengmian"] target:self action:@selector(singleTapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"fanhui"] highImage:[UIImage imageNamed:@"fanhui"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
                MyScanView * view =[[MyScanView alloc]init];
                [self.view addSubview:view];
}

//背景点击
-(void)singleTapAction:(id)gt
{
    [SCActionSheet showWithTitle:@"开始二维码的相关操作吧！"  destructiveTitle:nil otherTitles:@[@"保存图片"] block:^(int index) {
        [self saveScan];
    }];
}
#pragma mark 保存图片／扫描二维码
-(void)saveScan{

    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://s12.mogujie.cn/b7/bao/131011/1jix9_kqywmrcdkfbg26dwgfjeg5sckzsew_400x540.jpg_200x999.jpg"]];
    
    UIImage *image = [UIImage imageWithData:data];
    
//    NSLog(@"w = %f,h = %f",image.size.width,image.size.height);
    
    [self loadImageFinished:image];
}

- (void)loadImageFinished:(UIImage *)image
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
      [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"success = %d, error = %@", success, error);
    }];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:1];
}
- (void)createWebView
{
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    _webView.scalesPageToFit = YES;
    _webView.scrollView.bounces = YES;
    _webView.dataDetectorTypes = !UIDataDetectorTypePhoneNumber;
    
    //    CGFloat Y=[self stutsBarAndNavigationBarHeight]+30;
    _webView.frame = CGRectMake(64, 22, kSize.width, kSize.height);
    _webView.scrollView.showsVerticalScrollIndicator=NO;
    _webView.scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:_webView];
    
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

-(void)passCourseid:(NSString *)courseid andType:(int)type{
//    MineStudyLiveDetailViewController *vc=[MineStudyLiveDetailViewController new];
//    vc.LiveId=courseid;
//    [self.navigationController pushViewController:vc animated:1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


