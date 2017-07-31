//
//  CZModel.h
//  题1
//
//  Created by iOS001 on 15/12/12.
//  Copyright © 2015年 iOS001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDCellModel : NSObject<NSCoding>

//标签
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString * number;
@property (nonatomic,assign) NSUInteger tag;
//点击的状态
@property (nonatomic,assign) BOOL isClick;
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end
