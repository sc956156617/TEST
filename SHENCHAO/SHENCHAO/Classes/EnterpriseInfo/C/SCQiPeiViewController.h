//
//  SCQiPeiViewController.h
//  汽车配件
//
//  Created by cb on 2017/3/29.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    //以下是枚举成员
    EngageInOneBrand = 0,
    EngageInManyBrand,
    EngageInPart,
    EngageInQuality
}EngageIn;//枚举名称

@interface SCQiPeiViewController : UIViewController
//经营种类
@property(nonatomic,assign)EngageIn engageIn;
//主营
@property(nonatomic,copy)NSString *mainCar;
//兼营
@property(nonatomic,copy)NSString *invlveCar;
//专营
@property(nonatomic,copy)NSString *justCar;
@end
