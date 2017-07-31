//
//  ColorTypeTools.m
//  Main
//
//  Created by yuhongtao on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SCColorTypeTools.h"
//#import "ManyLanguageDic.h"
#import "SCHeader.h"
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import "sys/utsname.h"//判断设备倒入的。
#import <CommonCrypto/CommonDigest.h> //MD5的使用

#import "NSArray+Log.h"
//截屏需要
#import <QuartzCore/QuartzCore.h>
//内存引入
#include <sys/param.h>
#include <sys/mount.h>
#include <mach/mach.h>


//1一定要先配置自己项目在商店的APPID,配置完最好在真机上运行才能看到完全效果哦!
#define STOREAPPID @"1104867082"
#define  SV_APP_EXTENSIONS  10
static NSString* const kIsAutoLocation = @"isAutoLocation";
static NSString* const kCurrentAddress = @"currentAddress";
static NSString* const kIsFirstLaunch = @"isFirstLaunch";
@implementation SCColorTypeTools


/**
 *  iOS在当前屏幕获取第一响应
 *
 *  @return  (本处无法使用，复制使用)
 */

+(UIView *)firstRespone{
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView * firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    return firstResponder;
}

+(UITextField *)PlaceholderColorwithUITextField:(UITextField *)textField{

  [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    
  return textField;
}
/**
 *  主动获取键盘高度
 *
 *  @return 方法取自svprogresshud
 */
+(CGFloat)visibleKeyboardHeight {
#if !defined(SV_APP_EXTENSIONS)
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]) {
        if(![[testWindow class] isEqual:[UIWindow class]]) {
            keyboardWindow = testWindow;
            break;
        }
    }
    
    for (__strong UIView *possibleKeyboard in [keyboardWindow subviews]) {
        if([possibleKeyboard isKindOfClass:NSClassFromString(@"UIPeripheralHostView")] || [possibleKeyboard isKindOfClass:NSClassFromString(@"UIKeyboard")]) {
            return CGRectGetHeight(possibleKeyboard.bounds);
        } else if([possibleKeyboard isKindOfClass:NSClassFromString(@"UIInputSetContainerView")]) {
            for (__strong UIView *possibleKeyboardSubview in [possibleKeyboard subviews]) {
                if([possibleKeyboardSubview isKindOfClass:NSClassFromString(@"UIInputSetHostView")]) {
                    return CGRectGetHeight(possibleKeyboardSubview.bounds);
                }
            }
        }
    }
#endif
    return 0;
}
/**
 *  //阿拉伯数字转中文格式
 *
 *  @param NSString
 *
 *  @return   3.7999
 typedef CF_ENUM(CFIndex, CFNumberFormatterRoundingMode) {
 kCFNumberFormatterRoundCeiling = 0,  //四舍五入,直接输出4
 kCFNumberFormatterRoundFloor = 1 ,    //保留小数输出3.8
 kCFNumberFormatterRoundDown = 2,   //加上了人民币标志,原值输出￥3.8
 kCFNumberFormatterRoundUp = 3,      //本身数值乘以100后用百分号表示,输出380%
 kCFNumberFormatterRoundHalfEven = 4,//输出3.799999999E0
 kCFNumberFormatterRoundHalfDown = 5,//原值的中文表示,输出三点七九九九。。。。
 kCFNumberFormatterRoundHalfUp = 6//原值中文表示,输出第四
 };
 */

+(NSString *)translation:(int)arebic
{
    int testNum = arebic;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt: testNum]];
    return 0;
}

//字符串反转
//第一种：
- (NSString *)reverseWordsInString:(NSString *)str
{
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:str.length];
    for (NSInteger i = str.length - 1; i >= 0 ; i --)
    {
        unichar ch = [str characterAtIndex:i];
        [newString appendFormat:@"%c", ch];
    }
    return newString;
}
//获取某个view所在的控制器
- (UIViewController *)viewControllerwith:(UIView *)vc
{
    UIViewController *viewController = nil;
    UIResponder *next = vc.nextResponder;
    while (next)
    {
        if ([next isKindOfClass:[UIViewController class]])
        {
            viewController = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    } 
    return viewController;
}
//iOS 获取汉字的拼音
+ (NSString *)transform:(NSString *)chinese
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
//    NSLog(@"%@", pinyin);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
//    NSLog(@"%@", pinyin);
    //返回最近结果
    return pinyin;
}

//手动更改iOS状态栏的颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color
{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor = color;
    }
}
/**
 *  兼容present和push的 back方法
 *
 *  @param viewController 就是target
 */
