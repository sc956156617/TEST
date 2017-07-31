
//
//  AppDelegate+APPService.m
//  Magazine
//
//  Created by cb on 2017/6/13.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "AppDelegate+APPService.h"
#import "GSKeyChainDataManager.h"
#import "CatchCrash.h"
//#import <Bugly/CrashReporter.h>。腾讯bugly
//#import <SMS_SDK/SMSSDK.h>。短信平台。也可以自己搭建
#import "MWPhotoBrowser.h" //图片浏览器
//#import "NSAuthorityManager.h" //系统权限管理
//#import "NewEditionTestManager.h"//新版本检测上架之后
#import "Global.h"     //换肤功能
#import "MyThemes.h"
#import "SHENCHAO-Swift.h"



#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelWarning;
#endif
@interface AppDelegate ()<UIAlertViewDelegate,MWPhotoBrowserDelegate>

@property (nonatomic,strong)NSMutableArray *imageArr;  //图片浏览器来源
@property (nonatomic,assign)NSInteger imageIndex;


@end

@implementation AppDelegate (APPService)



//初始化存储UUID
-(instancetype)init{
    if (self=[super init]) {
        [self saveUUIDWithKeychain];
    }
    return self;
}

- (void)registerBugly
{
    
    [CatchCrash errorLogFile]; //自定义
    
    //1> 开启使用 XcodeColors
    setenv("XcodeColors", "YES", 0);
    //2 >检测是否开启 XcodeColors
    char *xcode_colors = getenv("XcodeColors");
    
    if ( xcode_colors && (strcmp(xcode_colors,"YES")) == 0)
    {
        // XcodeColors is installed and enabled!
        NSLog(@"XcodeColors is installed and enabled");
    }
        //3 >开启DDLog 颜色
        [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
        [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
    
    //配置DDLog
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
    //针对单个文件配置DDLog打印级别，尚未测试
    //    [DDLog setLevel:DDLogLevelAll forClass:nil];
    
//    NSLog(@"NSLog");
//    DDLogVerbose(@"Verbose");
//    DDLogDebug(@"Debug");
//    DDLogInfo(@"Info");
//    DDLogWarn(@"Warn");
//    DDLogError(@"Error");
//    
//    DDLogError(NSHomeDirectory());
}

-(void)setChangSkinTheme{

    [MyThemes restoreLastTheme];
    
    // status bar
    
    ThemeStatusBarStylePicker *statusPicker = [ThemeStatusBarStylePicker pickerWithStringStyles:globalStatusBarStringStyles];
    [[UIApplication sharedApplication] theme_setStatusBarStyle:statusPicker animated:YES];
    // navigation bar
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    
    NSMutableArray *titleAttributes = [NSMutableArray array];
    
    for (NSString *rgba in globalBarTextColors) {
        UIColor *color = [[UIColor alloc] initWithRgba_throws:rgba error:nil];
        NSDictionary *attr = @{
                               NSForegroundColorAttributeName: color,
                               NSFontAttributeName: [UIFont systemFontOfSize:16],
                               NSShadowAttributeName: shadow
                               };
        [titleAttributes addObject:attr];
    }
    
    navigationBar.theme_tintColor = globalBarTextColorPicker;
    navigationBar.theme_barTintColor = globalBarTintColorPicker;
    navigationBar.theme_titleTextAttributes = [ThemeDictionaryPicker pickerWithDicts:titleAttributes];
    
    // tab bar
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.theme_tintColor = globalBarTextColorPicker;
    tabBar.theme_barTintColor = globalBarTintColorPicker;
}

/**
 系统权限管理   需要什么权限在此处定义
 */
-(void)setUpAuthorityManager{
//    if ([NSAuthorityManager isObtainAVVideoAuthority]) {
//        NSLog(@"已经开启相机权限");
//    }else{
//        [[NSAuthorityManager sharedInstance]obtainAVMediaVideoAuthorizedStatus];
//    }
//
//    if ([NSAuthorityManager isObtainPhPhotoAuthority]) {
//        NSLog(@"已经开启相机权限");
//    }else{
//        [[NSAuthorityManager sharedInstance]obtainPHPhotoAuthorizedStaus];
//    }
//
//    if ([NSAuthorityManager isObtainMediaAuthority]) {
//        NSLog(@"已经开启相机权限");
//    }else{
//        [[NSAuthorityManager sharedInstance]obtainMPMediaAuthorizedStatus];
//    }
//    
//    if ([NSAuthorityManager isObtainCNContactAuthority]) {
//        NSLog(@"已经开启相机权限");
//    }else{
//        [[NSAuthorityManager sharedInstance]obtainCNContactAuthorizedStatus
//         ];
//    }
}
- (void)phontoBroserPush:(NSNotification *)note{

//    self.imageArr = [NSMutableArray arrayWithCapacity:0];
//    [self.imageArr removeAllObjects];
//    
////    NSDictionary *dic = note.object;
////    NSArray *arr = dic[@"imageInfo"];
////    NSInteger index = [dic[@"index"] integerValue];
//    [self.imageArr addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://img.blog.csdn.net/20160630072006169?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center"]]];
//    [self.imageArr addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://img.blog.csdn.net/20160630072006169?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center"]]];
//    
//    
//    MWPhoto *video = [MWPhoto photoWithURL:[NSURL URLWithString:@"http://img.blog.csdn.net/20160630072006169?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center"]];
//    video.videoURL = [[NSURL alloc] initWithString:@"https://scontent.cdninstagram.com/hphotos-xpa1/t50.2886-16/11200303_1440130956287424_1714699187_n.mp4"];
//    [self.imageArr addObject:video];
//    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc]initWithDelegate:self];
//    browser.zoomPhotosToFill = YES;
//    
//    browser.displayNavArrows = YES;
//    browser.displayActionButton = NO;
//    browser.alwaysShowControls = NO;
//    browser.autoPlayOnAppear = YES;
//    [browser setCurrentPhotoIndex:0];
//    [[AppDelegate rootNavigationController] pushViewController:browser animated:YES];


}

- (void)configurationLaunchUserOption
{
    
//    NSString *schoolId = [[[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SchoolConfig.plist" ofType:nil]] objectForKey:@"SchoolId"];
//    NSString *versonNum = [[[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SchoolConfig.plist" ofType:nil]] objectForKey:@"VersionNum"];//VersionNum
//    [SZUserDefault setObject:[JPUSHService registrationID] forKey:@"registrationId"];
//    [SZUserDefault setObject:schoolId forKey:@"schoolId"];
//    [SZUserDefault setObject:versonNum forKey:@"VersionNum"];
//    [SZUserDefault synchronize];
}

- (void)registerMob
{
//    [SMSSDK registerApp:SMSMobAppKeyTest
//             withSecret:SMSMobAppSecretTest];
}

////定位
//- (void)setLocation
//{
////    [UMSocialData setAppKey:UmengAppKey];
////    [UMSocialQQHandler setQQWithAppId:ShareQQAppID appKey:ShareQQAppKey url:@"http://xiaozhangkeji.szdtoo.com.cn"];
////    [UMSocialWechatHandler setWXAppId:WetChatAppId appSecret:WetChatAppSecret url:@"http://xiaozhangkeji.szdtoo.com.cn"];
////    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
//    
//    
//    
//    
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationMethod) name:kNotificationLocation object:nil];
//    _isUserLocationEnabled = YES;
//        //由于IOS8中定位的授权机制改变 需要进行手动授权
//    _locationManager = [[CLLocationManager alloc] init];
//        //获取授权认证
//    [_locationManager requestWhenInUseAuthorization];
//    
//    // 要使用百度地图，请先启动BaiduMapManager
//    _mapManager = [[BMKMapManager alloc]init];
//    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
//    BOOL ret = [_mapManager start:@"TTTXPyECXVTCGwjab23G1yzuWwozhtwY"  generalDelegate:self];
//    if (!ret) {
//        _isUserLocationEnabled = NO;
//        //        DDLogDebug(@"manager start failed!");
//    }
//    //初始化BMKLocationService
//    _locService = [[BMKLocationService alloc]init];
//    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//    _locService.distanceFilter = 100.f;
//    _locService.delegate = self;
//}
//
//#pragma mark BMPLdeldegate
//
///**当获取到定位的坐标后，回调函数*/
//
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
//    
//    
//    
//    BMKCoordinateRegion region;
//    
//    
//    
//    region.center.latitude  = userLocation.location.coordinate.latitude;
//    
//    region.center.longitude = userLocation.location.coordinate.longitude;
//    
//    region.span.latitudeDelta = 0;
//    
//    region.span.longitudeDelta = 0;
//    
//    NSLog(@"当前的坐标是:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    
//    
//    
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    
//    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
//        
//        if (array.count > 0) {
//            
//            CLPlacemark *placemark = [array objectAtIndex:0];
//            
//            if (placemark != nil) {
//                
//                NSString *city = placemark.locality;
//                NSLog(@"当前城市名称------%@",city);
////                BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
////                
////                _offlineMap.delegate = self;//可以不要
////                
////                NSArray* records = [_offlineMap searchCity:city];
////                
////                BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
////                
////                //城市编码如:北京为131
////                
////                NSInteger cityId = oneRecord.cityID;
////                
////                
////                NSLog(@"当前城市编号-------->%zd",cityId);
//                
//                //找到了当前位置城市后就关闭服务
//                [_locService stopUserLocationService];
//                
//                
//                
//            }
//            
//        }
//        
//    }];
//    
//    
//    
//}






