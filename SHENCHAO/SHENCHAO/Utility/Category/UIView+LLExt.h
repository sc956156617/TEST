//
//  UIView+LLExt.h
//  LLWeChat
//
//  Created by GYJZH on 7/31/16.
//  Copyright © 2016 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>
#define vAlertTag    10086

@interface UIView (LLExt)

@property (nonatomic) CGFloat left_LL;
@property (nonatomic) CGFloat top_LL;
@property (nonatomic) CGFloat right_LL;
@property (nonatomic) CGFloat bottom_LL;
@property (nonatomic) CGFloat width_LL;
@property (nonatomic) CGFloat height_LL;
@property (nonatomic) CGFloat centerX_LL;
@property (nonatomic) CGFloat centerY_LL;
@property (nonatomic) CGPoint origin_LL;
@property (nonatomic) CGSize  size_LL;

@property (nonatomic, getter=isVisible) BOOL visible;

- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action;

- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action target:(id)target;

- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action duration:(CGFloat)duration;

- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action target:(id)target duration:(CGFloat)duration;

- (void)showActionSuccessDialog:(NSString *)title;

- (void)showTextDialog:(NSString *)text;

/**
 * @brief 移除此view上的所有子视图
 */
- (void)removeAllSubviews;

/**
 @brief 弹窗
 @param title 弹窗标题
 message 弹窗信息
 */
+ (void) showAlertView: (NSString*) title andMessage: (NSString *) message;

/**
 *  弹窗
 *
 *  @param title    弹窗标题
 *  @param message  弹窗信息
 *  @param delegate 弹窗代理
 */
+ (void) showAlertView: (NSString*) title
            andMessage: (NSString *) message
          withDelegate: (UIViewController<UIAlertViewDelegate> *) delegate;
@end
