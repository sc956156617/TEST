//
//  SCUserInfo.m
//  汽车配件
//
//  Created by cb on 2017/3/20.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCUserInfo.h"

@implementation SCUserInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"uid":@"id",
             @"background":@"backgUrl",
             @"signature":@"autograph",
             @"headsmall":@"headUrl",
             @"nickname" : @"userName",
             @"area": @"cityId",
             @"qr_code": @"identity"
             };  //从这里可以看出，model中的Mydog对应我们数据源中的dog，Smallbird对应bird.twoBird
}


+(void)setLogin{
    [SCUserDefaults  setBool:YES forKey:@ISLOGIN];
}
+(void)setLogout{
    [SCUserDefaults  setBool:NO forKey:@ISLOGIN];
}

+(void)setuserInfo:(SCUserInfo *)model{
    
//   model.phone = checkIsNULL(model.phone);

    if (!kStringIsEmpty(model.phone)) {
        [SCUserDefaults setObject:model.phone forKey:@USERPHONE];
 
    }
    if (!kStringIsEmpty(model.uid)) {
        [SCUserDefaults setObject:model.uid forKey:@USERID];
    }

    if (!kStringIsEmpty(model.nickname)) {
        [SCUserDefaults setObject:model.nickname forKey:@USERNICKNAME];
      
    }
    if (!kStringIsEmpty(model.type)) {
        [SCUserDefaults setObject:model.type forKey:@USERPTYPE];
          }
    if (!kStringIsEmpty(model.qr_code)) {
        [SCUserDefaults setObject:model.qr_code forKey:@USERQRCODE];
    }
    if (!kStringIsEmpty(model.name)) {
        [SCUserDefaults setObject:model.name forKey:@USERNAME];
        
    }
    if (!kStringIsEmpty(model.address)) {
        [SCUserDefaults setObject:model.address forKey:@USERADDRESS];
            }
    if (!kStringIsEmpty(model.background)) {
        [SCUserDefaults setObject:model.background forKey:@USERBACKGROUND];
    }

    if (!kStringIsEmpty(model.headsmall)) {
        [SCUserDefaults setObject:model.headsmall forKey:@USERHEADSMAALL];
    }
    
    
    if (!kStringIsEmpty(model.sex)) {
        [SCUserDefaults setObject:model.sex forKey:@USERSEX];
       

    }
    if (!kStringIsEmpty(model.area)) {
        [SCUserDefaults setObject:model.area forKey:@USERAREA];
       
    }
    if (!kStringIsEmpty(model.signature)) {
        [SCUserDefaults setObject:model.signature forKey:@USERSIGNATURE];
       
    }
    if (!kStringIsEmpty(model.createtime)) {
        [SCUserDefaults setObject:model.createtime forKey:@USERCREATETIME];
       
    }  if (!kStringIsEmpty(model.user_status)) {
        [SCUserDefaults setObject:model.user_status forKey:@USERSTATUS];
       
    }  if (!kStringIsEmpty(model.user_level)) {
        [SCUserDefaults setObject:model.user_level forKey:@USERLEVEL];
    }  if (!kStringIsEmpty(model.enterprise_id)) {
        [SCUserDefaults setObject:model.enterprise_id forKey:@USERENTERPRISEID];
    }  if (!kStringIsEmpty(model.code)) {
        [SCUserDefaults setObject:model.code forKey:@USERCODE];
    }
        [SCUserDefaults synchronize];
}
+(SCUserInfo *)getUserModel{

    SCUserInfo * model = [SCUserInfo new];
    model.token =   [SCUserDefaults objectForKey:@USERTOKEN];
    model.phone =   [SCUserDefaults objectForKey:@USERPHONE];
    model.uid =  [SCUserDefaults objectForKey:@USERID];
    model.nickname =   [SCUserDefaults objectForKey:@USERNICKNAME];
    
   model.type =   [SCUserDefaults objectForKey:@USERPTYPE];
   model.qr_code =   [SCUserDefaults objectForKey:@USERQRCODE];
   model.code =   [SCUserDefaults objectForKey:@USERCODE];

   model.name =    [SCUserDefaults objectForKey:@USERNAME];
   model.address =  [SCUserDefaults objectForKey:@USERADDRESS];
   model.background =  [SCUserDefaults objectForKey:@USERBACKGROUND];
    
   model.headsmall =   [SCUserDefaults objectForKey:@USERHEADSMAALL];
    
   model.sex =    [SCUserDefaults objectForKey:@USERSEX];
   model.area =   [SCUserDefaults objectForKey:@USERAREA];
   model.signature =   [SCUserDefaults objectForKey:@USERSIGNATURE];
   model.createtime =    [SCUserDefaults objectForKey:@USERCREATETIME];
    
    
   model.user_status =    [SCUserDefaults objectForKey:@USERSTATUS];
   model.user_level =   [SCUserDefaults objectForKey:@USERLEVEL];
   model.enterprise_id =    [SCUserDefaults objectForKey:@USERENTERPRISEID];
    return  model;
}

