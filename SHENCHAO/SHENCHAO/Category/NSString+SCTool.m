//
//  NSString+SCTool.m
//  SHENCHAO
//
//  Created by cb on 2017/6/14.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "NSString+SCTool.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (SCTool)



/** 判断字符串是否是手机号码 */
- (BOOL)isPhoneNumber {
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[156])\\d{8}$";
    NSString * CT = @"^1((33|53|8|7[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    
    if (res1 || res2 || res3 || res4 ) {
        return YES;
    } else {
        return NO;
    }
}

/** 判断字符串是否是邮箱 */
- (BOOL)isEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/** 判断字符串是否是身份证号码 */
- (BOOL)isValidateIdentityCard{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

/** 判断字符串是否为纯数字 */
- (BOOL)isPureNumandCharacters{
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

- (NSString *)sc_underlineFromCamel
{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    for (NSUInteger i = 0; i<self.length; i++) {
        unichar c = [self characterAtIndex:i];
        NSString *cString = [NSString stringWithFormat:@"%c", c];
        NSString *cStringLower = [cString lowercaseString];
        if ([cString isEqualToString:cStringLower]) {
            [string appendString:cStringLower];
        } else {
            [string appendString:@"_"];
            [string appendString:cStringLower];
        }
    }
    return string;
}

- (NSString *)sc_camelFromUnderline
{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    NSArray *cmps = [self componentsSeparatedByString:@"_"];
    for (NSUInteger i = 0; i<cmps.count; i++) {
        NSString *cmp = cmps[i];
        if (i && cmp.length) {
            [string appendString:[NSString stringWithFormat:@"%c", [cmp characterAtIndex:0]].uppercaseString];
            if (cmp.length >= 2) [string appendString:[cmp substringFromIndex:1]];
        } else {
            [string appendString:cmp];
        }
    }
    return string;
}

- (NSString *)sc_firstCharLower
{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].lowercaseString];
    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}

- (NSString *)sc_firstCharUpper
{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].uppercaseString];
    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}

- (BOOL)sc_isPureInt
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}


+(NSString *) jsonStringWithString:(NSString *) string{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}
+(NSString *) jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}
+ (NSString *)transferJsonStr:(NSString *)src
{
    if(src == nil || [src length] == 0)
    {
        return src;
    }
    NSString *des = nil;
    des = [src stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    des = [des stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    des = [des stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"\""];
    des = [des stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"\""];
    return des;
}
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}
+(NSString *) jsonStringWithObject:(id) object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }
    return value;
}

- (NSString *)stringToMD5:(NSString *)str
{
    
    //1.首先将字符串转换成UTF-8编码, 因为MD5加密是基于C语言的,所以要先把字符串转化成C语言的字符串
    const char *fooData = [str UTF8String];
    
    //2.然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //3.计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    // CC_MD5(fooData, (unsigned int)strlen(fooData), result);
    /**
     第一个参数:要加密的字符串
     第二个参数: 获取要加密字符串的长度
     第三个参数: 接收结果的数组
     */
    
    //4.创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];
    // NSMutableString *saveResult = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    //5.从result 数组中获取加密结果并放到 saveResult中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     x大写或小写，输出也会相应转成大写或小写
     */
    return saveResult;  
}
-(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
-(BOOL)isEmptyString
{
    return (self.length==0)||(self==nil);
}
- (BOOL)isEmoji {
    const unichar high = [self characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}
-(NSString*) sha1:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
- (BOOL)isIncludingEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    
    return result;
}

- (instancetype)removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring isEmoji])? @"": substring];
                          }];
    
    return buffer;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}





/*
* 转化
*/
//转化为大写；
-(NSString *)sc_zhaunhuaDaxie{
    return [self uppercaseString];
}
//转为小写
-(NSString *)sc_zhuanhuaXiaoxie{
    return [self lowercaseString];
}
//首字母大写
-(NSString *)sc_zhuanhuaShouzimudaxie{
    return [self capitalizedString];
}


/*
 *比较
 */
//比较两个字符串内容是否相同
-(BOOL)sc_bijiaoXiangtong:(NSString *)str1{
    return [self isEqualToString:str1];
}
//忽略大小写进行比较，返回较大字符串
-(NSString *)sc_bijiaoDaxie:(NSString *)str1{

    NSComparisonResult result = [self compare:str1];
  
    if (result == NSOrderedAscending) {
        return str1;
    }else if(result == NSOrderedSame){
           return self;
    }else if (result == NSOrderedDescending){
        return self;
    }else{
        return self;
    }

}
//忽略大小写进行比较，返回较大字符串
-(NSString *)sc_bijiaoXiaoxie:(NSString *)str1{
    NSComparisonResult result = [self compare:str1];
    if (result == NSOrderedAscending) {
        return self;
    }else if(result == NSOrderedSame){
        return self;
    }else if (result == NSOrderedDescending){
        return str1;
    }else{
        return self;
    }
}


/*
 *包含
 */
//判断字符串是否以指定字符串开头
-(BOOL )sc_baohao:(NSString *)str{
    return [self hasPrefix:str];
}
//判断字符串是否包含指定字符串，返回位置和长度
-(NSRange)sc_baohanWeizhi:(NSString *)str{
   return [self rangeOfString:str];
}


/*
 *截取
 */
//字符串的截取从第几位到第几位
-(NSString *)sc_jiequFrom:(NSInteger)indexF to:(NSInteger)indexT{
    return [self substringWithRange:NSMakeRange(indexF, indexT)];
}
//用指定字符串分割字符串，返回一个数组
-(NSArray *)sc_jiequWith:(NSString*)str{
 return  [self componentsSeparatedByString:str];
}



/*
 *路径
 */
//将数组中的字符串组合成一个文件路径
-(NSString *)sc_lujingArr:(NSArray *)arr{
 return [NSString pathWithComponents:arr];
}
//将一个路径分割成一个数组
-(NSArray *)sc_lujingPath:(NSString *)path{
    return [path pathComponents];
}
//路径绝对 是否以'/'开始
-( BOOL)sc_lujingJuedui:(NSString *)path{
    return [path isAbsolutePath];
}
//获取路径最后名称 ／后面的
-(NSString *)sc_lujingLast:(NSString *)path{
    return [path lastPathComponent];
}
//把路径的最后一部分删除
-(NSString *)sc_lujingShanchuLast:(NSString *)path{
    return [path stringByDeletingLastPathComponent];
}
//获取拓展名
-(NSString *)sc_lujingKuozhanming:(NSString *)path{
    return [self pathExtension];
}

//检查字符串是否以另一个字符串开头
-( BOOL)sc_lujingKaitou:(NSString *)str{
    return [self hasPrefix:str];
}

/*
 *去掉
 */

//去掉两端的空格
-(NSString *)sc_qudiaoKonggeLiangduan{
return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
//去掉多余的空格
-(NSString *)sc_qudiaoKonggeDuoyu{
    
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSArray *parts = [self componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
   return  [filteredArray componentsJoinedByString:@" "];
}
//去掉所有的空格
-(NSString *)sc_qudiaoKonggeSuoyou{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
/*
 *替换
 */
//用指定字符串替换字符串
-(NSString *)sc_tihuan:(NSString *)str1  yong:(NSString *)str2{
    return [self stringByReplacingOccurrencesOfString:str1 withString:str2];
}
@end
