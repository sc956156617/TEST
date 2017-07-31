//
//  NSObject+NSArray___YCSaveModelArray.m
//  并发症（cell复用问题）demo
//
//  Created by 刘胤辰 on 16/7/13.
//  Copyright © 2016年 it.com. All rights reserved.
//

#import "NSObject+SaveModelArray.h"

@implementation NSObject (SaveModelArray)

+(NSArray *)getArraySaveName:(NSString *)saveName{
    
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:saveName];
    
    // 进行解档
    NSArray *arrayModel =  [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
    return arrayModel;
}

+(void)saveArrayData:(NSArray *)arrayModel andSaveName:(NSString *)saveName{
    
    // 获取沙盒路径
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:saveName];
    [NSKeyedArchiver archiveRootObject:arrayModel toFile:fileName];
}

@end