+(void)backWithTarget:(id)viewController{

    UIViewController * vc= (UIViewController *)viewController;
    NSArray *viewcontrollers=vc.navigationController.viewControllers;
    if (viewcontrollers.count > 1)
    {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self)
        {
            //push方式
            [vc.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        //present方式
        [vc dismissViewControllerAnimated:YES completion:nil];
    }

}
/**
 *  兼容present和push的 back方法
 *
 *  @param viewController 就是target
 */
+(void)backToRootWithTarget:(id)viewController{
    
    UIViewController * vc= (UIViewController *)viewController;
    NSArray *viewcontrollers=vc.navigationController.viewControllers;
    if (viewcontrollers.count > 1)
    {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self)
        {
            //push方式
            [vc.navigationController popToRootViewControllerAnimated:1];
        }
    }
    else
    {
        //present方式
        while (vc.presentingViewController) {
            vc = vc.presentingViewController;
        }
        [vc dismissViewControllerAnimated:YES completion:nil];

    }
    
}
/**
 *  圆角问题处理
 *
 *  @param NSInteger UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerTopRight;//这只圆角位置
 *    nil  代表全部圆角
 *  @return 原始图返回
 */
+(UIButton *)cornorRadio:(CGFloat)radioX andRectCorner:(UIRectCorner)corner andView:(UIButton *)view{
    CGRect rect = view.bounds;
    CGSize radio = CGSizeMake(radioX, radioX);//圆角尺寸
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner  cornerRadii:radio];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    masklayer.frame = view.bounds;
    masklayer.path = path.CGPath;//设置路径
    view.layer.mask = masklayer;
    return view;
}


/**
 * 下取整
 *
 *  @return //3.14 = 3

 */

+(NSInteger)floorWithfloat:(float)X{

    return  floor(X);
}
/**
 * 上取整
 *
 *  @return //3.99 = 4
 */

+(NSInteger)ceilWithfloat:(float)X{
    return  ceil(X);
}
/**
 *  navigationBar根据滑动距离的渐变色实现
 *  @param scrollView scrollview的delegate方法实现
 *  @param vc         不能使用
 */
+(void)scrollViewDidScroll:(UIScrollView *)scrollView with:(UIViewController *)vc
{
    CGFloat offsetToShow = 200.0;//滑动多少就完全显示
    CGFloat alpha = 1 - (offsetToShow - scrollView.contentOffset.y) / offsetToShow;
    [[vc.navigationController.navigationBar subviews] objectAtIndex:0].alpha = alpha;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView    with:(UIViewController *)vc
{
    CGFloat offsetToShow = 200.0;
    CGFloat alpha = 1 - (offsetToShow - scrollView.contentOffset.y) / offsetToShow;
    
    [vc.navigationController.navigationBar setShadowImage:[UIImage new]];
    [vc.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor orangeColor] colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];

}

//获取实际使用的LaunchImage图片
+(NSString *)getLaunchImageName{
    CGSize viewSize = [[UIScreen mainScreen] bounds].size; // 竖屏
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray * imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary * dict in imagesDict){
      
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}

/** 获取app的icon图标名称 */
- (void)getAppIconName{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //获取app中所有icon名字数组
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    //取最后一个icon的名字
    NSString *iconLastName = [iconsArr lastObject];
    //打印icon名字
//    NSLog(@"iconsArr: %@", iconsArr);
//    NSLog(@"iconLastName: %@", iconLastName);
    /*
     打印日志：
     iconsArr: (
     AppIcon29x29,
     AppIcon40x40,
     AppIcon60x60
     )
     iconLastName: AppIcon60x60
     */
}

//获取手机安装的应用
+(void)printAllAppInOurIphone{
    Class c =NSClassFromString(@"LSApplicationWorkspace");
    id s = [(id)c performSelector:NSSelectorFromString(@"defaultWorkspace")];
   NSArray *array = [s performSelector:NSSelectorFromString(@"allInstalledApplications")];
   for (id item in array)
  {
//    SCLog(@"%@",[item performSelector:NSSelectorFromString(@"applicationIdentifier")]);
//    SCLog(@"%@",[item performSelector:NSSelectorFromString(@"bundleIdentifier")]);
//    SCLog(@"%@",[item performSelector:NSSelectorFromString(@"bundleVersion")]);
//    SCLog(@"%@",[item performSelector:NSSelectorFromString(@"shortVersionString")]);
   }
}

/**
 *  pandun判读是否为中文
 */
+(BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}
/**
 *  dismiss到根控制器
 *  presenting  和  presented 自行百度
 *  @param controller
 */
