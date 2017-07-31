//
//  AppDelegate+RootController.h
//  Magazine
//
//  Created by cb on 2017/6/13.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "AppDelegate.h"

typedef enum{

    SCRootControllerTabar =0,   //默认从0开始   tabbar 形式
    SCRootControllerEdgeSlide=  1,  //侧滑形式
    SCRootControllerViewControlelr=2,  //普通形式
} SCRootControllerType;

//typedef NS_ENUM(NSInteger, SCRootControllerType) {
//   
//};

@interface AppDelegate (RootController)


@property(nonatomic,assign)SCRootControllerType type;

/**
 *  单接口测试使用
 */
-(void)debugRootwith:(id)VC;
/**
 *  首次启动轮播图
 */
- (void)createLoadingScrollView;
/**
 *  tabbar实例
 */
- (void)setTabbarControllerWith:(NSArray *)controllers;
/**
 *  侧滑设置实例
 */
-(void)setSliderViewControlelr;
/**
 *  window实例
 */
- (void)setAppWindowsWithTpe:(SCRootControllerType)type;
/**
 *  根视图
 */
- (void)setRootViewController;
@end
