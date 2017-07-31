//
//  OneBandsViewController.h
//  汽车配件
//
//  Created by cb on 2017/4/27.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BandsModel.h"

typedef void(^PassBack)(BandsModel *model);

@interface ZhuyingBandsViewController : UIViewController
@property(nonatomic,copy)PassBack callBackBlok;
-(void)cellback:(PassBack)callBackBlok;
@end
