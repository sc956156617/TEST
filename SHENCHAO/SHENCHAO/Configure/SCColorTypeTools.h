//
//  ColorTypeTools.h
//  Main
//
//  Created by yuhongtao on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <CommonCrypto/CommonDigest.h>//加密解密
#import <CommonCrypto/CommonCryptor.h> //加密解密
//#import "GTMBase64.h"

@interface SCColorTypeTools : NSObject
+(BOOL)IsChinese:(NSString *)str;//判读是否为中文
/**
 *  获取键盘高度
 *
 */


+(CGFloat)visibleKeyboardHeight;
//tabbar  多语言设置
+(void)setupTabbarTitle;
+(void)dismissToRootViewControllerWithVC:(id)controller;
//本appMD5加密
+(NSString *)MYcode:(NSString *)str;


//DES
+(NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key; //加密
+(NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key; //解密
+(NSString *) aes256_encrypt:(NSString *)key withString:(NSString *)str;
+(NSString *) aes256_decrypt:(NSString *)key withString:(NSString *)str;

//类型转换
+(NSString *)getTypeStringWith:(NSString *)type;
+(NSString *)getCourseTypeStringWith:(NSString *)type;
+(NSString *)getChineseStrWithOtherLanguageStr:(NSString *)str;
+(NSString *)getStudyStatusWith:(NSString *)str;
+(void)hsUpdateApp;


//设置导航栏按钮
+(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)hightImageName  addTarget:(id)target action:(SEL)action tintColor:(UIColor *)color;
+(UIBarButtonItem *)itemWithTitleName:(NSString *)TitleName highTitleName:(NSString *)hightTitleName  addTarget:(id)target action:(SEL)action tintColor:(UIColor *)color;


+(CGFloat)getBatteryQuantity; //获取电池状态
//缓存清楚
+(long long)getTotalDiskSize;  // 获取总磁盘容量
+(long long)getAvailableDiskSize ; //获取可用磁盘容量
+(long long)getTotalMemorySize;  //获取总内存大小;
+(NSString *)fileSizeToString:(unsigned long long)fileSize; //字符串转换函数

+ (NSString *) freeDiskSpaceInBytes;//剩余空间大小
+(float)fileSizeAtPath:(NSString *)path;  //计算单个文件的大小
+(float)folderSizeAtPath:(NSString *)path; //计算目录和其中文件的大小
+(void)clearCache:(NSString *)path;        //清除缓存
+(NSString *)clearTmpPics;//取得缓存图片大小
+ (NSInteger)getFileSizeWithPath:(NSString *)filePath Error:(NSError **)error;//获得🉐路径文件大小
+ (UIImage *)getImage:(NSString *)videoPath atTime:(NSTimeInterval)time Error:(NSError **)error;//得到视频几秒的图片
+ (BOOL)saveVideoThumbnailWithVideoPath:(NSString *)vieoPath toFile:(NSString *)ThumbnailPath Error:(NSError **)error;//保存视频截图到相应的path并返回是否成功
+ (NSString *)formatSecondsToString:(NSString *)seconds;//秒转化成时和分


+(NSString *)getDocmentsRelativePathWithAbsolutePath:(NSString *)pathStr;//根据docmens的绝对路径取相对路径

+(NSString *)getSexStringWith:(NSString *)type;
+(NSString *)getAreaStringWith:(NSString *)type;
+(id)JsonObjectwith:(NSString *)jsonStr ;

/*取到第几个tabbar 的图像*/
+(UIView *)swappableImageViewInTabBar:(UITabBar *)tabBar withIndex:(NSUInteger)index;
/*取到第几个tabbar 的文字*/
+(UIView *)UITabBarButtonLabelViewInTabBar:(UITabBar *)tabBar withIndex:(NSUInteger)index;


+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key;//将图片保存到本地
+ (BOOL)LocalHaveImage:(NSString*)key;//本地是否有相关图片
//从本地获取图片
+ (UIImage*)GetImageFromLocal:(NSString*)key;
/**
 *  把图片保存到相册
 *
 *  @param image
 */
+(void)saveImageToAlbum:(UIImage *)image;

+ (UIImage *) imageFromURLString: (NSString *) urlstring;
//iOS获取当前设备具体类型代码片段：
+(NSString *) platformString;


+ (UIImage *)colorImage:(UIColor *)c frame:(CGRect)frame;//制作一张纯色背景图。
/**
 *  统一设置全局UI
 */
+(void)setGlobalUIINDelegate;


//字符串中是否包含表情。
+(BOOL)isContainsEmoji:(NSString *)string;
@end