+(void)dismissToRootViewControllerWithVC:(id)controller
{
    UIViewController *vc = controller;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  天朝专用检测app更新
 */
+(void)hsUpdateApp
{
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    
    //3从网络获取appStore版本号
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
    if (response == nil) {
        NSLog(@"你没有连接网络哦");
        return;
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"hsUpdateAppError:%@",error);
        return;
    }
    //    NSLog(@"%@",appInfoDic);
    NSArray *array = appInfoDic[@"results"];
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    //打印版本号
    NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
    //设置版本号
    currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (currentVersion.length==2) {
        currentVersion  = [currentVersion stringByAppendingString:@"0"];
    }else if (currentVersion.length==1){
        currentVersion  = [currentVersion stringByAppendingString:@"00"];
    }
    appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (appStoreVersion.length==2) {
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
    }else if (appStoreVersion.length==1){
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
    }
    
    //4当前版本号小于商店版本号,就更新
    if([currentVersion floatValue] < [appStoreVersion floatValue])
    {
        UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",dic[@"version"]] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //此处加入应用在app store的地址，方便用户去更新，一种实现方式如下
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
            [[UIApplication sharedApplication] openURL:url];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alercConteoller addAction:actionYes];
        [alercConteoller addAction:actionNo];
        //        [self presentViewController:alercConteoller animated:YES completion:nil];
    }else{
        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
    }
    
}

+(void)setGlobalUIINDelegate{

    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].barTintColor = [UIColor blackColor];
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    
    //设置返回按钮
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, -1, 0);
    UIImage *image = [UIImage imageNamed:@"barbuttonicon_back"];
    UIImage *backArrowImage = [image imageWithAlignmentRectInsets:insets];
    
    [UINavigationBar appearance].backIndicatorImage = backArrowImage;
//    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [UIImage imageWithColor:[UIColor clearColor] size:backArrowImage.size];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-4, 0) forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTranslucent:NO];


}


//+(UIButton *)getBackButtonWithImageName:(NSString *)imgStr {
//
//    UIImage *image=[UIImage imageNamed:imgStr];
//    UIImage *img=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(-20, 0, 44, 44)];
//    [leftBtn setImage:img forState:UIControlStateNormal];//设置按钮正常状态图片
//    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//
//
//
//}
+(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)hightImageName  addTarget:(id )target action:(SEL)action tintColor:(UIColor *)color
{
    
    UIImage  *image;
    if (color == nil) {
        image=[UIImage imageNamed:imageName];
        
//        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        image = [self  resizeImage:[UIImage imageNamed:imageName] toWidth:64/6*2 height:52/6*2 ];
    }else{
        image=[[UIImage imageNamed:imageName] imageWithTintColor:color];
        image= [self  resizeImage:image toWidth:64/6*2 height:52/6*2 ];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
//    button.buttonType = UIButtonTypeCustom;
    

    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightImageName] forState:UIControlStateHighlighted];
//    button.titleLabel.font =[UIFont systemFontOfSize: 15.0f] ;
//    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    //  设置按钮的尺寸
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
+(UIBarButtonItem *)itemWithTitleName:(NSString *)TitleName highTitleName:(NSString *)hightTitleName  addTarget:(id )target action:(SEL)action tintColor:(UIColor *)color
{
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:TitleName forState:UIControlStateNormal];
    [button setTitle:hightTitleName forState:UIControlStateSelected];
//    button.selected=NO;
    [button setTitleColor:SCBlackColor forState:UIControlStateNormal];
    button.titleLabel.font =[UIFont systemFontOfSize: 15.0f] ;
    //  设置按钮的尺寸
    button.frame=CGRectMake(0, 0, 35, 44);
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}



+ (NSString *)formatSecondsToString:(NSString *)second//秒转换成分和时
{
    
    int seconds=[second  intValue];
    
    NSString *hhmmss = nil;
    if (seconds < 0) {
        //return @"00:00:00";
        return @"00:00";
    }
    
    int h = (int)round((seconds%86400)/3600);
    int m = (int)round((seconds%3600)/60);
    int s = (int)round(seconds%60);
    
    //hhmmss = [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
    hhmmss = [NSString stringWithFormat:@"%02d:%02d:%02d",h, m, s];
    
    return hhmmss;
}


//根据docmens的绝对路径取相对路径
+(NSString *)getDocmentsRelativePathWithAbsolutePath:(NSString *)pathStr{
    NSArray *RangeArr=[pathStr  componentsSeparatedByString:@"Documents"];
    NSString  *videoName=RangeArr[1];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
    NSString *path=[documentsDirectory  stringByAppendingString:videoName];
    
    return path;
}




//系统md5
+ (NSString *)md5:(NSString *)str withNumber:(int) number {
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[number];
    
    CC_MD5( cStr,  ( CC_LONG )strlen(cStr), result );
    
    NSMutableString *md5String = [ NSMutableString string ];
    
    
    for ( int i = 0 ; i< number/2 ; i++) {
        [md5String appendFormat : @"%02x" ,result[i]];
    }
    return md5String;
    
}

