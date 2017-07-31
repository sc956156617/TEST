//
//  CollectionCell.h
//  SHENCHAO
//
//  Created by cb on 2017/6/29.
//  Copyright © 2017年 SC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"
//滑动代理
@class CollectionCell;
@protocol  SlideDeleteCellDelegate<NSObject>
-(void)slideToDeleteCell:(CollectionCell *)slideDeleteCell;
@end

typedef void  (^collection) (NSString *IM);
@interface CollectionCell : UITableViewCell<UIGestureRecognizerDelegate>
//滑动删除
@property(assign, nonatomic)id<SlideDeleteCellDelegate>delegate;

//点击传递
@property(nonatomic,assign) collection IMclick;
@property(nonatomic,retain) CollectionModel* Model;

- (void)updateWithApp:(CollectionModel *)app ;
@end
