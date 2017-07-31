//
//  SCWorkingInfoTableViewCell.h
//  汽车配件
//
//  Created by cb on 2017/3/31.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCWorkerModel.h"
@interface SCWorkingInfoTableViewCell : UITableViewCell
@property(nonatomic,strong) SCWorkerModel *model;


@property(nonatomic,strong) UIImageView *iconV;
@property(nonatomic,strong) UILabel *nameL;
@property(nonatomic,strong) UILabel *typeL;



@end
