//
//  SCUserInfo.h
//  汽车配件
//
//  Created by cb on 2017/3/20.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCEnterpriseInfo.h"
@interface SCUserInfo : NSObject
/*
用户信息
 */
+(SCUserInfo *)getUserModel;
+(void)setuserInfo:(SCUserInfo*)model;
+(void)clearUserInfo;
/*
//账号信息
 */
+(void)setLogin;
+(void)setLogout;

+(NSArray *)getAcountInfo;
+(void)SetUpAcountInfo:(NSString *)infoA :(NSString *)infoP;
+(void)clearAcountInfo;
/*
 企业信息
 */
+(SCEnterpriseInfo *)getEnterpriseModel;
+(void)setEnterpriseModel:(SCEnterpriseInfo *)enterpriseModel;
/*
 企业地址信息（目前和个人选择地区一致）
 */
+(NSString *)getEnterpriseCity;
+(void)setEnterpriseCity:(NSString *)city;

/**
 用户token
 */
@property(nonatomic,copy) NSString * token;
/**
  用户ID
 */
@property(nonatomic,copy) NSString * uid;
/**
用户昵称
 */
@property(nonatomic,copy) NSString * nickname;
/**
 用户手机号码
 */
@property(nonatomic,copy) NSString * phone;
/**
  用户头像地址
 */
@property(nonatomic,copy) NSString * headsmall;
/**
身份证号
 */
@property(nonatomic,copy) NSString * qr_code;

/**
 二维码
 */
@property(nonatomic,copy) NSString * code;
/**
 真实姓名
 */
@property(nonatomic,copy) NSString * name;///////////////???????????




/**
背景图片
 */
@property(nonatomic,copy) NSString * background;
/**
用户地址
 */
@property(nonatomic,copy) NSString * address;
/**
 用户性别 0 未填写 1 男 2女
 */
@property(nonatomic,copy) NSString * sex;
/**
用户地区
 */
@property(nonatomic,copy) NSString * area;
/**
用户个性签名
 */
@property(nonatomic,copy) NSString * signature;





/**
创建时间
 */
@property(nonatomic,copy) NSString * createtime;
/**
离职状态（0为在职，1为离职)
 */
@property(nonatomic,copy) NSString * user_status;
/**
企业id
 */
@property(nonatomic,copy) NSString * enterprise_id;
/**
 用户标识
户) */
@property(nonatomic,copy) NSString * type;
/**
 用户级别  （1是汽修 2是汽配 4 是个人。3 官方)
 */
@property(nonatomic,copy) NSString * user_level;
/**
 企业信息
 */
@property(nonatomic,strong)SCEnterpriseInfo *enterpriseModel;


@end