//本app加密
+(NSString *)MYcode:(NSString *)str{
    NSString  *restr=[[self  md5:str withNumber:32] lowercaseString];
    NSString  *One=[restr   substringWithRange:NSMakeRange(0,16)];
    NSString *Two= [restr   substringWithRange:NSMakeRange(12,19)];
    NSString  *reOne=[[self md5:One withNumber:32]lowercaseString] ;
    NSString *reTwo=[[self md5:Two withNumber:32]lowercaseString];
    NSString *result=[reOne  stringByAppendingString:reTwo];
    NSString *reSTrOne=[result stringByAppendingString:@"1caf349543c342e194caed0635442688"];
    NSString *resultTwo=[[self md5:reSTrOne withNumber:32]lowercaseString];
    return resultTwo;
}
+(NSString *)lookForFont{
    
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
    
    return 0;
    //Example:
    //
    //    2012-04-02 11:36:34.395 MyApp[3579:707] Family name: Thonburi
    //    2012-04-02 11:36:34.398 MyApp[3579:707]     Font name: Thonburi-Bold
    //    2012-04-02 11:36:34.402 MyApp[3579:707]     Font name: Thonburi
    //    2012-04-02 11:36:34.405 MyApp[3579:707] Family name: Snell Roundhand
    //    2012-04-02 11:36:34.408 MyApp[3579:707]     Font name: SnellRoundhand-Bold
    //    2012-04-02 11:36:34.411 MyApp[3579:707]     Font name: SnellRoundhand-Black
    //    2012-04-02 11:36:34.415 MyApp[3579:707]     Font name: SnellRoundhand
    //    2012-04-02 11:36:34.418 MyApp[3579:707] Family name: Academy Engraved LET
    //    2012-04-02 11:36:34.421 MyApp[3579:707]     Font name: AcademyEngravedLetPlain
    //    2012-04-02 11:36:34.424 MyApp[3579:707] Family name: Marker Felt
    //    2012-04-02 11:36:34.427 MyApp[3579:707]     Font name: MarkerFelt-Wide
    //    2012-04-02 11:36:34.430 MyApp[3579:707]     Font name: MarkerFelt-Thin
    //    2012-04-02 11:36:34.434 MyApp[3579:707] Family name: Geeza Pro
    //    2012-04-02 11:36:34.437 MyApp[3579:707]     Font name: GeezaPro-Bold
    //    2012-04-02 11:36:34.441 MyApp[3579:707]     Font name: GeezaPro
    //    2012-04-02 11:36:34.445 MyApp[3579:707] Family name: Arial Rounded MT Bold
    //    2012-04-02 11:36:34.448 MyApp[3579:707]     Font name: ArialRoundedMTBold
    //    2012-04-02 11:36:34.451 MyApp[3579:707] Family name: Trebuchet MS
    //    2012-04-02 11:36:34.455 MyApp[3579:707]     Font name: TrebuchetMS
    //    2012-04-02 11:36:34.458 MyApp[3579:707]     Font name: TrebuchetMS-Bold
    //    2012-04-02 11:36:34.461 MyApp[3579:707]     Font name: TrebuchetMS-Italic
    //    2012-04-02 11:36:34.464 MyApp[3579:707]     Font name: Trebuchet-BoldItalic
    //    2012-04-02 11:36:34.467 MyApp[3579:707] Family name: Arial
    //    2012-04-02 11:36:34.471 MyApp[3579:707]     Font name: Arial-BoldMT
    //    2012-04-02 11:36:34.474 MyApp[3579:707]     Font name: ArialMT
    //    2012-04-02 11:36:34.477 MyApp[3579:707]     Font name: Arial-ItalicMT
    //    2012-04-02 11:36:34.480 MyApp[3579:707]     Font name: Arial-BoldItalicMT
    //    2012-04-02 11:36:34.483 MyApp[3579:707] Family name: Marion
    //    2012-04-02 11:36:34.487 MyApp[3579:707]     Font name: Marion-Regular
    //    2012-04-02 11:36:34.491 MyApp[3579:707]     Font name: Marion-Bold
    //    2012-04-02 11:36:34.494 MyApp[3579:707]     Font name: Marion-Italic
    //    2012-04-02 11:36:34.503 MyApp[3579:707] Family name: Gurmukhi MN
    //    2012-04-02 11:36:34.507 MyApp[3579:707]     Font name: GurmukhiMN
    //    2012-04-02 11:36:34.511 MyApp[3579:707]     Font name: GurmukhiMN-Bold
    //    2012-04-02 11:36:34.514 MyApp[3579:707] Family name: Malayalam Sangam MN
    //    2012-04-02 11:36:34.518 MyApp[3579:707]     Font name: MalayalamSangamMN-Bold
    //    2012-04-02 11:36:34.522 MyApp[3579:707]     Font name: MalayalamSangamMN
    //    2012-04-02 11:36:34.525 MyApp[3579:707] Family name: Bradley Hand
}