-(void)checkBlack
{
    
}


- (void)upLoadMessageAboutUser
{
    
}

- (void)checkAppUpDataWithshowOption:(BOOL)showOption
{
    //第二步  appID:应用在Store里面的ID (应用的AppStore地址里面可获取)
//    [NewEditionTestManager checkNewEditionWithAppID:@"xxxx" ctrl:self]; //1种用法，系统Alert
    
    
//    [NewEditionTestManager checkNewEditionWithAppID:@"xxxx" CustomAlert:^(AppStoreInfoModel *appInfo) {
//        
//    }];//2种用法,自定义Alert
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
//    if (alertView.tag == 400)
//    {
//        [HHUserInfo clearUserInfo];
//        [[self.viewController rdv_tabBarController]setTabBarHidden:YES animated:YES];
//        //VersionTwoLoginViewController *log=[[VersionTwoLoginViewController alloc]init];
//        //  UINavigationController *login=[[UINavigationController alloc]initWithRootViewController:log];
//        //        [self.viewController presentViewController:login animated:YES completion:nil];
//    }
//    if (alertView.tag == 401)
//    {
//        //跳绑定列表
//        [HHUserInfo refreshUserMessageWithKey:@"stuId" value:@""];
//        [[self.viewController rdv_tabBarController]setTabBarHidden:YES animated:YES];
//        //   VersionTwoLoginViewController *log=[[VersionTwoLoginViewController alloc]init];
//        // [self.viewController.navigationController pushViewController:log animated:YES];
//    }
    
}

//走get方法获取UUID
-(NSString *)UUID{
    return [GSKeyChainDataManager readUUID];
}
#pragma mark 钥匙链UUID

-(void)saveUUIDWithKeychain{
    NSString *deviceUUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    [GSKeyChainDataManager saveUUID:deviceUUID];
}

@end
