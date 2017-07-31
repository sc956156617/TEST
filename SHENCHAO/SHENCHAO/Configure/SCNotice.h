//
//  HHNotice.h
//  HomeHome
//
//  Created by Victor on 16/1/5.
//  Copyright © 2016年 Victor. All rights reserved.
//

#ifndef HHNotice_h
#define HHNotice_h


//UUID_KEY
#define KEY_IN_KEYCHAIN_UUID  @"唯一识别的KEY_UUID"
#define KEY_UUID  @"唯一识别的key_uuid"
#define FIRST_LOGIN  @"第一次登陆识别FIRST_LOGIN"

#define kAnimationType @"animationType"


#define kNotificationChangeType             @"kNotificationChangeType"
#define kNotificationLocation               @"kNotificationLocation"                //开始定位
#define kHiddenIndexDetailViewNotification  @"kHiddenIndexDetailViewNotification"
#define kSearchCarNameNotification          @"kSearchCarNameNotification"
#define kCloseLeftViewNotification          @"kCloseLeftViewNotification"
#define kChangeCityNotification             @"kChangeCityNotification"
#define kStartRequestNotification           @"kStartRequestNotification"

#define USERDEPENDS  "user_UUID"
#define USESYSTEM   "user_system"
#define USERVERSION   "user_version"


#define USERHEADSMAALL   "headsmall"

#define USERQRCODE "qr_code"
#define USERCODE "code"

#define USERNAME "name"///////////////???????????
#define USERBACKGROUND "background"
#define USERADDRESS "address"
#define USERSEX "sex"
#define USERAREA "area"
#define USERSIGNATURE "signature"
#define USERCREATETIME "createtime"
#define USERSTATUS "user_status"
#define USERENTERPRISEID "enterprise_id"
#define USERLEVEL "user_level"
#define USERTOKEN "user_token"
#define USERPHONE "user_phone"
#define USERID "user_id"
#define USERNICKNAME "user_nickname"
#define ISLOGIN "is_login"
#define USERPHONE "user_phone"
#define USERPTYPE "user_type"
#define ENTERPRISECITY "EnterpriseCity"

/*
 保存用户信息
 */
#define USERINFO "user_info"
/*
 保存企业信息
 */
#define USERENTERPRISE "user_enteprise"


#define ADDFRIEND "add_friend"

#define USEREPASSWORLD "user_passworld"
#define USEREACCOUNT "user_account"

#define SCUserDefaults   [NSUserDefaults standardUserDefaults]


#define REGISTERLOGIN "registerint"

#define kErrorMessageKey                           @"msg"
#define TX_CLIENT_COUNT_FEED_COMMENT                  @"comment"
#define TX_CLIENT_COUNT_FEED                          @"feed"
#define TX_NOTIFICATION_COUNTER_REFRESHED             @"tx.notification.counter.refreshed"


#define TX_NOTIFICATION_NOT_REACHABLE            @"tx.notification.NotReachable"

#define TX_NOTIFICATION_REACHABLE            @"tx.notification.Reachable"

#define TX_NOTIFICATION_EXIT_MESSAGE             @"tx.notification.user.exit"

#define TX_NOTIFICATION_LOGIN_MESSAGE             @"tx.notification.user.login"

#define TX_CLIENT_UNREAD_COUNTER             @"feedUnreadCount"

//1.AFNetWorking-->3.0;
//2.SDWebImage-->3.7;
//3.提示框参考"HHPointHUD.h";
//4.字典模型转换使用"MJExtion";
//5.刷新使用"MJRefresh";
//6.用户本地信息存储于"HHUserInfo.h";
//7.actionSheet调用:
//    HyActionSheet *action = [[HyActionSheet alloc] initWithCancelStr:@"取消" otherButtonTitles:@[@"收藏",@"分享"] AttachTitle:@"收藏后可以在个人中心随时查到该条问题 \n 回答的不错,快分享给朋友吧"];
//    [action ChangeTitleColor:[UIColor redColor] AndIndex:1];
//
//    [action ButtonIndex:^(NSInteger Buttonindex) {
//        
//        }];
//8.登录按钮:"HyLoglnButton
    //UIViewController *controller = [SecondViewController new];
    //UINavigationController *nai = [[UINavigationController alloc] initWithRootViewController:controller];
    //nai.transitioningDelegate = self;
    //[self presentViewController:nai animated:YES completion:nil];

    //- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
    //presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
    //{
    //
    //    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isBOOL:true];
    //}
    //
    //- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //
    //    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isBOOL:false];
    //}
//9.


#endif
