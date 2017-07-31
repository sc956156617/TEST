
//  SCVerticalIndexView.h
//  SCVerticalIndexView
//
//  Created by SC on 2017/3/21.
//  Copyright © 2017年 SC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCVerticalIndexView;

@protocol SCVerticalIndexViewDelegate <NSObject>

- (void)actionSheet:(SCVerticalIndexView *)actionSheet clickButtonAtIndex:(NSInteger )buttonIndex;

@end

@interface SCVerticalIndexView : UIScrollView

// 支持代理
@property (nonatomic,weak) id <SCVerticalIndexViewDelegate> delegate;

// 支持block
@property (nonatomic,copy) void (^ClickIndex) (NSInteger index);

/**
 根据数组进行文字显示,返回index
 @param titleArr 传入显示的数组
 @param show 是否显示取消按钮
 @return return value description
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArr;

@end
