//
//  UIImage+SCExtension.m
//  SCCateGory
//
//  Created by cb on 2017/7/10.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "UIImage+SCExtension.h"

@implementation UIImage (SCExtension)
// Tint: Color
-(UIImage*)SC_tintedImageWithColor:(UIColor*)color {
    return [self SC_tintedImageWithColor:color level:1.0f];
}

// Tint: Color + level
-(UIImage*)SC_tintedImageWithColor:(UIColor*)color level:(CGFloat)level {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self SC_tintedImageWithColor:color rect:rect level:level];
}

// Tint: Color + Rect
-(UIImage*)SC_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect {
    return [self SC_tintedImageWithColor:color rect:rect level:1.0f];
}

// Tint: Color + Rect + level

-(UIImage*)SC_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level {
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self drawInRect:imageRect];
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextSetAlpha(ctx, level);
    CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
    CGContextFillRect(ctx, rect);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *darkImage = [UIImage imageWithCGImage:imageRef
                                             scale:self.scale
                                       orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    return darkImage;
}

// Tint: Color + Insets
-(UIImage*)SC_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets {
    return [self SC_tintedImageWithColor:color insets:insets level:1.0f];
}

// Tint: Color + Insets + level
-(UIImage*)SC_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets level:(CGFloat)level {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self SC_tintedImageWithColor:color rect:UIEdgeInsetsInsetRect(rect, insets) level:level];
}

// Light: Level
-(UIImage*)SC_lightenWithLevel:(CGFloat)level {
    return [self SC_tintedImageWithColor:[UIColor whiteColor] level:level];
}

// Light: Level + Insets
-(UIImage*)SC_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets {
    return [self SC_tintedImageWithColor:[UIColor whiteColor] insets:insets level:level];
}

// Light: Level + Rect
-(UIImage*)SC_lightenRect:(CGRect)rect withLevel:(CGFloat)level {
    return [self SC_tintedImageWithColor:[UIColor whiteColor] rect:rect level:level];
}

// Dark: Level
-(UIImage*)SC_darkenWithLevel:(CGFloat)level {
    return [self SC_tintedImageWithColor:[UIColor blackColor] level:level];
}

// Dark: Level + Insets
-(UIImage*)SC_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets {
    return [self SC_tintedImageWithColor:[UIColor blackColor] insets:insets level:level];
}

// Dark: Level + Rect
-(UIImage*)SC_darkenRect:(CGRect)rect withLevel:(CGFloat)level {
    return [self SC_tintedImageWithColor:[UIColor blackColor] rect:rect level:level];
}

+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

- (UIImage *)MaxFileSize:(NSInteger)maxFileSize {
    //maxfileSize : 压缩后最大字节数
    CGFloat compression = 0.9f; //像素压缩比例
    CGFloat maxCompression = 0.1f;  //压缩最大比例
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(self, compression);
        if (compression==0.1) {
            maxFileSize = [imageData length];
        }
    }
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}
- (BOOL)hasAlpha
{
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
    return (alphaInfo == kCGImageAlphaFirst || alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst || alphaInfo == kCGImageAlphaPremultipliedLast);
}
/**
 *  返回一张指定size的指定颜色的纯色图片
 */
+ (UIImage *)xl_imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (size.width <= 0  ) {
        size = CGSizeMake(3, 3);
    }
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
+ (UIImage *)imageForResourcePath:(NSString *)path ofType:(NSString *)type inBundle:(NSBundle *)bundle {
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:path ofType:type]];
}

