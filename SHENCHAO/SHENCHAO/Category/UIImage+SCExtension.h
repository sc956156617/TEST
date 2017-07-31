//
//  UIImage+SCExtension.h
//  SCCateGory
//
//  Created by cb on 2017/7/10.
//  Copyright © 2017年 SC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <float.h>
@import Accelerate;
@interface UIImage (SCExtension)
/**********颜色设置******/
//主题颜色
/**
 *  返回一张指定size的指定颜色的纯色图片
 */
+ (UIImage *_Nullable)xl_imageWithColor:(UIColor *_Nullable)color size:(CGSize)size;
-(UIImage*_Nullable)SC_tintedImageWithColor:(UIColor*_Nullable)color;
-(UIImage*_Nullable)SC_tintedImageWithColor:(UIColor*_Nullable)color level:(CGFloat)level;
-(UIImage*_Nullable)SC_tintedImageWithColor:(UIColor*_Nullable)color rect:(CGRect)rect;
-(UIImage*_Nullable)SC_tintedImageWithColor:(UIColor*_Nullable)color rect:(CGRect)rect level:(CGFloat)level;
-(UIImage*_Nullable)SC_tintedImageWithColor:(UIColor*_Nullable)color insets:(UIEdgeInsets)insets;
-(UIImage*_Nullable)SC_tintedImageWithColor:(UIColor*_Nullable)color insets:(UIEdgeInsets)insets level:(CGFloat)level;
//调亮一点
-(UIImage*_Nullable)SC_lightenWithLevel:(CGFloat)level;
-(UIImage*_Nullable)SC_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*_Nullable)SC_lightenRect:(CGRect)rect withLevel:(CGFloat)level;
//调暗一点
-(UIImage*_Nullable)SC_darkenWithLevel:(CGFloat)level;
-(UIImage*_Nullable)SC_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*_Nullable)SC_darkenRect:(CGRect)rect withLevel:(CGFloat)level;


/**********系统方法封装******/
// instancetype默认会识别当前是哪个类或者对象调用，就会转换成对应的类的对象
// UIImage *

// 加载最原始的图片，没有渲染
+ (instancetype _Nullable )imageWithOriginalName:(NSString *_Nullable)imageName;

// 两边拉伸 默认 双边。0.5
+ (instancetype _Nullable )imageWithStretchableName:(NSString *_Nullable)imageName;

+ (UIImage *_Nullable)imageForResourcePath:(NSString *_Nullable)path ofType:(NSString *_Nullable)type inBundle:(NSBundle *_Nullable)bundle;
+ (UIImage *_Nullable)clearImageWithSize:(CGSize)size;
/**
 压缩图片
 */
- (UIImage *_Nullable)MaxFileSize:(NSInteger)maxFileSize;


/**
 图片截取
 @param frame 截取的位置
 @param angle 旋转的弧度
 @param circular 是否为椭圆
 @return 图片
 */
- (nonnull UIImage *)croppedImageWithFrame:(CGRect)frame angle:(NSInteger)angle circularClip:(BOOL)circular;   // ？？


//图片自适应
- (UIImage *_Nullable)rescaleImageToSize:(CGSize)size;


/**
*
*   生成一张图片
*  @param view 传入一个视图
*
*  @return 修改后的图片
*/
+ (UIImage *_Nullable)imageWithView:(UIView *_Nullable)view;
/**
 *
 *   生成一张纯色图片
 */
+ (UIImage *_Nullable)imageWithColor:(UIColor *_Nullable)color;
/**
 *
 *   生成一张plus大小的icon图
 */
+ (UIImage *_Nullable) stepperPlusImageWithColor:(UIColor *_Nullable)color;
/**
 *
 *   生成一张最小icon图
 */
+ (UIImage *_Nullable) stepperMinusImageWithColor:(UIColor *_Nullable)color;
/**
 *
 *   生成一张纯色图片可控制大小的图片
 */
