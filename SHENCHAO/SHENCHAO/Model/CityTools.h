//
//  CityTools.h
//  SHENCHAO
//
//  Created by cb on 2017/6/29.
//  Copyright © 2017年 SC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CityTools : NSObject
+ (instancetype)share;
@property(nonatomic,copy) NSString *fromCity;
@property(nonatomic,copy) NSString *toCity;
@end
