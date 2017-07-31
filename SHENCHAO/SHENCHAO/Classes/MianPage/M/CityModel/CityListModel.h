//
//  CityListModel.h
//  FeimaoBijia_4.0
//
//  Created by iOS Developer 3 on 15/6/30.
//  Copyright (c) 2015年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 {“city”:“哈尔滨”,
 “cityId”:  37 ,
 }，
 
 */

@interface CityListModel : NSObject

@property (nonatomic, copy) NSString *city;
@property (nonatomic, strong) NSNumber *cityId;

@end
