//
//  SCEnterpriseInfo.h
//  汽车配件
//
//  Created by cb on 2017/4/25.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCEnterpriseInfo : NSObject
/**
 管理员ID。
 */
@property(nonatomic,copy) NSString * uid;
/**
 企业头像
 */
@property(nonatomic,copy) NSString * pic1;
/**
 公司名称
 */
@property(nonatomic,copy) NSString * companyName;
/**
 企业地址
 */
@property(nonatomic,copy) NSString * address;

/**
 企业手机号码
 */
@property(nonatomic,copy) NSString * cellPhone;

/**
区号
 */
@property(nonatomic,copy) NSString * zone;

/**
 座机
 */
@property(nonatomic,copy) NSString * tel;

/**
企业类别0汽配商  1汽修厂
 */
@property(nonatomic,assign) int type;     ///////////////     ???????????
/**
经营类别ABCD
 */
@property(nonatomic,copy) NSString * theMain;
/**
 用户地址
 */
 @property(nonatomic,assign) int zhuYing;
/**
 专营
 */
@property(nonatomic,assign) int zhuanYing;
/**
兼营1
 */
@property(nonatomic,assign) int jianYing1;
/**
兼营2
 */
@property(nonatomic,assign) int jianYing2;
/**
配件
 */
@property(nonatomic,assign) NSString * peiJian;
/**
 精品
 */
@property(nonatomic,copy) NSString * jingPin;
/**
 省市区
 */
@property(nonatomic,assign) int province;
@property(nonatomic,assign) int city;
@property(nonatomic,assign) int county;
@end
