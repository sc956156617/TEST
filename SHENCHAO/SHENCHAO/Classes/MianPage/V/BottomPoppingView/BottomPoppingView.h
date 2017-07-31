//
//  BottomPoppingView.h
//  SnailPopupControllerDemo
//
//  Created by zhanghao on 2016/12/27.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BottomPoppingLabel.h"
#define ROW_COUNT 4 // 每行显示4个
//#define ROWS COUNT／ROW_COUNT > 4 ？ 4 : COUNT／ROW_COUNT     // 每页显示2行
//#define PAGES   COUNT／ROW_COUNT > 4 ? 2 : 1 // 共2页



@interface BottomPoppingView : UIView

@property (nonatomic,assign) NSInteger  COUNT; //总的个数
@property (nonatomic,assign) NSInteger  ROWS; //每页显示2行
@property (nonatomic,assign) NSInteger  PAGES; //共2页

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, strong) NSArray<LableModel *> *models;
@property (nonatomic, strong, readonly) NSMutableArray<BottomPoppingLabel *> *items;

@property (nonatomic, copy) void (^didClickFullView)(BottomPoppingView *fullView);
@property (nonatomic, copy) void (^didClickItems)(BottomPoppingView *fullView, NSInteger index);

- (void)endAnimationsCompletion:(void (^)(BottomPoppingView *fullView))completion; // 动画结束后执行block
- (instancetype)initWithFrame:(CGRect)frame withItemCount:(NSInteger)count;
@end
