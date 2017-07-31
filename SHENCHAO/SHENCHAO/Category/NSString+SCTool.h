//
//  NSString+SCTool.h
//  SHENCHAO
//
//  Created by cb on 2017/6/14.
//  Copyright © 2017年 SC. All rights reserved.
//

#import <Foundation/Foundation.h>

//sc开头方便使用这个类 ，后面的直接拼音方便使用记忆太多的方法了。

// 该类的左右  方便找方法和记忆使用方法适合初学者


@interface NSString (SCTool)

/*
 * 表情字符
 */
-(BOOL)isEmptyString;

-(BOOL)isChinese;

- (BOOL)isEmoji;
- (BOOL)isIncludingEmoji;
-(instancetype)removedEmojiString;

/**
 是否为手机号码
 
 @return YES / NO
 */
- (BOOL)isPhoneNumber;


/**
 是否为邮箱
 
 @return YES / NO
 */
- (BOOL)isEmail;


/**
 是否是身份证号码
 
 @return YES / NO
 */
- (BOOL)isValidateIdentityCard;


/**
 判断是否都是数字(系统NSString的trimming方法)
 
 @return YES / NO
 */
- (BOOL)isPureNumandCharacters;


- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


//驼峰转下划线（loveYou -> love_you）
- (NSString *)sc_underlineFromCamel;
//下划线转驼峰（love_you -> loveYou）
- (NSString *)sc_camelFromUnderline;
//首字母变大写
- (NSString *)sc_firstCharUpper;
//首字母变小写
- (NSString *)sc_firstCharLower;
//是否纯Int
- (BOOL)sc_isPureInt;

/*
 * json相关
 */

//转化json串中的特殊字符  去除特殊乱码
+ (NSString *)transferJsonStr:(NSString *)src;

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;

+(NSString *) jsonStringWithArray:(NSArray *)array;

+(NSString *) jsonStringWithString:(NSString *) string;

+(NSString *) jsonStringWithObject:(id) object;


/*
 * md5加密  sha1加密。（再次加工扩展）
 */
-(NSString *)stringToMD5:(NSString *)str;
-(NSString*) sha1:(NSString *)str;



/*
 * 转化
 */
//转化为大写；
-(NSString *)sc_zhaunhuaDaxie;
//转为小写
-(NSString *)sc_zhuanhuaXiaoxie;
//首字母大写
-(NSString *)sc_zhuanhuaShouzimudaxie;

/*
 *比较
 */
//比较两个字符串内容是否相同
-(BOOL)sc_bijiaoXiangtong:(NSString *)str1;
//忽略大小写进行比较，返回较大字符串
-(NSString *)sc_bijiaoDaxie:(NSString *)str1;
//忽略大小写进行比较，返回较大字符串
-(NSString *)sc_bijiaoXiaoxie:(NSString *)str1;


/*
 *包含
 */
 //判断字符串是否以指定字符串开头
-(BOOL )sc_baohao:(NSString *)str;
//判断字符串是否包含指定字符串，返回位置和长度
-(NSRange)sc_baohanWeizhi:(NSString *)str;


/*
 *截取
 */
//字符串的截取从第几位到第几位
-(NSString *)sc_jiequFrom:(NSInteger)indexF to:(NSInteger)indexT;
//用指定字符串分割字符串，返回一个数组
-(NSString *)sc_jiequWith:(NSString*)str;



/*
 *路径
 */
//将数组中的字符串组合成一个文件路径
-(NSString *)sc_lujingArr:(NSArray *)arr;
    //将一个路径分割成一个数组
-(NSArray *)sc_lujingPath:(NSString *)path;
    //获取路径最后名称 ／后面的
-(NSString *)sc_lujingLast:(NSString *)path;
    //把路径的最后一部分删除
-(NSString *)sc_lujingShanchuLast:(NSString *)path;
    //获取拓展名
-(NSString *)sc_lujingKuozhanming:(NSString *)path;

//检查字符串是否以另一个字符串开头
-(BOOL )sc_lujingKaitou:(NSString *)path;

/*
 *去掉
 */

//去掉两端的空格
-(NSString *)sc_qudiaoKonggeLiangduan;
//去掉多余的空格
-(NSString *)sc_qudiaoKonggeDuoyu;
//去掉所有的空格
-(NSString *)sc_qudiaoKonggeSuoyou;
/*
 *替换
 */
//用指定字符串替换字符串
-(NSString *)sc_tihuan:(NSString *)str1  yong:(NSString *)str2;
@end
