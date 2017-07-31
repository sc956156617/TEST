//
//  QPStartModel.m
//  QiPeiSource
//
//  Created by iOS Developer 1 on 15/12/28.
//  Copyright © 2015年 Laughing. All rights reserved.
//

#import "QPStartModel.h"

@implementation QPStartModel

- (NSMutableDictionary *)cityDic {

    if (!_cityDic) {
        _cityDic = [[NSMutableDictionary alloc] init];
    }
    return _cityDic;
}

- (NSMutableDictionary *)brandDic {
    
    if (!_brandDic) {
        _brandDic = [[NSMutableDictionary alloc] init];
    }
    return _brandDic;
}

@end
