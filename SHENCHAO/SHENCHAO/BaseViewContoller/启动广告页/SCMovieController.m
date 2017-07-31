//
//  WSMovieController.m
//  StartMovie
//
//  Created by iMac on 16/8/29.
//  Copyright © 2016年 sinfotek. All rights reserved.
//

#import "SCMovieController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "UIImage+SCGIF.h"
#import "SCImagesPlayer.h"

#import "FLAnimatedImage.h"
#import <UIImageView+WebCache.h>


#import "AppDelegate.h"
#define SCScreenW  [UIScreen mainScreen].bounds.size.width
#define SCScreenH  [UIScreen mainScreen].bounds.size.height

#define H5URLDEFLET  @"https://www.baidu.com"


@interface SCMovieController ()<UIWebViewDelegate>

@property(nonatomic,strong)NSTimer *timer;//广告计时器

@property(nonatomic,strong)UILabel *timerLabel;//广告倒计时

@property(nonatomic,assign)NSInteger ADTime;

@property(nonatomic,strong)UITapGestureRecognizer *timerLabelTap;//点击手势

@property(nonatomic,strong)UIButton *enterMainButton;

@property (strong, nonatomic) MPMoviePlayerController *player;
@end

@implementation SCMovieController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initWith:(SCMovieStyle)style with:(NSURL*)URL{

    switch (style) {
        case SCMovieStyleDefault:{
        [self setUpImageViewWith:URL];
        }break;
        case SCMovieStyleMovie:{
        [self SetupVideoPlayerWith:URL];
        }break;
        case SCMovieStyleGIF:{
        [self SetUpGIFViewWith:URL];
        }break;
        case SCMovieStyleImage:{
        [self setUpImageViewWith:URL];
        }break;
        case SCMovieStyleH5:{
         [self SetUpH5ViewWith:URL];
        }break;
        default:{
            NSLog(@"SCMovieController （出入格式错误）");
        }
            break;
    }
    [self  timeCountDownLabel];
    [self setActionView];
}


-(void)initStyleMovie:(NSURL *)movieURL{
    [self initWith:SCMovieStyleMovie with:movieURL];
}
-(void)initStyleGIF:(NSURL *)GIFURL{
    [self initWith:SCMovieStyleGIF with:GIFURL];
}
-(void)initStyleImage:(NSURL *)ImageURL{
    [self initWith:SCMovieStyleImage with:ImageURL];
}
-(void)initStyleH5:(NSURL *)H5URL{
    [self initWith:SCMovieStyleH5 with:H5URL];
}

-(void)initWith:(SCMovieStyle)style{
    switch (style) {
        case SCMovieStyleDefault:{
            [self initWith:SCMovieStyleImage with:[[NSBundle mainBundle] URLForResource:@"leftbackiamge" withExtension:@"png"]];
        }break;
        case SCMovieStyleMovie:{
            NSString *myFilePath = [[NSBundle mainBundle]pathForResource:@"qidong"ofType:@"mp4"];
            NSURL *movieURL = [NSURL fileURLWithPath:myFilePath];
            [self initWith:SCMovieStyleMovie with:movieURL];
        }break;
        case SCMovieStyleGIF:{
            NSURL *url = [[NSBundle mainBundle] URLForResource:@"111" withExtension:@"gif"];
            [self initWith:SCMovieStyleGIF with:url];
        }break;
        case SCMovieStyleImage:{
            NSString  *filePath = [[NSBundle mainBundle] pathForResource:@"leftbackiamge" ofType:@"png"];
            NSURL * url = [NSURL URLWithString:filePath];
            [self initWith:SCMovieStyleImage with:url];
        }break;
        case SCMovieStyleH5:{
            NSURL * url = [NSURL URLWithString:H5URLDEFLET];
            [self initWith:SCMovieStyleH5 with:url];
        }break;
        default:{
            NSLog(@"SCMovieController （出入格式错误）");
        }
            break;
    }

}
-(void)timeCountDownLabel{
    self.timerLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCScreenW-120, 40, 100, 40)];
    self.timerLabel.backgroundColor = [UIColor colorWithRed:125/256.0 green:125/256.0  blue:125/256.0  alpha:0.5];
    self.timerLabel.textColor = [UIColor whiteColor];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    self.timerLabel.layer.masksToBounds = YES;
    self.timerLabel.layer.cornerRadius = 5;
    self.timerLabel.hidden = self.TimeLableIsHidden? self.TimeLableIsHidden : NO ;;
    self.timerLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *timerLabelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(skipAD)];
    [self.timerLabel addGestureRecognizer:timerLabelTap];
    
    self.timer =[NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(setAppMainViewController) userInfo:nil repeats:YES];
    [self.view addSubview:self.timerLabel];
    _ADTime = self.CountDownTime ? self.CountDownTime : 20;
}