+ (UIImage *)clearImageWithSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return blank;
}
- (UIImage *)croppedImageWithFrame:(CGRect)frame angle:(NSInteger)angle circularClip:(BOOL)circular
{
    UIImage *croppedImage = nil;
    UIGraphicsBeginImageContextWithOptions(frame.size, ![self hasAlpha] && !circular, self.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        if (circular) {
            CGContextAddEllipseInRect(context, (CGRect){CGPointZero, frame.size});
            CGContextClip(context);
        }
        
        //To conserve memory in not needing to completely re-render the image re-rotated,
        //map the image to a view and then use Core Animation to manipulate its rotation
        if (angle != 0) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:self];
            imageView.layer.minificationFilter = kCAFilterNearest;
            imageView.layer.magnificationFilter = kCAFilterNearest;
            imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle * (M_PI/180.0f));
            CGRect rotatedRect = CGRectApplyAffineTransform(imageView.bounds, imageView.transform);
            UIView *containerView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, rotatedRect.size}];
            [containerView addSubview:imageView];
            imageView.center = containerView.center;
            CGContextTranslateCTM(context, -frame.origin.x, -frame.origin.y);
            [containerView.layer renderInContext:context];
        }
        else {
            CGContextTranslateCTM(context, -frame.origin.x, -frame.origin.y);
            [self drawAtPoint:CGPointZero];
        }
        
        croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithCGImage:croppedImage.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
}
static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}
+ (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}
/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}
+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

+ (UIImage *) buttonImageWithColor:(UIColor *)color
                      cornerRadius:(CGFloat)cornerRadius
                       shadowColor:(UIColor *)shadowColor
                      shadowInsets:(UIEdgeInsets)shadowInsets {
    
    UIImage *topImage = [self imageWithColor:color cornerRadius:cornerRadius];
    UIImage *bottomImage = [self imageWithColor:shadowColor cornerRadius:cornerRadius];
    CGFloat totalHeight = edgeSizeFromCornerRadius(cornerRadius) + shadowInsets.top + shadowInsets.bottom;
    CGFloat totalWidth = edgeSizeFromCornerRadius(cornerRadius) + shadowInsets.left + shadowInsets.right;
    CGFloat topWidth = edgeSizeFromCornerRadius(cornerRadius);
    CGFloat topHeight = edgeSizeFromCornerRadius(cornerRadius);
    CGRect topRect = CGRectMake(shadowInsets.left, shadowInsets.top, topWidth, topHeight);
    CGRect bottomRect = CGRectMake(0, 0, totalWidth, totalHeight);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(totalWidth, totalHeight), NO, 0.0f);
    if (!CGRectEqualToRect(bottomRect, topRect)) {
        [bottomImage drawInRect:bottomRect];
    }
    [topImage drawInRect:topRect];
    UIImage *buttonImage = UIGraphicsGetImageFromCurrentImageContext();
    UIEdgeInsets resizeableInsets = UIEdgeInsetsMake(cornerRadius + shadowInsets.top,
                                                     cornerRadius + shadowInsets.left,
                                                     cornerRadius + shadowInsets.bottom,
                                                     cornerRadius + shadowInsets.right);
    return [buttonImage resizableImageWithCapInsets:resizeableInsets];
    
}

+ (UIImage *) circularImageWithColor:(UIColor *)color
                                size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [color setStroke];
    [circle addClip];
    [circle fill];
    [circle stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImage *) renderAtSize:(const CGSize) size
{
    UIGraphicsBeginImageContext(size);
    const CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    const CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIImage *renderedImage = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    UIGraphicsEndImageContext();
    
    return renderedImage;
}

- (UIImage *) maskWithImage:(const UIImage *) maskImage
{
    const CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    const CGImageRef maskImageRef = maskImage.CGImage;
    
    const CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    if (! mainViewContentContext)
    {
        return nil;
    }
    
    CGFloat ratio = maskImage.size.width / self.size.width;
    
    if (ratio * self.size.height < maskImage.size.height)
    {
        ratio = maskImage.size.height / self.size.height;
    }
    
    const CGRect maskRect  = CGRectMake(0, 0, maskImage.size.width, maskImage.size.height);
    
    const CGRect imageRect  = CGRectMake(-((self.size.width * ratio) - maskImage.size.width) / 2,
                                         -((self.size.height * ratio) - maskImage.size.height) / 2,
                                         self.size.width * ratio,
                                         self.size.height * ratio);
    
    CGContextClipToMask(mainViewContentContext, maskRect, maskImageRef);
    CGContextDrawImage(mainViewContentContext, imageRect, self.CGImage);
    
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    
    CGImageRelease(newImage);
    
    return theImage;
    
}

/*
 maskWithColor
 takes a (grayscale) image and 'tints' it with the supplied color.
 */
