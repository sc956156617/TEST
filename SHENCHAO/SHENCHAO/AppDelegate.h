//
//  AppDelegate.h
//  SHENCHAO
//
//  Created by cb on 2017/6/8.
//  Copyright © 2017年 SC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "QPStartModel.h"   //初始化模型

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//框架
@property(strong,nonatomic) UIViewController * rootViewController;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property (strong, nonatomic) UINavigationController *mainNavigationController;

//模型
@property (nonatomic,strong) QPStartModel *startInfoEntity;
/**
 *  关闭左视图
 */
- (void)colseLeftView;
@end

