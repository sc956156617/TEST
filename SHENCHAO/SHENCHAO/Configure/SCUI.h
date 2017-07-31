//
//  SCUI.h
//  SHENCHAO
//
//  Created by cb on 2017/6/14.
//  Copyright © 2017年 SC. All rights reserved.
//

#ifndef SCUI_h
#define SCUI_h
#import "UIColor+SCExtension.h"



#define SCREEN_WIDTHX ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHTX ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTHX, SCREEN_HEIGHTX))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTHX, SCREEN_HEIGHTX))
//.设置 view 圆角和边框
#define LRViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]



//主界面指示器滑动位移。主界面

#define IndicatorSlideLength  50.0f
//滑动菜单
#define  BIgMunecornerRadius  3.0f

#define  kLeftTableviewW  (SCREEN_WIDTHX * 0.8)

#define kNavBarColor [UIColor colorWithHexString:@"#333333"]  //导航颜色

#define kViewBackgroundColor [UIColor colorWithHexString:@"#F3F3F3"]//背景颜色

#define kMajorColor [UIColor colorWithHexString:@"#58B201"]//主色值

#define kCommonColor [UIColor colorWithHexString:@"#FF6600"]//辅色值

#define kMajorTextColor [UIColor colorWithHexString:@"#4A4A4A"]//文本颜色黑色

#define kCommonGrayTextColor [UIColor colorWithHexString:@"#9B9B9B"]//文本颜色灰色

#define kCommonTextBorderColor [UIColor colorWithHexString:@"#9B9B9B"]//文本框颜色

#define kCommonGreenTextColor [UIColor colorWithHexString:@"#3D7C00"]//绿色文本颜色

#define kCommonBackgroundColorColor [UIColor colorWithHexString:@"#4A4A4A"]//背景色值

#define KTokenTimeOutErrorCode 20002



#define kNavigationBarHeight     44
#define kNavigationheightAll 64
#define kContentHeight           (kApplicationHeight - kNavigationBarHeight)
#define kTableRowTitleSize       14
#define maxPopLength             170
#define kStatusBarHeight        20.f    //状态栏高度
#define kNavigationHeight       40.f    //导航栏高度
#define kLineHeight             1.f
#define kEdgeInsetsLeft         10
#define kTabBarHeight           50.f
#define kChatToolBarHeight       50

#define kImageMaxWidthPixelSize  1024

#define DEGREES_TO_RADIANS(degrees) (degrees * M_PI / 180)
#define RADIANS_TO_DERREES(radians) (radians * 180 / M_PI)

#define kMessageAvatarWidth         42
#define kMessageBubbleTextMargin    5
#define kMessageCellSpace           10
#define kMessageViewMargin          6
#define kMessageSendNameHeight      20
#define kMessageVoiceBubbleMinWidth    80
#define kMessageVoiceBubbleMaxWidth    160
#define kMessageBubbleMinWidth      60
#define kMessageBubbleMinHeight     42

#define kMessageBubbleWidthMargin   22

#define kMessageIncomingLeftMargin  15
#define kMessageIncomingRightMargin 8
#define kMessageOutgoingLeftMargin  8
#define kMessageOutgoingRightMargin 15
#define kMessageBubbleTopMarigin    10
#define kMessageBubbleBottomMargin  10
#define kMessageIncomingImageLeftMargin     13
#define kMessageIncomingImageRightMargin    6
#define kMessageOutgoingImageLeftMargin     6
#define kMessageOutgoingImageRightMargin    13
#define kMessageBubbleImageTopMarigin    6
#define kMessageBubbleImageBottomMargin  6
#define headDefaltWidth             46
#define headDefaltHeight            46
#define upLoadImgWidth            720









// 加载
#define kShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
// 收起加载
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
// 设置加载
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x


#define kShowHUDAndActivity kBackView;[MBProgressHUD showHUDAddedTo:kWindow animated:YES];kShowNetworkActivityIndicator()

#define kHiddenHUD [MBProgressHUD hideAllHUDsForView:kWindow animated:YES]