- (UIImage *) maskWithColor:(UIColor *) color
{
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGRect bounds = CGRectMake(0,0,width,height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextClipToMask(bitmapContext, bounds, self.CGImage);
    CGContextSetFillColorWithColor(bitmapContext, color.CGColor);
    CGContextFillRect(bitmapContext, bounds);
    
    CGImageRef cImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *coloredImage = [UIImage imageWithCGImage:cImage];
    
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(cImage);
    
    return coloredImage;
    
}

+ (UIImage *)imageWithBundleNamed:(NSString *)name andBundleName:(NSString *)bundle{
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",bundle,name]];
}

- (UIImage *)imageTo4b3AtSize:(CGSize)size
{
    if (size.height / size.width != 3.0 / 4.0)
        return nil;
    
    // 倍数
    CGFloat widthMultiple = self.size.width / 4.0;
    CGFloat heightMultiple = self.size.height / 3.0;
    
    // 宽高先缩放到4:3
    CGFloat scale = 0;
    // 缩放已倍数小的为准
    if (widthMultiple < heightMultiple) {
        // 图片比目标大小大时才缩放
        if (self.size.width > size.width)
            scale = size.width / self.size.width;
    }
    // 高的倍数小 or 高宽倍数相等
    else {
        // 图片比目标大小大时才缩放
        if (self.size.height > size.height)
            scale = size.height / self.size.height;
    }
    
    UIImage *img = self;
    
    // 需要缩放
    if (scale != 0) {
        img = [self imageToScale:scale];
    }
    
    // 需要裁剪
    if (widthMultiple != heightMultiple) {
        img = [img imageTo4b3];
    }
    
    return img;
}

- (UIImage *)imageToScale:(float)scale
{
    CGSize size = CGSizeMake(self.size.width * scale, self.size.height * scale);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)imageTo4b3
{
    // 倍数
    CGFloat widthMultiple = self.size.width / 4.0;
    CGFloat heightMultiple = self.size.height / 3.0;
    
    CGRect rect = CGRectNull;
    // 倍数大的裁剪
    if (widthMultiple > heightMultiple) {
        CGFloat newWidth = heightMultiple * 4.0;
        rect = CGRectMake((self.size.width - newWidth) / 2, 0, newWidth, self.size.height);
    } else if (heightMultiple > widthMultiple) {
        CGFloat newHeight = widthMultiple * 3.0;
        rect = CGRectMake(0, (self.size.height - newHeight) / 2, self.size.width, newHeight);
    }
    
    if (CGRectIsNull(rect)) {
        return self;
    } else {
        UIImage *image4b3 = [self newImageAtRect:rect];
        return image4b3;
    }
}


// 图片裁剪
- (UIImage *)newImageAtRect:(CGRect)rect
{
    rect = CGRectMake(rect.origin.x * self.scale, rect.origin.y * self.scale, rect.size.width * self.scale, rect.size.height * self.scale);
    
    CGImageRef imgref = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *img = [UIImage imageWithCGImage:imgref];
    CGImageRelease(imgref);
    return img;
}

- (UIImage *)imageToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *sizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return sizeImage;
}

+ (CGFloat)scaleForPickImage:(UIImage *)image maxWidthPixelSize:(CGFloat)maxWidthPixelSize
{
    if (!image) {
        return 1.f;
    }
    CGFloat scale = 1.f;
    CGSize imageSize = image.size;
    if (imageSize.width > maxWidthPixelSize) {
        scale = maxWidthPixelSize / imageSize.width;
    }
    return scale;
}

+ (UIImage *)scaleImage:(UIImage *)image scale:(CGFloat)scale
{
    if (!image) {
        return nil;
    }
    CGSize size = CGSizeMake(image.size.width * scale, image.size.height * scale);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
- (UIImage *) imageWithMinimumSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0.0f);
    [self drawInRect:rect];
    UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
    return [resized resizableImageWithCapInsets:UIEdgeInsetsMake(size.height/2, size.width/2, size.height/2, size.width/2)];
}

