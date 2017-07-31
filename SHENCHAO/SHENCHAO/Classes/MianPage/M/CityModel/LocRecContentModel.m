//
//  LocRecContentModel.m
//  FeimaoBijia_4.0
//
//  Created by iOS Developer 3 on 15/6/30.
//  Copyright (c) 2015年 Joey. All rights reserved.
//

#import "LocRecContentModel.h"

@implementation LocRecContentModel

+ (NSDictionary *)objectClassInArray {
    
    return @{
             @"hotcityList" : [HotCityListModel class],
             @"provinceList" : [ProvinceListModel class],
             };
}

@end