#define kRemoveBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[UIView animateWithDuration:0.4 animations:^{ \
item.alpha = 0.0; \
} completion:^(BOOL finished) { \
[item removeFromSuperview]; \
}]; \
} \
} \

#define kHiddenHUDAndAvtivity kRemoveBackView;kHiddenHUD;HideNetworkActivityIndicator()








//UIColorFromRGB(0x000000)
#define UIColorFromRGB(rgbValue) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.7]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]



//颜色
#define kColorGray3             [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1]
#define kColorGray4             [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1]
#define kColorGray5             [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1]
#define kColorGray6             [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1]
#define kColorBlue1              [UIColor colorWithRed:48/255.0 green:183/255.0 blue:239/255.0 alpha:1]
#define kColorPinkLine          [UIColor colorWithRed:247/255.0 green:111/255.0 blue:113/255.0 alpha:0.3]
#define kColorGray240             RGBColor(240,240,240)
#define kColorGray225             RGBColor(225,225,225)
#define kColorGray154             RGBColor(154,154,154)
#define kColorBlack64             RGBColor(64,64,64)
#define kColorGray86              RGBColor(86,86,86)
#define kColorGray100             RGBColor(100,100,100)
#define KMainColorRed             RGBColor(245, 70, 50)
#define KColorNormalTxt             RGBCOLOR(75, 75, 75)          //
#define KColorTitleTxt              RGBCOLOR(0x4a, 0x4a, 0x4a) //标题颜色
#define KColorSubTitleTxt           RGBCOLOR(0xab, 0xab, 0xab) //子标题颜色

//新定义颜色
#define kColorBackground            [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]
#define kColorClear                 [UIColor clearColor]
#define kColorWhite                 RGBCOLOR(254,254,254)           //白色字体
#define kColorBlack                 RGBCOLOR(68,68,68)              //黑色字体
#define kColorGray                  RGBCOLOR(115,115,115)           //灰色字体
#define kColorGray1                 RGBCOLOR(73, 104, 119)
#define kColorLightGray             RGBCOLOR(159,160,160)           //浅灰色字体
#define kColorLine                  RGBCOLOR(216,216,216)           //分割线颜色
#define kColorPink                  RGBCOLOR(253,133,132)           //粉色
#define kColorBlue                  RGBCOLOR(0, 160, 233)
#define SCThemeColor                  RGBCOLOR(0, 158, 166)         //底部导航颜色
#define kColorOrange                RGBCOLOR(250, 111, 19)          //
#define SCBlackColor  [UIColor colorWithHexString:@"#2d2e2e" alpha:1]
#define SCGrayColor  [UIColor colorWithHexString:@"#666767" alpha:1]
#define SCLightGrayColor  [UIColor colorWithHexString:@"#b5b6b6" alpha:1]
#define SCLineGrayColor  [UIColor colorWithHexString:@"#ebeded" alpha:1]
#define SCBackgroundGrayColor  [UIColor colorWithHexString:@"#f3f5f7" alpha:1]

//新定义字体
#define kFontNormal                 [UIFont systemFontOfSize:18]
#define kFontNormal_b               [UIFont boldSystemFontOfSize:18]
#define kFontMiddle                 [UIFont systemFontOfSize:15]
#define kFontMiddle_b               [UIFont boldSystemFontOfSize:15]
#define kFontSmall                  [UIFont systemFontOfSize:13]
#define kFontSmall_b                [UIFont boldSystemFontOfSize:13]
#define kFontLarge                  [UIFont systemFontOfSize:16]
#define kFontLarge_b                [UIFont boldSystemFontOfSize:16]
#define kFontSubTitle               [UIFont systemFontOfSize:12]
#define kFontTitle                  [UIFont systemFontOfSize:14]
#define kFontTimeTitle              [UIFont systemFontOfSize:9]

//font
#define kFontSuper                 [UIFont systemFontOfSize:20]
#define kFontSuper_b               [UIFont boldSystemFontOfSize:20]
#define kFontLarge_1               [UIFont systemFontOfSize:17]
#define kFontLarge_1_b             [UIFont boldSystemFontOfSize:17]

