//
//  HHConfig.h
//  HomeHome
//
//  Created by Victor on 16/1/5.
//  Copyright © 2016年 Victor. All rights reserved.
//

#ifndef SCTheThirdParty_h
#define SCTheThirdParty_h

#define kPushPhotoBrowserNotifitationName @"PushPhotoBrowser"
#define kPresentVideoPlayerNotifitationName @"playCallBackVideo"

#define APPICONIMAGE [UIImage imageNamed:[[[[NSBundle mainBundle] infoDictionary] valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject]]
#define APPNAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define Main_Color [UIColor colorWithRed:(3)/255.0 green:(160)/255.0 blue:(235)/255.0 alpha:1.0]
#define Main2_Color [UIColor colorWithRed:(135)/255.0 green:(202)/255.0 blue:(231)/255.0 alpha:1.0]
#define VTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define Text_Color [UIColor colorWithRed:(51)/255.0 green:(71)/255.0 blue:(113)/255.0 alpha:1.0]
#define BackGround_Color [UIColor colorWithRed:(235)/255.0 green:(235)/255.0 blue:(241)/255.0 alpha:1.0]


#define Default_Person_Image [UIImage imageNamed:@"default_parents"]
#define Default_General_Image [UIImage imageNamed:@"default_general"]

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define SZNotificationCenter [NSNotificationCenter defaultCenter]

#define VTAlertCenter(string)  [[DMCAlertCenter defaultCenter]postAlertWithMessage:string]//提示框

#define NewsDefaultImage [UIImage imageNamed:@"defaultImage"]

//第三方服务的key
#define UmengAppKey @"550a9500fd98c55ab1000f57"//友盟分享appKey
#define ShareQQAppID @"1104418201"//腾讯appID
#define ShareQQAppKey @"ypxK0NC3YD3ZbagT"//腾讯appKey
#define WetChatAppId @"wx7b1afe37e90787fc"//微信appID
#define WetChatAppSecret @"2bd06ca54d0aca139be9f6e89c04355f"//微信appSecret
#define SMSMobAppKey @"683feb4e2540"//MobAppKey
#define SMSMobAppSecret @"8ad765a4dae8d2d2948ff72944b0d8a0"
#define SMSMobAppKeyTest @"114ed22f249fe"//MobAppKey--测试使用
#define SMSMobAppSecretTest @"59c4b7aa8864140c2512acfaeb81e063"
#define BuglyKey @"900021400"
// 百度地图的key
#define kBaiduMapKey      @"wU9IsEMcv48fTOEKRYAeREvOaQAudHwu"

#define SchoolID [[[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SchoolConfig.plist" ofType:nil]] objectForKey:@"SchoolId"]
#define JpushKey [[[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SchoolConfig.plist" ofType:nil]] objectForKey:@"JpushKey"]
#define IsProduction [[[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SchoolConfig.plist" ofType:nil]] objectForKey:@"IsProduction"]
#define CrashReportAppKey @"900021400"




#endif /* SCTheThirdParty_h */