//计时器调取方法
-(void)setAppMainViewController{
    self.timerLabel.text = [NSString stringWithFormat:@"跳过(%ld)",_ADTime];
    _ADTime--;
        if (_ADTime < 0) {
            [self skipAD];
        }
}
//停止计时器并且跳转到主控制器
-(void)skipAD{
    if (self.timer !=nil) {
       [self.timer invalidate];
        self.timer = nil;
    }
    
//    self.view.window.rootViewController = ;
    
}

- (void)SetupVideoPlayerWith:(NSURL *)URL
{
    self.player = [[MPMoviePlayerController alloc]initWithContentURL:URL];
    [self.view addSubview:self.player.view];
    self.player.shouldAutoplay = YES;
    [self.player setControlStyle:MPMovieControlStyleNone];
    self.player.repeatMode = MPMovieRepeatModeOne;
    [self.player.view setFrame:self.view.bounds];
    self.player.view.alpha = 1;
    [UIView animateWithDuration:3 animations:^{
        self.player.view.alpha = 1;
        [self.player prepareToPlay];
    }];
}

- (void)setActionView
{
    //进入按钮
    UIButton *enterMainButton = [[UIButton alloc] init];
    enterMainButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
    enterMainButton.layer.borderWidth = 1;
    enterMainButton.layer.cornerRadius = 24;
    enterMainButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [enterMainButton setTitle:@"进入应用" forState:UIControlStateNormal];
    enterMainButton.alpha = 1;
    enterMainButton.hidden = self.ActionIsHidden ? self.ActionIsHidden : NO;
    [self.view addSubview:enterMainButton];
    [enterMainButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
    self.enterMainButton =enterMainButton;
 
}

#pragma mark 进入应用
- (void)enterMainAction:(UIButton *)btn {
//    NSLog(@"进入应用");
//    SCLoginViewController * vc= [SCLoginViewController new];
//    ViewNavigationController *nav =[[ViewNavigationController alloc]initWithRootViewController:vc];
////    [self presentViewController:nav animated:1 completion:nil];
//    
    
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    app.window.rootViewController = nav;
    [app.window  makeKeyAndVisible];
}
/**
 利用SDWebImage加载GIF  仅支持wang
 */
- (void)SetUpGIFViewWith:(NSURL *)URL{
    
//    NSData *imageData = [NSData dataWithContentsOfURL:URL];
    FLAnimatedImageView  *loadingImageView = [[FLAnimatedImageView alloc]init];
    loadingImageView.contentMode = UIViewContentModeScaleAspectFill;
    loadingImageView.clipsToBounds = YES;
    [self.view addSubview:loadingImageView];

    loadingImageView.frame = [UIScreen mainScreen].bounds;
    loadingImageView.backgroundColor = [UIColor blueColor];
    [loadingImageView loadAnimatedImageWithURL:URL completion:^(FLAnimatedImage *animatedImage) {
        loadingImageView.animatedImage = animatedImage;
    }];


}

//单张图片使用
-(void)setUpImageViewWith:(NSURL *)URL{
    UIImageView * imageView =[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic-xiupeilian.cn-bj.ufileos.com/16.png"]];
}
-(void)SetUpH5ViewWith:(NSURL *)URL{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = webView;
    webView.scalesPageToFit = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [webView loadRequest:request];
}


/////////////////////????????????????????单个界面隐藏导航栏
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;
//    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBar.hidden = NO;
//    self.tabBarController.tabBar.hidden = NO;
}

@end