#define kFontSmallBold             [UIFont boldSystemFontOfSize:12]
#define kFontTiny                  [UIFont systemFontOfSize:11]
#define kFontMini                  [UIFont systemFontOfSize:10]
#define kMessageTextFont           [UIFont systemFontOfSize:16]
#define kNavigationBarColor    UIColorFromRGB(0x3f80de)

#define LoginIconViewHeight 150.0f   //left - headerview - height


#import "UIColor+SCExtension.h"

/**
 *  以下颜色统统采用最直接的系统定义方法，这样可以利用插件直接查看颜色
 *  如果采用宏定义或者包装方法，就无法直观查看颜色，那样不太方便
 *
 */

//一般文本色
#define kLLTextColor_Normal [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]

//黑色度略微下降的黑色
#define kLLTextColor_lightBlack [UIColor colorWithWhite:0.2 alpha:1]

#define kLLTextColor_grayBlack [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]


//略微发灰的文本
#define kLLTextColor_lightGray_7 [UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:1]

#define kLLTextColor_lightGray_6 [UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:1]

#define kLLTextColor_lightGray_5 [UIColor colorWithRed:93/255.0 green:93/255.0 blue:93/255.0 alpha:1]

//系统提供的灰色
#define kLLTextColor_lightGray_system [UIColor lightGrayColor]

//淡蓝色文本
#define kLLTextColor_slightBlue [UIColor colorWithRed:82/255.0 green:126/255.0 blue:173/255.0 alpha:1]

#define kLLBackgroundColor_slightBlue [UIColor colorWithRed:30/255.0 green:130/255.0 blue:233/255.0 alpha:0.3]


#define kLLBackgroundColor_slightGray [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]

#define kLLBackgourndColor_inputGray [UIColor colorWithRed:242/255.0 green:244/255.0 blue:247/255.0 alpha:1]

#define kLLBackgroundColor_nearWhite [UIColor colorWithRed:251/255.0 green:251/255.0 blue:251/255.0 alpha:1]

#define kLLBackgroundColor_lightGray [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]

#define kLLBackgroundColor_gray [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]

#define kLLBackgroundColor_darkGray [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1]

#define kLLBackgroundColor_darkGray2 [UIColor colorWithRed:187/255.0 green:186/255.0 blue:193/255.0 alpha:1]

#define kLLBackgroundColor_slightGreen [UIColor colorWithRed:229/255.f green:238/255.f blue:235/255.f alpha:1.f]

#define kLLTableSeperatorColor_gray [UIColor colorWithRed:200/255.f green:199/255.f blue:204/255.f alpha:1.f].CGColor // 列表分割线颜色

//半透明的背景，用于遮罩下面背景
#define kLLMaskBackgroundColor [UIColor colorWithWhite:0 alpha:0.6]


#define kLLTextLinkColor [UIColor colorWithRed:0/255.0 green:104/255.0 blue:248/255.0 alpha:1]

#define kLLAppleTinkColor [UIColor colorWithRed:0/255.0 green:104/255.0 blue:248/255.0 alpha:1]

#define kLLTextColor_green [UIColor colorWithRed:29/255.0 green:185/255.0 blue:14/255.0 alpha:1]

#define kLLTextColor_darkGreen [UIColor colorWithRed:17/255.0 green:137/255.0 blue:30/255.0 alpha:1]

#pragma mark - 红色系
//9C3638

#define kLLBackgroundColor_SlightDardRed [UIColor colorWithRed:231/255.0 green:80/255.0 blue:73/255.0 alpha:1]

#define kLLBackgroundColor_DarkRed [UIColor colorWithRed:156/255.0 green:54/255.0 blue:56/255.0 alpha:1]

#define kLLTextColor_drarRed [UIColor colorWithRed:183/255.0 green:24/255.0 blue:24/255.0 alpha:1]



#pragma mark - UIKit组件默认颜色 -

#define SAFARI_BAR_COLOR [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0]; // iOS7 Safari bar color

//UITableViewGroup 样式时，背景颜色
#define TABLE_VIEW_GROUP_BACKGROUNDCOLOR [UIColor colorWithRed:239.f / 255.f green:239.f / 255.f blue:244.f / 255.f alpha:1.0];



#endif /* SCUI_h */
