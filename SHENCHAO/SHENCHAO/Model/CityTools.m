
//
//  CityTools.m
//  SHENCHAO
//
//  Created by cb on 2017/6/29.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "CityTools.h"

static CityTools  *_instance;
@implementation CityTools
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    CityTools *tool = object;
    NSLog(@"%@",tool.fromCity);
}
@end
