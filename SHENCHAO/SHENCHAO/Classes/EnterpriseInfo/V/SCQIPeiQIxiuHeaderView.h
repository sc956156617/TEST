//
//  SCQIPeiQIxiuHeaderView.h
//  汽车配件
//
//  Created by cb on 2017/3/29.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol iconclickDelegete <NSObject>
@required
-(void)passIconmclick:(UIButton *)btn;
-(void)IDcardClick:(UIButton *)btn;

@end
@interface SCQIPeiQIxiuHeaderView : UITableViewHeaderFooterView
@property(nonatomic,weak) id <iconclickDelegete> delegegate;

@end
