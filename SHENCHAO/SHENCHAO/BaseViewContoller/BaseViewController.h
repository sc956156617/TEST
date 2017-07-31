//
//  BaseViewController.h
//  TXChatDemo
//
//  Created by Cloud on 15/6/1.
//  Copyright (c) 2015年 IST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

@property (nonatomic) BOOL showBackArrow;
@end

@class ButtonItem;

typedef enum {
    TopBarButtonLeft = 1,
    TopBarButtonRight = 2,
} NavBarButton;

typedef NS_ENUM(NSInteger, NavigationBarViewType) {
    NavigationBarTitleViewType,          //文字类型
    NavigationBarLoadingViewType,        //菊花转动类型
};

@interface BaseViewController : UIViewController

@property (nonatomic, strong) CustomButton *btnLeft;
@property (nonatomic, strong) CustomButton *btnRight;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) UIImageView *customNavigationView;
@property (nonatomic, assign) NavigationBarViewType navigationBarViewType;
@property (nonatomic, assign) BOOL shouldLimitTitleLabelWidth;

@property (nonatomic,assign) BOOL isShowNetworkError;

//创建自定义导航栏
- (void)createCustomNavBar;
//创建tongyong

-(void)setCustemLeftItem;
- (void)onClickBtn:(UIButton *)sender;
- (void)showAlertViewWithMessage:(NSString *)message andButtonItems:(ButtonItem *)buttonItem, ...NS_REQUIRES_NIL_TERMINATION;
//屏蔽特定error的弹窗
- (void)showAlertViewWithError:(NSError *)error andButtonItems:(ButtonItem *)buttonItem, ...NS_REQUIRES_NIL_TERMINATION;

/**
 *  弹窗
 */
//成功弹窗
- (void)showSuccessHudWithTitle:(NSString *)title;

//失败弹窗
- (void)showFailedHudWithError:(NSError *)error;

//失败弹窗
- (void)showFailedHudWithTitle:(NSString *)title;

-(void)setCustomRightWithRoundedRect;


//徽章
-(void)setTabBarBadgeImage:(NSUInteger)tabIndex isShow:(BOOL)isShow withNewNumber:(int)newNumber
;

-(void)gotoLoginPage;

-(void)showNetwokError:(BOOL) isConnected;


@end

