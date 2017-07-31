//
//  BandsModel.h
//  汽车配件
//
//  Created by cb on 2017/4/27.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BandsModel : NSObject
@property(nonatomic,copy) NSString * ID;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * level;
@property(nonatomic,assign) BOOL  isSelsect;
@end
