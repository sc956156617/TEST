//
//  BrandModel.h
//  QiPeiMagazine
//
//  Created by iOS Developer 3 on 16/7/11.
//  Copyright © 2016年 Laughing. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  	lid：
 thumbnail:
 detailurl:
 detailtype:0/1/2  //0:图片 1：gif  2：网页
 h5url:
 tel:
 im:
 type:  0/1/2	//0:品牌 1：精品  2：配件
 id：			//品牌id / 精品id / 配件id
 name：      //品牌名称/精品名称/配件名称
 firstletter: // A,B,C
 keyword1：
 keyword2：
 keyword3：
 keyword4：
 keyword5:

 */
@interface BrandModel : NSObject

@property (nonatomic, copy) NSString *lid;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *detailurl;
@property (nonatomic, copy) NSString *detailtype;
@property (nonatomic, copy) NSString *h5url;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *im;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *brandId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *firstletter;
@property (nonatomic, copy) NSString *keyword1;
@property (nonatomic, copy) NSString *keyword2;
@property (nonatomic, copy) NSString *keyword3;
@property (nonatomic, copy) NSString *keyword4;
@property (nonatomic, copy) NSString *keyword5;

@property (nonatomic, copy) NSString *string;
@property (nonatomic, copy) NSString *pinYin;

@end
