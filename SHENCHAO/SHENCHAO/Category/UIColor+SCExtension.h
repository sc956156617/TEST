//
//  UIColor+SCExtension.h
//  SCCateGory
//
//  Created by cb on 2017/7/11.
//  Copyright © 2017年 SC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SCExtension)
#define UIColorRGBA(_red, _green, _blue, _alpha) [UIColor colorWithRed:((_red)/255.0) \
green:((_green)/255.0) blue:((_blue)/255.0) alpha:(_alpha)]

#define UIColorRGB(red, green, blue) UIColorRGBA(red, green, blue, 1)

#define UIColorHexRGB(rgbString) [UIColor colorWithHexRGB:(rgbString)]

#define UIColorHexRGBA(rgbaString) [UIColor colorWithHexRGBA:(rgbaString)]


+ (instancetype)colorWithHexRGBA:(NSString *)rgba;

+ (instancetype)colorWithHexRGB:(NSString *)rgb;

+ (instancetype)colorWithHexARGB:(NSString *)argb;

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly) BOOL canProvideRGBComponents;

@property (nonatomic, readonly) CGFloat red;	// Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat green;	// Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat blue;	// Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat white;	// Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat hue;
@property (nonatomic, readonly) CGFloat saturation;
@property (nonatomic, readonly) CGFloat brightness;
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) CGFloat luminance;
@property (nonatomic, readonly) UInt32 rgbHex;
@property (nonatomic, readonly) UInt32 rgbaHex;

- (NSString *)colorSpaceString;
- (NSArray *)arrayFromRGBAComponents;

// Bulk access to RGB and HSB components of the color
// HSB components are converted from the RGB components
- (BOOL)red:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b alpha:(CGFloat *)a;
- (BOOL)hue:(CGFloat *)h saturation:(CGFloat *)s brightness:(CGFloat *)b alpha:(CGFloat *)a;

// Return a grey-scale representation of the color
- (UIColor *)colorByLuminanceMapping;

// Arithmetic operations on the color
- (UIColor *)colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *)       colorByAddingRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *) colorByLighteningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *)  colorByDarkeningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

- (UIColor *)colorByMultiplyingBy:(CGFloat)f;
- (UIColor *)       colorByAdding:(CGFloat)f;
- (UIColor *) colorByLighteningTo:(CGFloat)f;
- (UIColor *)  colorByDarkeningTo:(CGFloat)f;

- (UIColor *)colorByMultiplyingByColor:(UIColor *)color;
- (UIColor *)       colorByAddingColor:(UIColor *)color;
- (UIColor *) colorByLighteningToColor:(UIColor *)color;
- (UIColor *)  colorByDarkeningToColor:(UIColor *)color;

// Returns a color the given fraction between the receiver and the
// target color. Fraction should be between 0.0 and 1.0.
- (UIColor *)colorByInterpolatingToColor:(UIColor *)color byFraction:(CGFloat)fraction;

// Related colors
- (UIColor *)contrastingColor;			// A good contrasting color: will be either black or white
- (UIColor *)complementaryColor;		// A complementary color that should look good with this color
- (NSArray*)triadicColors;				// Two colors that should look good with this color
- (NSArray*)analogousColorsWithStepAngle:(CGFloat)stepAngle pairCount:(int)pairs;	// Multiple pairs of colors

// String representations of the color
- (NSString *)stringFromColor;
- (NSString *)hexStringFromColor;
- (NSString *)hexStringFromColorAndAlpha;
- (NSString *)cssStringFromColor;

// The named color that matches this one most closely
- (NSString *)closestColorName;
- (NSString *)closestCrayonName;

// Color builders
+ (UIColor *)randomColor;
//H(hues)表示色相，S(saturation)表示饱和度，B（brightness）表示亮度
+ (UIColor *)randomHSBColor;
+ (UIColor *)randomHSBColorWithMinSaturation:(CGFloat)minSat minBrightness:(CGFloat)minBright;
+ (UIColor *)colorWithString:(NSString *)stringToConvert;
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithRGBAHex:(UInt32)hex;
+ (UIColor *)colorWithGray:(CGFloat)gray;
+ (UIColor *)colorWithGrayHex:(UInt8)gray;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorAndAlphaWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithName:(NSString *)cssColorName;

//css代码描述的颜色
+ (UIColor *)colorWithCSSDescription:(NSString *)cssDescription;
//蜡笔的颜色
+ (UIColor *)crayonWithName:(NSString *)crayonColorName;

+ (UIColor *)colorWithNormalizedRGBDictionary:(NSDictionary *)colorDict;
+ (UIColor *)colorWithByteRGBDictionary:(NSDictionary *)colorDict;
+ (UIColor *)colorWithRGBDictionary:(NSDictionary *)colorDict;
+ (CGFloat *) getColorRGBAValueForUIColor: (UIColor *)selfcolor;
- (NSUInteger)rgbaValue;

// Build a color with the given HSB values
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 50000
+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
#endif
+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;

// Low level conversions between RGB and HSB spaces
+ (void)hue:(CGFloat)h saturation:(CGFloat)s brightness:(CGFloat)v toRed:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b;
+ (void)red:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b toHue:(CGFloat *)h saturation:(CGFloat *)s brightness:(CGFloat *)v;

@end
