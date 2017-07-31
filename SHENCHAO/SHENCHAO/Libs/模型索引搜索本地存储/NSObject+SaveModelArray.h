//
//  NSObject+NSArray___YCSaveModelArray.h
//  并发症（cell复用问题）demo
//
//  Created by 刘胤辰 on 16/7/13.
//  Copyright © 2016年 it.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface NSObject (SaveModelArray)

+(NSArray *)getArraySaveName:(NSString *)saveName;

+(void)saveArrayData:(NSArray *)arrayModel andSaveName:(NSString *)saveName;
@end
