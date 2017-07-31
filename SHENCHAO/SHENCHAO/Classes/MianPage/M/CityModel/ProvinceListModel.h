//
//  ProvinceListModel.h
//  FeimaoBijia_4.0
//
//  Created by iOS Developer 3 on 15/6/30.
//  Copyright (c) 2015年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CityListModel.h"

@interface ProvinceListModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *cityList;

@end
