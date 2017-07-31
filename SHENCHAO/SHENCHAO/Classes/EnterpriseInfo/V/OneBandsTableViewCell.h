//
//  OneBandsTableViewCell.h
//  汽车配件
//
//  Created by cb on 2017/5/5.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BandsFrameModel.h"
#import "BandsModel.h"


@protocol OneBandsTableViewCellDelegate <NSObject>

-(void)OneBandsClick:(NSString *)ID;
@end

@interface OneBandsTableViewCell : UITableViewCell

@property(nonatomic,weak) id<OneBandsTableViewCellDelegate>delegate;
@property (nonatomic,strong) BandsFrameModel *model;
@property(nonatomic,strong)UILabel *messageLabel;


@end
