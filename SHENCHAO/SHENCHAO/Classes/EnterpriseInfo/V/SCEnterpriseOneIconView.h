//
//  SCEnterpriseOneIconView.h
//  汽车配件
//
//  Created by cb on 2017/3/28.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SCEnterpriseOneIconView;

@protocol iconclickDelegete <NSObject>
@required
-(void)passIconmclick:(UIButton *)btn;

@end
@interface SCEnterpriseOneIconView : UITableViewHeaderFooterView
@property(nonatomic,weak) id <iconclickDelegete> delegegate;
@end
