//
//  SCWorkerManageViewController.h
//  汽车配件
//
//  Created by cb on 2017/3/31.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PassBlock)(NSString *name ,NSString *phone);
@interface SCWorkerManageViewController : UIViewController
@property (nonatomic, copy) PassBlock passBlock;
@end