+ (UIImage *) stepperPlusImageWithColor:(UIColor *)color {
    CGFloat iconEdgeSize = 15;
    CGFloat iconInternalEdgeSize = 3;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(iconEdgeSize, iconEdgeSize), NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGFloat padding = (iconEdgeSize - iconInternalEdgeSize) / 2;
    CGContextFillRect(context, CGRectMake(padding, 0, iconInternalEdgeSize, iconEdgeSize));
    CGContextFillRect(context, CGRectMake(0, padding, iconEdgeSize, iconInternalEdgeSize));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) stepperMinusImageWithColor:(UIColor *)color {
    CGFloat iconEdgeSize = 15;
    CGFloat iconInternalEdgeSize = 3;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(iconEdgeSize, iconEdgeSize), NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGFloat padding = (iconEdgeSize - iconInternalEdgeSize) / 2;
    CGContextFillRect(context, CGRectMake(0, padding, iconEdgeSize, iconInternalEdgeSize));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) backButtonImageWithColor:(UIColor *)color
                            barMetrics:(UIBarMetrics) metrics
                          cornerRadius:(CGFloat)cornerRadius {
    
    CGSize size;
    if (metrics == UIBarMetricsDefault) {
        size = CGSizeMake(50, 30);
    }
    else {
        size = CGSizeMake(60, 23);
    }
    UIBezierPath *path = [self bezierPathForBackButtonInRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    [color setFill];
    [path addClip];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, 15, cornerRadius, cornerRadius)];
    
}

+ (UIBezierPath *) bezierPathForBackButtonInRect:(CGRect)rect cornerRadius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint mPoint = CGPointMake(CGRectGetMaxX(rect) - radius, rect.origin.y);
    CGPoint ctrlPoint = mPoint;
    [path moveToPoint:mPoint];
    
    ctrlPoint.y += radius;
    mPoint.x += radius;
    mPoint.y += radius;
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:M_PI + M_PI_2 endAngle:0 clockwise:YES];
    
    mPoint.y = CGRectGetMaxY(rect) - radius;
    [path addLineToPoint:mPoint];
    
    ctrlPoint = mPoint;
    mPoint.y += radius;
    mPoint.x -= radius;
    ctrlPoint.x -= radius;
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    mPoint.x = rect.origin.x + (10.0f);
    [path addLineToPoint:mPoint];
    
    [path addLineToPoint:CGPointMake(rect.origin.x, CGRectGetMidY(rect))];
    
    mPoint.y = rect.origin.y;
    [path addLineToPoint:mPoint];
    
    [path closePath];
    return path;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage*)getGrayImage
{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    
    return grayImage;
}

- (UIImage *)resizableImage {
    CGFloat capWidth =  floorf(self.size.width / 2);
    CGFloat capHeight =  floorf(self.size.height / 2);
    UIImage *capImage = [self resizableImageWithCapInsets:
                         UIEdgeInsetsMake(capHeight, capWidth, capHeight, capWidth)];
    
    return capImage;
}


- (UIImage *)resizeImageToSize:(CGSize)size {
    return [self resizeImageToSize:size opaque:NO scale:0];
}

- (UIImage *)resizeImageToSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale {
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


- (UIImage *)createWithImageInRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage],rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    return image;
}

- (UIImage *)darkenImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    [[UIColor redColor] setFill];
    
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)
           blendMode:kCGBlendModeDarken
               alpha:0.6];
    UIImage *highlighted = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return highlighted;
}