+(void)clearUserInfo{
    [SCUserDefaults  removeObjectForKey:@ISLOGIN];
    [SCUserDefaults removeObjectForKey:@USERTOKEN];
    [SCUserDefaults removeObjectForKey:@USERPHONE];
    [SCUserDefaults removeObjectForKey:@USERID];
    [SCUserDefaults removeObjectForKey:@USERNICKNAME];
    
    [SCUserDefaults removeObjectForKey:@USERPTYPE];
    [SCUserDefaults removeObjectForKey:@USERQRCODE];
    [SCUserDefaults removeObjectForKey:@USERNAME];
    [SCUserDefaults removeObjectForKey:@USERADDRESS];
    [SCUserDefaults removeObjectForKey:@USERBACKGROUND];
    
    [SCUserDefaults removeObjectForKey:@USERHEADSMAALL];
    [SCUserDefaults removeObjectForKey:@USERSEX];
    [SCUserDefaults removeObjectForKey:@USERAREA];
    [SCUserDefaults removeObjectForKey:@USERSIGNATURE];
    [SCUserDefaults removeObjectForKey:@USERCREATETIME];
    
    
    [SCUserDefaults removeObjectForKey:@USERSTATUS];
    [SCUserDefaults removeObjectForKey:@USERLEVEL];
    [SCUserDefaults removeObjectForKey:@USERENTERPRISEID];
}


+(NSString *)getEnterpriseCity{
    return [SCUserDefaults objectForKey:@ENTERPRISECITY];
}

+(void)setEnterpriseCity:(NSString *)city{
    [SCUserDefaults setObject:city forKey:@ENTERPRISECITY];
}

+(void)setEnterpriseModel:(SCEnterpriseInfo *)enterpriseModel{
    [SCUserDefaults setObject:enterpriseModel forKey:@USERENTERPRISE];
    [SCUserDefaults synchronize];
}
+(SCEnterpriseInfo *)getEnterpriseModel{
    return [SCUserDefaults objectForKey:@USERENTERPRISE];
}
+(void)SetUpAcountInfo:(NSString *)infoA :(NSString *)infoP{
    [SCUserDefaults setObject:infoA forKey:@USEREACCOUNT];
    [SCUserDefaults setObject:infoP forKey:@USEREPASSWORLD];
    [SCUserDefaults synchronize];
}
+(void)clearAcountInfo{
    [SCUserDefaults removeObjectForKey:@USEREACCOUNT];
    [SCUserDefaults removeObjectForKey:@USEREPASSWORLD];
}
+(NSArray *)getAcountInfo{
    
    NSString * infoA =  [SCUserDefaults objectForKey:@USEREACCOUNT] ?[SCUserDefaults objectForKey:@USEREACCOUNT] :@"";
    NSString * InfoP =[SCUserDefaults objectForKey:@USEREPASSWORLD] ? [SCUserDefaults objectForKey:@USEREPASSWORLD] :@"";
    return @[infoA,InfoP];
}

-(void)clear{
   
}
@end