/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本(1)
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}
/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本(2)
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}
+(NSString *) aes256_encrypt:(NSString *)key withString:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    //对数据进行加密
    NSData *result = [self  DESEncrypt:data WithKey:key];
    
    //转换为2进制字符串
    if (result && result.length > 0) {
        
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

+(NSString *) aes256_decrypt:(NSString *)key withString:(NSString *)str
{
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:str.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [str length] / 2; i++) {
        byte_chars[0] = [str characterAtIndex:i*2];
        byte_chars[1] = [str characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    //对数据进行解密
    NSData* result = [self  DESDecrypt:data WithKey:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}



/*取到第几个UITabBarItem的SwappableImageView*/
//就是上图部分
+(UIView *)swappableImageViewInTabBar:(UITabBar *)tabBar withIndex:(NSUInteger)index
{
    
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    UITabBarController *mainTabController = (UITabBarController*)delegate.mainController;
    if (tabBar==nil) {
//        tabBar=mainTabController.tabBar;
    }
    
    
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
+(UIView *)UITabBarButtonLabelViewInTabBar:(UITabBar *)tabBar withIndex:(NSUInteger)index
{
    
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    UITabBarController *mainTabController = (UITabBarController*)delegate.mainController;
    if (tabBar==nil) {
//        tabBar=mainTabController.tabBar;
    }
    NSUInteger currentTabIndex = 0;
    for (UIView *subView in tabBar.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (currentTabIndex == index) {
                for (UIView *child in subView.subviews) {
                    if ([child isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
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


+(void)setupTabbarTitle{
    //  3 热点   0 课程  1 互动    2 我的
    //深度剖析tabbar  改变tabbar的titel
//    for (int i=0; i<4; i++) {
//        UILabel   *temp= (UILabel *)[SCColorTypeTools  UITabBarButtonLabelViewInTabBar:nil withIndex:i];
//        temp.text=[ManyLanguageMag  getTabbarString][i];
////        NSLog(@"%@",temp.text);
//        temp.width = kScreenW/4;
//        temp.textAlignment=NSTextAlignmentCenter;
////        NSLog(@"%@====%@",temp.text,temp.text);
//    }
    //    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    UITabBarController *mainTabController = (UITabBarController*)delegate.mainController;
    //    for (int i=0;i<4;i++) {
    //        UITabBarItem *item = mainTabController.tabBar.items[i];
    //        SCLog(@"%@===",item.title);
    //        item.title = [ManyLanguageMag  getTabbarString][i];
    //
    //    }
}
#pragma mark view相关
//2.UIView旋转：
+(void)rotateView:(UIView *)view toAngle:(float)angle
{
    [UIView beginAnimations:nil context:nil];
    [view setTransform:CGAffineTransformMakeRotation(angle)];
    [UIView commitAnimations];
}
// 三点坐标中间点对应的角度，以及判断是否顺时针

+(BOOL) chkClockWise:(CGPoint)a B:(CGPoint)b C:(CGPoint)c {
    double ax = a.x - b.x;
    double ay = - a.y + b.y;
    
    double cx = c.x - b.x;
    double cy = - c.y + b.y;
    
//    NSLog(@"result:%d",(cy*ax)<=(ay*cx));
//    NSLog(@"(x1,y1)=(%1f,%1f)",ax, ay);
//    NSLog(@"(x2,y2)=(%1f,%1f)\r\n\r\n",cx, cy);
    
    return ((cy*ax)<=(ay*cx));
}
// 点坐标旋转后弧度后获取新的坐标
+(CGPoint)getNewPoint:(CGPoint)old rotate:(double)rotate  witncenter:(CGPoint)center{

    //实际坐标换算到原点坐标
    old.x =  (old.x-center.x);
    old.y = (center.y-old.y);
    
    //计算选转后新坐标
    double x = old.x*cos(rotate)-old.y*sin(rotate);
    double y = old.y*cos(rotate)+old.x*sin(rotate);
    
    //原点坐标换算到实际坐标
    x = center.x + x;
    y = center.y - y;
    
    return CGPointMake(x, y);
}

/**
 *  截屏模糊问题
 这个方法截屏会模糊
 UIGraphicsBeginImageContext(CGSize size);
 第二种方法，argument：size大小 opaque透明度 scale缩放比例
 UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale);
 参考如下：
 *
 *  @param Screen 导入头文件#import <QuartzCore/QuartzCore.h>
 *  @param frame  将整个self.view大小的图层内容创建一张图片image
 *
 *  @return
 */
+(UIImage *)GetScreenShotWithScreen:(UIView *)ScreenX andFrame:(CGRect)frame
{
    UIGraphicsBeginImageContext(ScreenX.frame.size);
    [ScreenX.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * shotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef shotRef = shotImage.CGImage;
    CGImageRef ResultRef = CGImageCreateWithImageInRect(shotRef, frame);
    UIImage * Result = [UIImage imageWithCGImage:ResultRef];
    CGImageRelease(ResultRef);
    return Result;
}

//获得某个范围内的屏幕图像
+(UIImage *)imageFromView: (UIView *) theView   atFrame:(CGRect)r
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}

+(BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}
#pragma mark 图片相关
/**
 *  画圆点图片：
 *  @param UIImage
 */

+(UIImage*)createcircleImagewithrect:(CGRect)rect
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
//    CGRect rect = CGRectMake(size.width/2,size.height/2, 5, 5);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    unsigned int red, green, blue;
    // Fill color.
    CGContextSetRGBFillColor(context, 0, 0.7, 0.7, 1.0);
    // Your drawing code.
    CGContextFillEllipseInRect(context, rect);
    // Get the image and return.
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;  
}
/**
 *  网络地址转图
 *
 *  @param urlstring
 *
 *  @return
 */
+ (UIImage *) imageFromURLString: (NSString *) urlstring
{
    // This call is synchronous and blocking
    return [UIImage imageWithData:[NSData
                                   dataWithContentsOfURL:[NSURL URLWithString:urlstring]]];
}
/**
 *  图片缩放
 */
+(UIImage*)resizeImage:(UIImage*)image toWidth:(NSInteger)width height:(NSInteger)height
{
    // Create a graphics context with the target size
    // On iOS 4 &and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize size = CGSizeMake(width, height);
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    else
        UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Flip the context because UIKit coordinate system is upside down to Quartz coordinate system
    CGContextTranslateCTM(context, 0.0, height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Draw the original image to the context
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, width, height), image.CGImage);
    
    // Retrieve the UIImage from the current context
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageOut;
}
/**
 *  获取图片某一点的颜色
 *
 *  @param pointinImage 图片
 *  @param image
 *
 *  @return 在那个点
 */
- (UIColor*) getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image {
    
    UIColor* color = nil;
    CGImageRef inImage = image.CGImage;
    
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    
    if (cgctx == NULL) {
        return nil; /* error */
    }
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    CGContextDrawImage(cgctx, rect, inImage);
    unsigned char* data = CGBitmapContextGetData (cgctx);
    if (data != NULL) {
        int offset = 4*((w*round(point.y))+round(point.x));
        int alpha =  data[offset];
        int red = data[offset+1];
        int green = data[offset+2];
        int blue = data[offset+3];
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:
                 (blue/255.0f) alpha:(alpha/255.0f)];
    }
    CGContextRelease(cgctx);
    if (data) {
        free(data);
    }
    return color;
}
- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     (10,10),      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    
    return context;
}

//生成一张纯色的图片
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
/**
 *  生成一张纯色图片
 *
 *  @param c
 *  @param frame
 *
 *  @return 图片
 */
+ (UIImage *)colorImage:(UIColor *)c frame:(CGRect)frame {
    static NSMutableDictionary *imageCache;
    if (!imageCache) { imageCache = [[NSMutableDictionary alloc] init];}
    
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    
    NSString *cache_key = [NSString stringWithFormat:@"%@_%d_%d",c, (int)w, (int)h];
    
    if (![imageCache objectForKey:cache_key]) {
        UIImage *img;
        CGRect rect=CGRectMake(0.0f, 0.0f, w, h);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [c CGColor]);
        CGContextFillRect(context, rect);
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        imageCache[cache_key] = img;
    }
    
    return imageCache[cache_key];
}

/*
 *水印 图片上写上文字
 *
 *图片上绘制文字 写一个->UIImage的ca->>egory
 */
+(UIImage *)imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize withIMg:(UIImage *)image{
    //画布大小
    CGSize size=CGSizeMake(image.size.width,image.size.height);
    //创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);//opaque:NO  scale:0.0
    
    [image drawAtPoint:CGPointMake(0.0,0.0)];
    
    //文字居中显示在画布上
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;//文字居中
    
    //计算文字所占的size,文字居中显示在画布上
    CGSize sizeText=[title boundingRectWithSize:image.size
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    CGFloat widthX = image.size.width;
    CGFloat heightX = image.size.height;
    
    CGRect rectX = CGRectMake((widthX-sizeText.width)/2, (heightX-sizeText.height)/2, sizeText.width, sizeText.height);
    //绘制文字
    [title drawInRect:rectX withAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[UIColor whiteColor],NSParagraphStyleAttributeName:paragraphStyle}];
    
    //返回绘制的新图形
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)getImage:(NSString *)videoPath atTime:(NSTimeInterval)time Error:(NSError **)error
{
    
    //#import <CoreMedia/CoreMedia.h>
    //#import <AVFoundation/AVFoundation.h>
    if (!videoPath) {
        return nil;
    }
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[[NSURL alloc] initFileURLWithPath:videoPath] options:nil];
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)
                                                    actualTime:NULL error:error];
//显示错误，所以注销
//    logdebug(@"thumbnailImageRef: %p %@", thumbnailImageRef, thumbnailImageRef);
    if (!thumbnailImageRef) {
        return nil;
    }
    
    UIImage *thumbnailImage = [[UIImage alloc] initWithCGImage:thumbnailImageRef];
    //显示错误，所以注销
//    logdebug(@"thumbnailImage: %p", thumbnailImage);
    
    CFRelease(thumbnailImageRef);
    
    return thumbnailImage;
}

+ (BOOL)saveVideoThumbnailWithVideoPath:(NSString *)vieoPath toFile:(NSString *)ThumbnailPath Error:(NSError **)error
{
    NSError *er;
    UIImage *image = [SCColorTypeTools getImage:vieoPath atTime:1 Error:&er];
    if (er) {
        //        logerror(@"get video thumbnail failed: %@", [er localizedDescription]);
        if (error) {
            *error = er;
        }
        return NO;
    }
    
    [UIImagePNGRepresentation(image) writeToFile:ThumbnailPath atomically:YES];
    
//    logdebug(@"image: %@", image);
    
    return YES;
    
}

+ (void)SaveImageToDocument:(UIImage*)image path:(NSString*)path {
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *path_sandox = [paths objectAtIndex:0];
    //获取沙盒路径，
    //    NSString *path_sandox = NSHomeDirectory();
    //创建一个存储plist文件的路径
    NSString *newPath = [path stringByAppendingPathComponent:@"/Documents/pic.plist"];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    //把图片转换为Base64的字符串
    NSData *data = UIImagePNGRepresentation(image);
    
    NSString *image64 = [data base64Encoding];
    [arr addObject:image64];
    //写入plist文件
    if ([arr writeToFile:newPath atomically:YES]) {
        NSLog(@"写入成功");
    };
    
}

//+(UIImage *)getImageWithpath:(NSString *)path{
//    NSArray *data = [NSArray arrayWithContentsOfFile:path];
//    NSString *string= data[0];
//    NSData  * image=[NSData dataWithBase64EncodedString:string];
//    UIImage * decodedImage  = [UIImage imageWithData:image];
//    return decodedImage;
//}

/**
 *  图片本地保存设置
 *
 *  @return  本地user存储   第三种方法
 */
//将图片保存到本地
+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key {

    [SCUserDefaults setObject:UIImagePNGRepresentation(image) forKey:key];
}

//本地是否有相关图片
+ (BOOL)LocalHaveImage:(NSString*)key {
    NSData* imageData = [SCUserDefaults objectForKey:key];
    if (imageData) {
        return YES;
    }
    return NO;
}

//从本地获取图片
+ (UIImage*)GetImageFromLocal:(NSString*)key {
    NSData* imageData = [SCUserDefaults objectForKey:key];
    UIImage* image;
    if (imageData) {
        image = [UIImage imageWithData:imageData];
    }
    else {
        NSLog(@"未从本地获得图片");
    }
    return image;
}
/**
 *  把图片保存到相册
 *
 *  @param image
 */
+(void)saveImageToAlbum:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}
+(void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"呵呵";
    if (!error) {
        message = @"成功保存到相册";
    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
}


#pragma mark 杂乱无章

//iOS获取当前设备具体类型代码片段：
+(NSString *) platformString{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    
    
    if ([platform isEqualToString:@"iPad4,4"]||[platform isEqualToString:@"iPad4,5"]||[platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"]||[platform isEqualToString:@"iPad4,8"]||[platform isEqualToString:@"iPad4,9"])  return @"iPad mini 3";
    return platform;
}

+ (BOOL)isFirstLaunch
{
    return ![SCUserDefaults boolForKey:kIsFirstLaunch];
}
+ (void)disableFirstLaunch
{
    [SCUserDefaults setBool:YES forKey:kIsFirstLaunch];
}
+ (void)enableFirstLaunch
{
    [SCUserDefaults setBool:NO forKey:kIsFirstLaunch];
}
+(NSString *)getTypeStringWith:(NSString *)type{
    
    if ([type isEqualToString:@"1"]) {
        type=@"朋友圈";
    }else if ([type isEqualToString:@"2"]){
        type=@"朋友圈回复通知";
        
    }else if ([type isEqualToString:@"3"]){
        type=@"考试";
        
    }else if ([type isEqualToString:@"4"]){
        type=@"资讯";
        
    }else if ([type isEqualToString:@"5"]){
        type=@"专题";
        
    }else if ([type isEqualToString:@"6"]){
        type=@"沙龙";
        
    }else if ([type isEqualToString:@"7"]){
        type=@"问卷";
        
    }else if ([type isEqualToString:@"8"]){
        type=@"直播";
        
    }else if ([type isEqualToString:@"9"]){
        type=@"讲师";
    }else if ([type isEqualToString:@"10"]){
        type=@"问答";
    }else if ([type isEqualToString:@"40400"]){
        type=@"课程";
    }
    return type;
}
+(NSString *)getSexStringWith:(NSString *)type{
    
    if ([type isEqualToString:@"1"]) {
        type=@"男";
    }else if ([type isEqualToString:@"2"]){
        type=@"女";
        
    }else{
        type=@"保密";
    }
    return type;
}


//传三级 取得 二级的数据
+(NSString *)getAreaStringWith:(NSString *)type{

    NSArray * arr = [self JsonObjectwith:@"xian.json"];

    NSString * returnStr;
    
    for (int i=0; i<arr.count; i++) {
        NSDictionary * dic = arr[i];
        
//        NSLog(@"%@",dic[@"name"]);

        if ([dic[@"id"] isEqual:@(type.intValue)]) {
            
            returnStr = [NSString stringWithFormat:@"%@",dic[@"parent_id"]];
            
            
        }
    }
    return  [self getThereAreaStringWith:returnStr];
}

+(NSString *)getThereAreaStringWith:(NSString *)type{
    
    NSArray * arr = [self JsonObjectwith:@"shi.json"];
    
    NSString * returnStr;
    
    for (int i=0; i<arr.count; i++) {
        NSDictionary * dic = arr[i];
        
//        NSLog(@"%@",dic[@"name"]);
        
        if ([dic[@"id"] isEqual:@(type.intValue)]) {
            returnStr = dic[@"name"];
        }
    }
    return  returnStr;
}

+(id)JsonObjectwith:(NSString *)jsonStr {
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonStr ofType:nil];
    NSData *jsonData   = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSError *error;
    id JsonObject      = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
    return JsonObject;
}
+(NSString *)getChineseStrWithOtherLanguageStr:(NSString *)str{
    
    if ([str isEqualToString:@"简体中文"]) {
        return @"汉语";
    }else if ([str isEqualToString:@"English"]){
        
        return @"英语";
    }else if ([str isEqualToString:@"한국어"]){
        
        return @"韩语";
    }else if ([str isEqualToString:@"日本語"]){
        
        return @"日语";
    }else if ([str isEqualToString:@"De Nederlandse"]){
        
        return @"荷兰语";
    }else {
        
        return @"汉语";
    }
    
}


+(NSString *)getStudyStatusWith:(NSString *)type{
    //-1  项目过期课程
    // 1有/无考试未学完显示‘学习中’绿色按钮
    // 2 有考试已学完显示‘考试’红色按钮
    // 3 有考试未通过考试‘补考’红色按钮
    // 4 有考试通过考试‘已通过’绿字
    // 5 有考试补考未通过‘未通过’红字
    // 6 无考试已学完‘已学完’绿字
    if ([type isEqualToString:@"1"]) {
        type=@"学习中";
    }else if ([type isEqualToString:@"2"]){
        type=@"考试";
        
    }else if ([type isEqualToString:@"3"]){
        type=@"补考";
        
    }else if ([type isEqualToString:@"4"]){
        type=@"已通过";
        
    }else if ([type isEqualToString:@"5"]){
        type=@"未通过";
        
    }else if ([type isEqualToString:@"6"]){
        type=@"已学完";
        
    }else{
        
        type=@"过期";
        
    }
    return type;
    
}
+(NSString *)getCourseTypeStringWith:(NSString *)type{
    //1课程，2 直播，3沙龙，4 专题，5 H5页面
    if ([type isEqualToString:@"1"]) {
        type=@"课程";
    }else if ([type isEqualToString:@"2"]){
        type=@"直播";
        
    }else if ([type isEqualToString:@"3"]){
        type=@"沙龙";
        
    }else if ([type isEqualToString:@"4"]){
        type=@"专题";
        
    }else if ([type isEqualToString:@"5"]){
        type=@"H5界面";
        
    }
    return type;
}


/**
 *  取消隐士动画
 取消UICollectionView的隐式动画
 UICollectionView在reloadItems的时候，默认会附加一个隐式的fade动画，有时候很讨厌，尤其是当你的cell是复合cell的情况下(比如cell使用到了UIStackView)。
 下面几种方法都可以帮你去除这些动画
 */


//方法一
-(void)donghua {
    
    UICollectionView *collectionView;
    [UIView performWithoutAnimation:^{
        [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
    }];
    
    //方法二
    [UIView animateWithDuration:0 animations:^{
        [collectionView performBatchUpdates:^{
            [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
        } completion:nil];
    }];
    
    ////方法三
    //[UIView setAnimationsEnabled:NO];
    //[self.trackPanel performBatchUpdates:^{
    //    [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
    //} completion:^(BOOL finished) {
    //    [UIView setAnimationsEnabled:YES];
    //}];
}

/**
 *  监测IOS设备是否设置了代理，需要CFNetwork.framework
 *(本处无法使用)
 
 */
//+(void)haveDELEGATE{  //手机设备代理
//    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
//    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef_Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef_Nonnull)(proxySettings)));
//    NSLog(@"\n%@",proxies);
//
//    NSDictionary *settings = proxies[0];
//    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyHostNameKey]);
//    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
//    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyTypeKey]);
//
//    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
//    {
//        NSLog(@"没代理");
//    }
//    else
//    {
//        NSLog(@"设置了代理");
//    }
//}
@end
