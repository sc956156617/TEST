//
//  ZttApp.h
//  zhitongti
//
//  Created by SC on 16/1/21.
//  Copyright (c) 2016年 SC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ZttAppProtocol <JSExport>

//  用户信息显示
- (void)showUserInfo:(NSString *)uId;

//  资讯分享接口
- (void)shareNews:(NSString *)newid :(NSString *)types :(NSString *)title :(NSString *)summary :(NSString *)picurl;
//沙龙分享
-(void)shareShalong:(NSString *)shalongid :(NSString *)type :(NSString *)title :(NSString *)summary :(NSString *)picurl;

//证书分享接口

-(void)shareCert:(NSString *)Certid :(NSString *)type :(NSString *)title  :(NSString *)picurl;
//urltiaozhuan
-(void)goToUrl:(NSString *)url :(NSString *)title;

//课程界面四接口
- (void)showProjectLib:(NSString *)uid;
- (void)showLiveLib:(NSString *)uid;
- (void)showShalongLib:(NSString *)uid;
- (void)showStudyLib:(NSString *)uid;

//沙龙详情信息。
-(void)showCourse:(NSString *)courseid :(int)type;

//荣誉榜排行界面
-(void)showHonorCoinRoll:(NSString *)uid;
-(void)showHonorInteractionRoll:(NSString *)uid;
-(void)showHonorStudyRoll:(NSString *)uid;

/**
 *  下载接口
 */
-(void)down:(NSString *)url;
/**
 *  沙龙分享
 */


/**
 *  直接显示课程界面
 */
-(void)showCourseInfo:(NSString *)courseid;

@end


@protocol GoToInfoViewControllerProtocol <NSObject>
@optional
-(void)zttDelegateWith:(NSString *)jiemian;
-(void)GoToInfoViewController:(NSString *)uId;
-(void)passCourseid:(NSString *)courseid andType:(int)type;
-(void)passWebviewControllerWithtitle:(NSString *)title and:(NSString *)url;
-(void)passWebviewControllerWithID:(NSString *)ID title:(NSString *)title pic:(NSString *)picImg summary:(NSString *)summary type:(NSString *)type;

@end



@interface ZttApp : NSObject<ZttAppProtocol>

@property (nonatomic, weak)id<GoToInfoViewControllerProtocol>delegate;

//@property (nonatomic, strong)UIWebView *webView;
@end
