//
//  LocationModel.m
//  FeimaoBijia_4.0
//
//  Created by iOS Developer 3 on 15/6/30.
//  Copyright (c) 2015年 Joey. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel

+ (NSDictionary *)objectClassInArray {
    
    return @{@"resContent" : [LocRecContentModel class]};
}

@end
