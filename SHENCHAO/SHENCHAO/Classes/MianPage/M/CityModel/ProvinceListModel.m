//
//  ProvinceListModel.m
//  FeimaoBijia_4.0
//
//  Created by iOS Developer 3 on 15/6/30.
//  Copyright (c) 2015年 Joey. All rights reserved.
//

#import "ProvinceListModel.h"

@implementation ProvinceListModel

+ (NSDictionary *)objectClassInArray {
    
    return @{@"cityList" : [CityListModel class]};
}

@end