+ (UIImage *_Nullable)imageWithColor:(UIColor *_Nullable)color size:(CGSize)size;
/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *_Nullable)image:(UIImage*_Nullable)image byScalingToSize:(CGSize)targetSize;
/*
 *根据路径取图片
 *
 */
+ (UIImage *_Nullable)imageWithBundleNamed:(NSString *_Nullable)name andBundleName:(NSString *_Nullable)bundle;
/*
 *生成圆角图片
 *
 */
+ (UIImage *_Nullable)imageWithColor:(UIColor *_Nullable)color
               cornerRadius:(CGFloat)cornerRadius;
/*
 *生成圆角阴影设置图片图片
 *
 */
+ (UIImage *_Nullable) buttonImageWithColor:(UIColor *_Nullable)color
                      cornerRadius:(CGFloat)cornerRadius
                       shadowColor:(UIColor *_Nullable)shadowColor
                      shadowInsets:(UIEdgeInsets)shadowInsets;
/*
 *生成圆形图片
 *
 */
+ (UIImage *_Nullable) circularImageWithColor:(UIColor *_Nullable)color
                                size:(CGSize)size;
/*
 *生成返回图片
 *
 */
+ (UIImage * _Nullable) backButtonImageWithColor:(UIColor *_Nullable)color
                            barMetrics:(UIBarMetrics) metrics
                          cornerRadius:(CGFloat)cornerRadius;


+ (CGFloat)scaleForPickImage:(UIImage *_Nullable)image maxWidthPixelSize:(CGFloat)maxWidthPixelSize;
+ (UIImage *_Nullable)scaleImage:(UIImage *_Nullable)image scale:(CGFloat)scale;





- (CGSize)pixelSize;
- (UIImage *_Nullable)darkenImage;
- (UIImage *_Nullable)getGrayImage;
- (NSInteger)imageFileSize;
- (UIImage *_Nullable)resizableImage;
- (UIImage *_Nullable)imageToSize:(CGSize)size;
- (UIImage *_Nullable)imageTo4b3AtSize:(CGSize)size;
- (UIImage *_Nullable)resizeImageToSize:(CGSize)size;
- (UIImage *_Nullable) maskWithColor:(UIColor *_Nullable) color;
- (UIImage *_Nullable) renderAtSize:(const CGSize) size;
- (UIImage *_Nullable)createWithImageInRect:(CGRect)rect;
- (UIImage *_Nullable) imageWithMinimumSize:(CGSize)size;
- (UIImage *_Nullable) maskWithImage:(const UIImage *_Nullable) maskImage;
- (UIImage *_Nullable)resizeImageToSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale;
- (UIImage *_Nullable) partialImageWithPercentage:(float)percentage vertical:(BOOL)vertical grayscaleRest:(BOOL)grayscaleRest;



- (UIImage *_Nullable) imageWithTintColor:(UIColor *_Nullable)tintColor;
- (UIImage *_Nullable) imageWithGradientTintColor:(UIColor *_Nullable)tintColor;

- (UIImage *_Nullable)applyAlpha:(CGFloat)alpha;

/*
 图片显示规则
 1.  图片始终按比例缩放
 2.  长边始终等于126px;36px<=短边<=126px
 3.  1<=长边/短边<=3.5时,长边=126px
 4.  长边/短边>3.5时,短边=72px,长边只显示中间126px的部分
 */
+ (UIImage *_Nullable)imageShowRegular:(UIImage *_Nullable)aImage;


//按原图比例显示
+ (UIImage *_Nullable)imageShowOrigin:(UIImage *_Nullable)aImage;


//
+ (UIImage *_Nullable)fixImageOrientation:(UIImage *_Nullable) aImage;

/*
 *  缩放
 */
-(UIImage*_Nullable)scaleToSize:(CGSize)size;

- (UIImage *_Nullable)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *_Nullable)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *_Nullable)maskImage;
@end
