//
//  BandsFrameModel.h
//  汽车配件
//
//  Created by cb on 2017/5/5.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BandsModel.h"

@interface BandsFrameModel : NSObject

@property(nonatomic,strong) BandsModel * mainModel;
@property(nonatomic,strong) NSArray * childModels;
/*是否展开*/
@property(nonatomic,assign) BOOL  isFold;
@end
