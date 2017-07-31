//
//  MyScanView.h
//  SHENCHAO
//
//  Created by cb on 2017/7/6.
//  Copyright © 2017年 SC. All rights reserved.
//

#import <Foundation/Foundation.h>

//点击屏幕返回代理
@class MyScanView;
@protocol MyScanViewDelegate <NSObject>
- (void)didTipBackgroud;
@end
@interface MyScanView : UIView
@property (nonatomic,weak) id <MyScanViewDelegate> delegate;


@end
