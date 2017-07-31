//
//  QPStartModel.h
//  QiPeiSource
//
//  Created by iOS Developer 1 on 15/12/28.
//  Copyright © 2015年 Laughing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocationModel;
@interface QPStartModel : NSObject

@property (nonatomic, assign) CGFloat      latitude;
@property (nonatomic, assign) CGFloat      longitude;
@property (nonatomic,copy) NSString *userAddress;

@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *searchCity;
@property (nonatomic, copy) NSString *autoUpdate;               //最新数据更新日期（车型车系））
@property (nonatomic, copy) NSString *provinceUpdate;           //最新地区更新日期

@property (nonatomic, strong) NSArray *specialList;             //(下行)精品数组
@property (nonatomic, strong) NSArray *partsList;               //(下行)配件数组
@property (nonatomic, strong) NSMutableArray *specialShowList;  //(展示)精品数组
@property (nonatomic, strong) NSMutableArray *partsShowList;    //(展示)配件数组
@property (nonatomic, strong) NSArray *autoList;               //(下行)车型车系数组
@property (nonatomic, strong) NSMutableArray *searchShowList;    //(展示)车型车系数组
@property (nonatomic, strong) NSMutableDictionary *cityDic;     //城市信息字典:   key: "海淀区"  value:35
@property (nonatomic, strong) LocationModel *locationModel;

@property (nonatomic, strong) NSMutableDictionary *brandDic;     //品牌信息字典： key: "本田" "本田雅阁" "进口本田"  value： "本田"

@end
