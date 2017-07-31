//
//  CZModel.m
//  题1
//
//  Created by iOS001 on 15/12/12.
//  Copyright © 2015年 iOS001. All rights reserved.
//

#import "FDCellModel.h"

@implementation FDCellModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.number forKey:@"number"];

    [aCoder encodeBool:self.isClick forKey:@"isClick"];
//    [aCoder encodeObject:self.number forKey:@"number"];

}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.number = [aDecoder decodeObjectForKey:@"number"];
        self.isClick = [aDecoder decodeBoolForKey:@"isClick"];
//        self.number = [aDecoder decodeObjectForKey:@"number"];
    }
    return self;
}

+(instancetype)modelWithDict:(NSDictionary *)dict{
    
    FDCellModel *cellModel=[[self alloc]init];
    
    [cellModel setValuesForKeysWithDictionary:dict];
    
    return cellModel;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
