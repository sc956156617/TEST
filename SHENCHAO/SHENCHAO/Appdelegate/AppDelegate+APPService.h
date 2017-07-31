//
//  AppDelegate+APPService.h
//  Magazine
//
//  Created by cb on 2017/6/13.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (APPService)
/**
 * 直接走get方法获取UUID 钥匙链
 */
@property(nonatomic,strong)NSString *UUID;
/**
 *  设置系统权限管理
 */
-(void)setUpAuthorityManager;

/**
 *  设置换肤功能
 */
-(void)setChangSkinTheme;
/**
 *  进入图片浏览器
 */
- (void)phontoBroserPush:(NSNotification *)note;

/**
 *  bug日志反馈
 */
- (void)registerBugly;

/**
 *  基本配置
 */
- (void)configurationLaunchUserOption;

/**
 *  Mob注册
 */

- (void)registerMob;

/**
 *  检查更新
 */
- (void)checkAppUpDataWithshowOption:(BOOL)showOption;

/**
 *  上传用户设备信息
 */
- (void)upLoadMessageAboutUser;

/**
 *  检查黑名单用户
 */
-(void)checkBlack;


@end