//http://stackoverflow.com/questions/1298867/convert-image-to-grayscale
- (UIImage *) partialImageWithPercentage:(float)percentage vertical:(BOOL)vertical grayscaleRest:(BOOL)grayscaleRest {
    const int ALPHA = 0;
    const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, self.size.width * self.scale, self.size.height * self.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);
    
    int x_origin = vertical ? 0 : width * percentage;
    int y_to = vertical ? height * (1.f -percentage) : height;
    
    for(int y = 0; y < y_to; y++) {
        for(int x = x_origin; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            
            if (grayscaleRest) {
                // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
                uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
                
                // set the pixels to gray
                rgbaPixel[RED] = gray;
                rgbaPixel[GREEN] = gray;
                rgbaPixel[BLUE] = gray;
            }
            else {
                rgbaPixel[ALPHA] = 0;
                rgbaPixel[RED] = 0;
                rgbaPixel[GREEN] = 0;
                rgbaPixel[BLUE] = 0;
            }
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image
                                                 scale:self.scale
                                           orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(image);
    
    return resultUIImage;
}

- (CGSize)pixelSize {
    return CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
}

- (NSInteger)imageFileSize {
    return self.size.width * self.size.height * self.scale * self.scale * 4;
}
- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

- (UIImage *)applyAlpha:(CGFloat)alpha
{
    int bmpAlpha = MIN(255, MAX(0, (255*alpha)));
    UIImage *image;
    int width = self.size.width * self.scale;
    int height = self.size.height * self.scale;
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    if (colorspace == NULL) {
        return nil;
    }
    
    Byte *imgData = NULL;
    imgData = malloc(width * height * 4);
    if (imgData == NULL) {
        CGColorSpaceRelease(colorspace);
        return nil;
    }
    
    CGContextRef bmpContext = CGBitmapContextCreate(imgData, width, height, 8, width * 4, colorspace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    if (!bmpContext) {
        CGColorSpaceRelease(colorspace);
        return nil;
    }
    
    CGContextDrawImage(bmpContext, CGRectMake(0, 0, width, height), self.CGImage);
    for (long i = 0; i < width * height; i++) {
        imgData[4*i+3] = bmpAlpha;
    }
    
    CGImageRef imageRef = CGBitmapContextCreateImage(bmpContext);
    if (imageRef != NULL) {
        image = [[UIImage alloc] initWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    
    CGColorSpaceRelease(colorspace);
    CGContextRelease(bmpContext);
    free(imgData);
    
    return image;
}
/*
 图片显示规则
 1.  图片始终按比例缩放
 2.  长边始终等于126px;36px<=短边<=126px
 3.  1<=长边/短边<=3.5时,长边=126px
 4.  长边/短边>3.5时,短边=72px,长边只显示中间126px的部分
 */
+ (UIImage *)imageShowRegular:(UIImage *)aImage
{
    if (aImage == nil) {
        return nil;
    }
    CGFloat compare = 0.0f;
    CGSize newImageSize = CGSizeMake(0.0, 0.0);
    if (aImage.size.width >= aImage.size.height) {
        compare = aImage.size.width / aImage.size.height;
        if (compare <= 3.5) {
            newImageSize.width = 126.0f;
            newImageSize.height = (aImage.size.height * 126.0) / aImage.size.width;
        }
        else
        {
            newImageSize.height = 36.0f;
            newImageSize.width = (aImage.size.width * 36.0) / aImage.size.height;
        }
    }
    else
    {
        compare = aImage.size.height / aImage.size.width;
        if (compare >= 1.0 && compare <= 3.5) {
            newImageSize.height = 126.0f;
            newImageSize.width = (aImage.size.width * 126.0) / aImage.size.height;
        }
        else
        {
            newImageSize.width = 36.0f;
            newImageSize.height = (aImage.size.height * 36.0) / aImage.size.width;
        }
    }
    UIGraphicsBeginImageContext(newImageSize);
    [aImage drawInRect:CGRectMake(0, 0, newImageSize.width, newImageSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageShowOrigin:(UIImage *)aImage
{
    if (aImage == nil) {
        return nil;
    }
    CGSize newImageSize = CGSizeMake(0.0, 0.0);
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat compare = (aImage.size.height / aImage.size.width) - screenHeight / screenWidth;
    
    if (compare > 0) {
        newImageSize.height = screenHeight;
        newImageSize.width = (screenHeight*aImage.size.width)/aImage.size.height;
    }
    else
    {
        newImageSize.width = screenWidth;
        newImageSize.height = (screenWidth*aImage.size.height)/aImage.size.width;
    }
    UIGraphicsBeginImageContext(newImageSize);
    [aImage drawInRect:CGRectMake(0, 0, newImageSize.width, newImageSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)fixImageOrientation:(UIImage *)aImage
{
    if (aImage.imageOrientation == UIImageOrientationUp) {
        return aImage;
    }
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:{
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        }
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:{
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        }
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:{
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        }
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:{
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        }
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:{
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        }
            
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height, CGImageGetBitsPerComponent(aImage.CGImage), 0, CGImageGetColorSpace(aImage.CGImage), CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:{
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.CGImage);
            break;
        }
        default:{
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.CGImage);
            break;
        }
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
    
    
    
}


//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage {
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}
@end
