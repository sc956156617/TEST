//
//  PeiJianListViewController.h
//  汽车配件
//
//  Created by cb on 2017/4/20.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CallBackBlock)(NSArray *arrString);

@interface PeiJianListViewController : UIViewController
@property(nonatomic,copy)CallBackBlock callBackBlok;
-(void)cellback:(CallBackBlock)callBackBlok;
@end
