//
//  LocationModel.h
//  FeimaoBijia_4.0
//
//  Created by iOS Developer 3 on 15/6/30.
//  Copyright (c) 2015年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LocRecContentModel.h"

@interface LocationModel : NSObject

@property (nonatomic, strong) NSNumber *resCode;
@property (nonatomic, strong) LocRecContentModel *resContent;

@end
