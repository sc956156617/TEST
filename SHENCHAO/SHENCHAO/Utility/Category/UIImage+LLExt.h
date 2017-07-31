//
//  UIImage+LLExt.h
//  LLWeChat
//
//  Created by GYJZH on 8/29/16.
//  Copyright © 2016 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LLExt)

/**
 *
 *   生成一张图片
 *  @param view 传入一个视图
 *
 *  @return 修改后的图片
 */
+ (UIImage *)imageWithView:(UIView *)view;
/**
 *
 *   生成一张纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *
 *   生成一张plus大小的icon图
 */
+ (UIImage *) stepperPlusImageWithColor:(UIColor *)color;
/**
 *
 *   生成一张最小icon图
 */
+ (UIImage *) stepperMinusImageWithColor:(UIColor *)color;
/**
 *
 *   生成一张纯色图片可控制大小的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize;
/*
 *根据路径取图片
 *
 */
+ (UIImage *)imageWithBundleNamed:(NSString *)name andBundleName:(NSString *)bundle;
/*
 *生成圆角图片
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius;
/*
 *生成圆角阴影设置图片图片
 *
 */
+ (UIImage *) buttonImageWithColor:(UIColor *)color
                      cornerRadius:(CGFloat)cornerRadius
                       shadowColor:(UIColor *)shadowColor
                      shadowInsets:(UIEdgeInsets)shadowInsets;
/*
 *生成圆形图片
 *
 */
+ (UIImage *) circularImageWithColor:(UIColor *)color
                                size:(CGSize)size;
/*
 *生成返回图片
 *
 */
+ (UIImage *) backButtonImageWithColor:(UIColor *)color
                            barMetrics:(UIBarMetrics) metrics
                          cornerRadius:(CGFloat)cornerRadius;


+ (CGFloat)scaleForPickImage:(UIImage *)image maxWidthPixelSize:(CGFloat)maxWidthPixelSize;
+ (UIImage *)scaleImage:(UIImage *)image scale:(CGFloat)scale;





- (CGSize)pixelSize;
- (UIImage *)darkenImage;
- (UIImage *)getGrayImage;
- (NSInteger)imageFileSize;
- (UIImage *)resizableImage;  //压缩为图片的1/2
- (UIImage *)imageToSize:(CGSize)size;
- (UIImage *)imageTo4b3AtSize:(CGSize)size;
- (UIImage *)resizeImageToSize:(CGSize)size;
- (UIImage *) maskWithColor:(UIColor *) color;
- (UIImage *) renderAtSize:(const CGSize) size;
- (UIImage *)createWithImageInRect:(CGRect)rect;
- (UIImage *) imageWithMinimumSize:(CGSize)size;
- (UIImage *) maskWithImage:(const UIImage *) maskImage;
- (UIImage *)resizeImageToSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale;
- (UIImage *) partialImageWithPercentage:(float)percentage vertical:(BOOL)vertical grayscaleRest:(BOOL)grayscaleRest;

@end
