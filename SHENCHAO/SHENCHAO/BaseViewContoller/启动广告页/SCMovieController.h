//
//  SCMovieController.h
//  StartMovie
//
//  Created by SC on 17/3/29.
//  Copyright © 2017年 SHENCHAO. All rights reserved.
//


//可用于。第一次安装启动界面。亦可用于每次进入的启动图片。
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , SCMovieStyle) {
    SCMovieStyleDefault    = 0,  //图片启动
    SCMovieStyleMovie     ,       //视频启动
    SCMovieStyleGIF      ,    //gif启动
    SCMovieStyleImage       ,  //图片启动
    SCMovieStyleH5            ,  //h5启动

};

@interface SCMovieController : UIViewController


/**
 默认播放
 @param style 播放方式  默认播放源 使用的时候尝试
 */
-(void)initWith:(SCMovieStyle)style;
/**
 推荐使用
 @param style 播放方式  默认播放源 尝试使用
 */
-(void)initWith:(SCMovieStyle)style with:(NSURL*)URL;

-(void)initStyleMovie:(NSURL *)MovieURL;
-(void)initStyleGIF:(NSURL *)GIFURL;
-(void)initStyleImage:(NSURL *)ImageURL;
-(void)initStyleH5:(NSURL *)H5URL;


/**
 倒计时跳过按钮是否隐藏
 */
@property(nonatomic,assign)BOOL TimeLableIsHidden;
/**
 进入应用按钮是否隐藏
 */
@property(nonatomic,assign)BOOL   ActionIsHidden;
/**
 倒计时时间  默认20s
 */
@property(nonatomic,assign)NSInteger CountDownTime;

@end
