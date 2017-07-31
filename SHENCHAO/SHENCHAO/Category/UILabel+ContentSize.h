//
//  UILabel+ContentSize.h
//  UCAuctionPlatform
//
//  Created by zandavid on 15/7/31.
//  Copyright (c) 2015年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ContentSize)

- (CGSize)contentSize;

+ (CGSize)contentSizeForLabelWithText:(NSString *)text
                             maxWidth:(CGFloat)width
                                 font:(UIFont *)font;

+ (CGFloat)heightForLabelWithText:(NSString *)text
                         maxWidth:(CGFloat)width
                             font:(UIFont *)font;

+ (CGFloat)widthForLabelWithText:(NSString *)text
                       maxHeight:(CGFloat)height
                            font:(UIFont *)font;

@end
