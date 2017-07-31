//
//  SCWebViewController.h
//  封装webView
//
//  Created by SC on 2017/6/3.
//  Copyright © 2017年 SC. All rights reserved.


/**   使用方法详解**/
/*
SCWebViewController *webVC = [[SCWebViewController alloc] init];
webVC.urlString = @"http://www.baidu.com";
webVC.isWKWebView = NO;
webVC.webviewHeaderType = SCWebviewHeaderTypeRefreshHeader;
webVC.isNavHidden = YES;
webVC.isHiddenProgressView = YES;
[self.navigationController pushViewController:webVC animated:YES];

*/
typedef enum{
    SCWebviewHeaderTypeNone = 0,
    SCWebviewHeaderTypeSupportLabel = 1,
    SCWebviewHeaderTypeRefreshHeader = 2,
}SCWebviewHeaderType;


#import <UIKit/UIKit.h>

@interface SCWebViewController : UIViewController
/** 是否显示Nav */
@property (nonatomic,assign) BOOL isNavHidden;
/** 刷新请求头or显示请求头 (默认为空)*/
@property (nonatomic,assign) SCWebviewHeaderType webviewHeaderType;
/** token,如不传则不会设置请求头,和服务器对比着来 */
@property (nonatomic,copy)                          NSString *token;
/** 加载网页地址 */
@property (nonatomic,copy)                          NSString *urlString;
/** 加载HTMLString */
@property (nonatomic,copy)                          NSString *HTMLString;
/** UIWebView:NO WKWebView:YES 默认UIWebView */
@property (nonatomic,assign,getter=isWKWebView)         BOOL  isWKWebView;
/** UIWebView:NO WKWebView:YES 默认UIWebView */

@property (nonatomic,assign,getter=isWKWebView)         BOOL  isHiddenProgressView;

/**
 建议使用的初始化方法

 @param type 滑动头类型
 @param url 网络地址
 @param isWKWebView UIwebview还是SCwebview
 @param isNavHidden 是否隐藏导航栏
 @param token 是否有请求头 ，添加进入token 。
 */
-(void)initWith:(SCWebviewHeaderType)type  url:(NSString *)url isWKWebView:(BOOL)isWKWebView  isNavHidden:(BOOL)isNavHidden httpHeadertoken:(NSString *)token isHiddenProgressView:(BOOL)isHiddenProgressView;
@end
