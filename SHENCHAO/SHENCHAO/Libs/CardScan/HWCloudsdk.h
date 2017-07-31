//
//  HWCloudsdk.h
//  wssdk_noframe
//
//  Created by mhz on 14-8-5.
//  Copyright (c) 2014年 com.hanvon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
// 回调block
typedef void (^successBlock)(id responseObject);
typedef void (^failureBlock)(NSError *error);
@interface HWCloudsdk : NSObject

#pragma mark 文本商务版类别枚举
typedef NS_ENUM(NSInteger, TABLE_LANGUAGE_TYPE) {
    TABLE_LANGUAGE_TYPE_table_text,             //文本商务版(纯文本)
    TABLE_LANGUAGE_TYPE_table_json,             //文本商务版(json)
    TABLE_LANGUAGE_TYPE_table_enhancedjs,       //文本商务版(加强版json)
    
};

#pragma mark 人脸动作指令(人脸活体验证)
typedef NS_ENUM(NSInteger, FACEINSTRUCTION) {
    FACEINSTRUCTION_faceToFront = 0,             //头部居中朝正前方
    FACEINSTRUCTION_turnLeft,                    //向左转动
    FACEINSTRUCTION_turnRight,                   //向右转动
    FACEINSTRUCTION_turnUp,                      //向上转动
    FACEINSTRUCTION_turnDown,                    //向下转动
    FACEINSTRUCTION_openMouth,                   //张嘴
    FACEINSTRUCTION_closeMouth,                  //闭嘴
    FACEINSTRUCTION_openEyes,                    //睁眼
    FACEINSTRUCTION_closeEyes,                   //闭眼
    FACEINSTRUCTION_judgeLight = 11,             //判断光线
    
};

#pragma mark 使用https请求
/**
 * 使用https请求，默认http
 */
- (void)useHttpsRequest;

#pragma mark 使用http请求
/**
 * 使用http请求，默认http
 */
- (void)useHttpRequest;

#pragma mark  名片识别

/**
 *  传入图片识别名片
 *
 *  @param language         语言类型 chns 简体 chnt繁体 en英文 auto 多语言
 *  @param cardImage        图片
 *  @param cardImageData    图片二进制
 *  @param cardImage        图片路径
 *  @param apiKey           apikey
 *
 *  @return result
 */
-(NSString *)cardLanguage:(NSString *)language
                cardImage:(UIImage *) cardImage
                   apiKey:(NSString *)apiKey;

-(NSString *)cardLanguage:(NSString *)language
            cardImageData:(NSData *) cardImageData
                   apiKey:(NSString *)apiKey;

-(NSString *)cardLanguage:(NSString *)language
            cardImagePath:(NSString *) cardImagePath
                   apiKey:(NSString *)apiKey;


/**
 *  传入图片识别名片
 *
 *  @param language         语言类型 chns 简体 chnt繁体 en英文
 *  @param cardImage        图片
 *  @param cardImageData    图片二进制
 *  @param cardImage        图片路径
 *  @param apiKey           apikey
 *  @param successBlock     成功回调
 *  @param failureBlock     失败回调
 *
 */


-(void )cardLanguage:(NSString *)language
           cardImage:(UIImage *) cardImage
              apiKey:(NSString *)apiKey
        successBlock:(successBlock)successBlock
        failureBlock:(failureBlock)failureBlock;

-(void )cardLanguage:(NSString *)language
       cardImageData:(NSData *) cardImageData
              apiKey:(NSString *)apiKey
        successBlock:(successBlock)successBlock
        failureBlock:(failureBlock)failureBlock;


-(void )cardLanguage:(NSString *)language
       cardImagePath:(NSString *) cardImagePath
              apiKey:(NSString *)apiKey
        successBlock:(successBlock)successBlock
        failureBlock:(failureBlock)failureBlock;

#pragma mark  文本识别

/**
 *  传入文本图片识别
 *
 *  @param language         语言类型 chns 简体 chnt繁体 en英文
 *  @param textImage        文本图片
 *  @param textImageData    文本图片二进制
 *  @param textImagePath    文本图片路径
 *  @param apiKey           apikey
 *
 *  @return result
 */
-(NSString *) lang:(NSString *) language
         textImage:(UIImage *) textImage
            apiKey:(NSString *) apiKey;

-(NSString *) lang:(NSString *) language
     textImageData:(NSData *) textImageData
            apiKey:(NSString *) apiKey;

-(NSString *) lang:(NSString *) language
     textImagePath:(NSString *) textImagePath
            apiKey:(NSString *) apiKey;


/**
 *  传入文本图片识别
 *
 *  @param language         语言类型 chns 简体 chnt繁体 en英文
 *  @param textImage        文本图片
 *  @param textImageData    文本图片二进制
 *  @param textImagePath    文本图片路径
 *  @param apiKey           apikey
 *  @param successBlock     成功回调
 *  @param failureBlock     失败回调
 *
 */
-(void ) lang:(NSString *) language
    textImage:(UIImage *) textImage
       apiKey:(NSString *) apiKey
 successBlock:(successBlock)successBlock
 failureBlock:(failureBlock)failureBlock;

-(void ) lang:(NSString *) language
textImageData:(NSData *) textImageData
       apiKey:(NSString *) apiKey
 successBlock:(successBlock)successBlock
 failureBlock:(failureBlock)failureBlock;

-(void ) lang:(NSString *) language
textImagePath:(NSString *) textImagePath
       apiKey:(NSString *) apiKey
 successBlock:(successBlock)successBlock
 failureBlock:(failureBlock)failureBlock;



#pragma mark  单字手写识别

/**
 *  单字手写识别
 *
 *  @param type         1:手写轨迹识别 2:获取单字的联想字
 *  @param language     语言类型 chns 简体 chnt繁体 en英文
 *  @param data         当 type==1 时:单字手写数据。
 *  @param apiKey       apikey
 */

- (NSString *) type:(NSString *) type
               lang:(NSString *) language
     handSingleData:(NSString *) data
             apiKey:(NSString *) apiKey;

/**
 *  单字手写识别
 *
 *  @param type             1:手写轨迹识别 2:获取单字的联想字
 *  @param language         语言类型 chns 简体 chnt繁体 en英文
 *  @param data             当 type==1 时:单字手写数据。
 *  @param apiKey           apikey
 *  @param successBlock     成功回调
 *  @param failureBlock     失败回调
 */
- (void ) type:(NSString *) type
          lang:(NSString *) language
handSingleData:(NSString *) data
        apiKey:(NSString *) apiKey
  successBlock:(successBlock)successBlock
  failureBlock:(failureBlock)failureBlock;



#pragma mark 行手写识别

/**
 *  行手写识别
 *
 *  @param language     语言类型 chns 简体 chnt繁体 en英文
 *  @param data         当 type==1 时:单字手写数据。
 *  @param apiKey       apikey
 *
 */

- (NSString *) lang:(NSString *) language
       handLineData:(NSString *) data
             apiKey:(NSString *) apiKey;

/**
 *  行手写识别
 *
 *  @param language         语言类型 chns 简体 chnt繁体 en英文
 *  @param data             当 type==1 时:单字手写数据。
 *  @param apiKey           apikey
 *  @param successBlock     成功回调
 *  @param failureBlock     失败回调
 *
 */
- (void ) lang:(NSString *) language
  handLineData:(NSString *) data
        apiKey:(NSString *) apiKey
  successBlock:(successBlock)successBlock
  failureBlock:(failureBlock)failureBlock;



#pragma mark 叠写识别
/**
 *  叠写识别
 *
 *  @param language      语言类型 chns 简体 chnt繁体 en英文
 *  @param data          行手写数据
 *  @param apiKey        服务授权 Key(iOS Key)
 *
 *  @return result
 */

- (NSString *) lang:(NSString *) language
     handRepeatData:(NSString *) data
             apiKey:(NSString *) apiKey;

/**
 *  叠写识别
 *
 *  @param language         语言类型 chns 简体 chnt繁体 en英文
 *  @param data             行手写数据
 *  @param apiKey           服务授权 Key(iOS Key)
 *  @param successBlock     成功回调
 *  @param failureBlock     失败回调
 *
 */

- (void) lang:(NSString *) language
handRepeatData:(NSString *) data
       apiKey:(NSString *) apiKey
 successBlock:(successBlock)successBlock
 failureBlock:(failureBlock)failureBlock;

#pragma mark 身份证识别

/**
 *  传入身份证图片识别
 *
 *  @param idCardImage          身份证图片
 *  @param idCardImagePath      身份证图片路径
 *  @param idCardImageData      身份证图片二进制
 *  @param apiKey               apikey
 *
 *  @return result
 */
-(NSString *)idCardImage:(UIImage *)idCardImage
                  apiKey:(NSString *) apiKey;

-(NSString *)idCardImagePath:(NSString *)idCardImagePath
                      apiKey:(NSString *) apiKey;

-(NSString *)idCardImageData:(NSData *)idCardImageData
                      apiKey:(NSString *) apiKey;


/**
 *  传入身份证图片识别
 *
 *  @param idCardImage          身份证图片
 *  @param idCardImagePath      身份证图片路径
 *  @param idCardImageData      身份证图片二进制
 *  @param apiKey               apikey
 *  @param successBlock         成功回调
 *  @param failureBlock         失败回调
 *
 */
-(void )idCardImage:(UIImage *)idCardImage
             apiKey:(NSString *) apiKey
       successBlock:(successBlock)successBlock
       failureBlock:(failureBlock)failureBlock;

-(void )idCardImagePath:(NSString *)idCardImagePath
                 apiKey:(NSString *) apiKey
           successBlock:(successBlock)successBlock
           failureBlock:(failureBlock)failureBlock;

-(void )idCardImageData:(NSData *)idCardImageData
                 apiKey:(NSString *) apiKey
           successBlock:(successBlock)successBlock
           failureBlock:(failureBlock)failureBlock;

#pragma mark 银行卡识别
/**
 *  传入银行卡图片识别
 *
 *  @param bankCardImage          银行卡图片
 *  @param bankCardImagePath      银行卡图片路径
 *  @param bankCardImageData      银行卡图片二进制
 *  @param apiKey               apikey
 *
 *  @return result
 */
-(NSString *)bankCardImage:(UIImage *)bankCardImage
                  apiKey:(NSString *) apiKey;

-(NSString *)bankCardImagePath:(NSString *)bankCardImagePath
                      apiKey:(NSString *) apiKey;

-(NSString *)bankCardImageData:(NSData *)bankCardImageData
                      apiKey:(NSString *) apiKey;


/**
 *  传入银行卡图片识别
 *
 *  @param bankCardImage          银行卡图片
 *  @param bankCardImagePath      银行卡图片路径
 *  @param bankCardImageData      银行卡图片二进制
 *  @param apiKey               apikey
 *  @param successBlock         成功回调
 *  @param failureBlock         失败回调
 *
 */
-(void )bankCardImage:(UIImage *)bankCardImage
             apiKey:(NSString *) apiKey
       successBlock:(successBlock)successBlock
       failureBlock:(failureBlock)failureBlock;

-(void )bankCardImagePath:(NSString *)bankCardImagePath
                 apiKey:(NSString *) apiKey
           successBlock:(successBlock)successBlock
           failureBlock:(failureBlock)failureBlock;

-(void )bankCardImageData:(NSData *)bankCardImageData
                 apiKey:(NSString *) apiKey
           successBlock:(successBlock)successBlock
           failureBlock:(failureBlock)failureBlock;

#pragma mark 营业执照识别
/**
 *  传入营业执照图片识别
 *
 *  @param businesslicenseImage          营业执照图片
 *  @param businesslicenseImagePath      营业执照图片路径
 *  @param businesslicenseImageData      营业执照图片二进制
 *  @param apiKey               apikey
 *
 *  @return result
 */
-(NSString *)businesslicenseImage:(UIImage *)businesslicenseImage
                    apiKey:(NSString *) apiKey;

-(NSString *)businesslicenseImagePath:(NSString *)businesslicenseImagePath
                        apiKey:(NSString *) apiKey;

-(NSString *)businesslicenseImageData:(NSData *)businesslicenseImageData
                        apiKey:(NSString *) apiKey;


/**
 *  传入营业执照图片识别
 *
 *  @param businesslicenseImage          营业执照图片
 *  @param businesslicenseImagePath      营业执照图片路径
 *  @param businesslicenseImageData      营业执照图片二进制
 *  @param apiKey               apikey
 *  @param successBlock         成功回调
 *  @param failureBlock         失败回调
 *
 */
-(void )businesslicenseImage:(UIImage *)businesslicenseImage
               apiKey:(NSString *) apiKey
         successBlock:(successBlock)successBlock
         failureBlock:(failureBlock)failureBlock;

-(void )businesslicenseImagePath:(NSString *)businesslicenseImagePath
                   apiKey:(NSString *) apiKey
             successBlock:(successBlock)successBlock
             failureBlock:(failureBlock)failureBlock;

-(void )businesslicenseImageData:(NSData *)businesslicenseImageData
                   apiKey:(NSString *) apiKey
             successBlock:(successBlock)successBlock
             failureBlock:(failureBlock)failureBlock;

#pragma mark 行驶证识别
/**
 *  传入行驶证图片识别
 *
 *  @param vehiclecardImage          行驶证图片
 *  @param vehiclecardImagePath      行驶证图片路径
 *  @param vehiclecardImageData      行驶证图片二进制
 *  @param apiKey               apikey
 *
 *  @return result
 */
-(NSString *)vehiclecardImage:(UIImage *)vehiclecardImage
                       apiKey:(NSString *) apiKey;

-(NSString *)vehiclecardImagePath:(NSString *)vehiclecardImagePath
                           apiKey:(NSString *) apiKey;

-(NSString *)vehiclecardImageData:(NSData *)vehiclecardImageData
                           apiKey:(NSString *) apiKey;


/**
 *  传入行驶证图片识别
 *
 *  @param vehiclecardImage          行驶证图片
 *  @param vehiclecardImagePath      行驶证图片路径
 *  @param vehiclecardImageData      行驶证图片二进制
 *  @param apiKey               apikey
 *  @param successBlock         成功回调
 *  @param failureBlock         失败回调
 *
 */
-(void )vehiclecardImage:(UIImage *)vehiclecardImage
                  apiKey:(NSString *) apiKey
            successBlock:(successBlock)successBlock
            failureBlock:(failureBlock)failureBlock;

-(void )vehiclecardImagePath:(NSString *)vehiclecardImagePath
                      apiKey:(NSString *) apiKey
                successBlock:(successBlock)successBlock
                failureBlock:(failureBlock)failureBlock;

-(void )vehiclecardImageData:(NSData *)vehiclecardImageData
                      apiKey:(NSString *) apiKey
                successBlock:(successBlock)successBlock
                failureBlock:(failureBlock)failureBlock;

#pragma mark 驾驶证识别
/**
 *  传入驾驶证图片识别
 *
 *  @param drivercardImage          驾驶证图片
 *  @param drivercardImagePath      驾驶证图片路径
 *  @param drivercardImageData      驾驶证图片二进制
 *  @param apiKey               apikey
 *
 *  @return result
 */
-(NSString *)drivercardImage:(UIImage *)drivercardImage
                      apiKey:(NSString *) apiKey;

-(NSString *)drivercardImagePath:(NSString *)drivercardImagePath
                          apiKey:(NSString *) apiKey;

-(NSString *)drivercardImageData:(NSData *)drivercardImageData
                          apiKey:(NSString *) apiKey;


/**
 *  传入驾驶证图片识别
 *
 *  @param drivercardImage          驾驶证图片
 *  @param drivercardImagePath      驾驶证图片路径
 *  @param drivercardImageData      驾驶证图片二进制
 *  @param apiKey               apikey
 *  @param successBlock         成功回调
 *  @param failureBlock         失败回调
 *
 */
-(void )drivercardImage:(UIImage *)drivercardImage
                 apiKey:(NSString *) apiKey
           successBlock:(successBlock)successBlock
           failureBlock:(failureBlock)failureBlock;

-(void )drivercardImagePath:(NSString *)drivercardImagePath
                     apiKey:(NSString *) apiKey
               successBlock:(successBlock)successBlock
               failureBlock:(failureBlock)failureBlock;

-(void )drivercardImageData:(NSData *)drivercardImageData
                     apiKey:(NSString *) apiKey
               successBlock:(successBlock)successBlock
               failureBlock:(failureBlock)failureBlock;

#pragma mark 身份证识别核验
/**
 *  传入身份证识别核验图片
 *
 *  @param idCardOcrVerifyImage          身份证识别核验图片
 *  @param idCardOcrVerifyImagePath      身份证识别核验图片路径
 *  @param idCardOcrVerifyImageData      身份证识别核验图片二进制
 *  @param apiKey               apikey
 *
 *  @return result
 */
-(NSString *)idCardOcrVerifyImage:(UIImage *)idCardOcrVerifyImage
                           apiKey:(NSString *) apiKey;

-(NSString *)idCardOcrVerifyImagePath:(NSString *)idCardOcrVerifyImagePath
                               apiKey:(NSString *) apiKey;

-(NSString *)idCardOcrVerifyImageData:(NSData *)idCardOcrVerifyImageData
                               apiKey:(NSString *) apiKey;


/**
 *  传入身份证识别核验图片
 *
 *  @param idCardOcrVerifyImage          身份证识别核验图片
 *  @param idCardOcrVerifyImagePath      身份证识别核验图片路径
 *  @param idCardOcrVerifyImageData      身份证识别核验图片二进制
 *  @param apiKey               apikey
 *  @param successBlock         成功回调
 *  @param failureBlock         失败回调
 *
 */
-(void )idCardOcrVerifyImage:(UIImage *)idCardOcrVerifyImage
                      apiKey:(NSString *) apiKey
                successBlock:(successBlock)successBlock
                failureBlock:(failureBlock)failureBlock;

-(void )idCardOcrVerifyImagePath:(NSString *)idCardOcrVerifyImagePath
                          apiKey:(NSString *) apiKey
                    successBlock:(successBlock)successBlock
                    failureBlock:(failureBlock)failureBlock;

-(void )idCardOcrVerifyImageData:(NSData *)idCardOcrVerifyImageData
                          apiKey:(NSString *) apiKey
                    successBlock:(successBlock)successBlock
                    failureBlock:(failureBlock)failureBlock;

#pragma mark 人脸身份证核验
/**
 *  传入核验图片人证核验
 *
 *  @param idCardImage          身份证图片
 *  @param faceImage            人脸图片
 *  @param idCardImagePath      身份证图片路径
 *  @param faceImagePath        人脸图片路径
 *  @param idCardImageData      身份证图片二进制
 *  @param faceImageData        人脸图片二进制
 *  @param apiKey               apikey
 *  @return result
 */
-(NSString *)faceIdCardVerifyWithIdCardImage:(UIImage *)idCardImage
                                   faceImage:(UIImage *)faceImage
                                      apiKey:(NSString *) apiKey;

-(NSString *)faceIdCardVerifyWithIdCardImagePath:(NSString *)idCardImagePath
                                   faceImagePath:(NSString *)faceImagePath
                                          apiKey:(NSString *) apiKey;

-(NSString *)faceIdCardVerifyWithIdCardImageData:(NSData *)idCardImageData
                                   faceImageData:(NSData *)faceImageData
                                          apiKey:(NSString *) apiKey;


/**
 *  传入核验图片人证核验
 *
 *  @param idCardImage          身份证图片
 *  @param faceImage            人脸图片
 *  @param idCardImagePath      身份证图片路径
 *  @param faceImagePath        人脸图片路径
 *  @param idCardImageData      身份证图片二进制
 *  @param faceImageData        人脸图片二进制
 *  @param apiKey               apikey
 */

-(void )faceIdCardVerifyWithIdCardImage:(UIImage *)idCardImage
                              faceImage:(UIImage *)faceImage
                                 apiKey:(NSString *) apiKey
                           successBlock:(successBlock)successBlock
                           failureBlock:(failureBlock)failureBlock;

-(void )faceIdCardVerifyWithIdCardImagePath:(NSString *)idCardImagePath
                              faceImagePath:(NSString *)faceImagePath
                                     apiKey:(NSString *) apiKey
                               successBlock:(successBlock)successBlock
                               failureBlock:(failureBlock)failureBlock;

-(void )faceIdCardVerifyWithIdCardImageData:(NSData *)idCardImageData
                              faceImageData:(NSData *)faceImageData
                                     apiKey:(NSString *) apiKey
                               successBlock:(successBlock)successBlock
                               failureBlock:(failureBlock)failureBlock;

#pragma mark 人脸身份证识别核验
/**
 *  传入核验图片人证核验
 *
 *  @param idCardImage          身份证图片
 *  @param faceImage            人脸图片
 *  @param idCardImagePath      身份证图片路径
 *  @param faceImagePath        人脸图片路径
 *  @param idCardImageData      身份证图片二进制
 *  @param faceImageData        人脸图片二进制
 *  @param apiKey               apikey
 *  @return result
 */
-(NSString *)faceIdCardOcrVerifyWithIdCardImage:(UIImage *)idCardImage
                                   faceImage:(UIImage *)faceImage
                                      apiKey:(NSString *) apiKey;

-(NSString *)faceIdCardOcrVerifyWithIdCardImagePath:(NSString *)idCardImagePath
                                   faceImagePath:(NSString *)faceImagePath
                                          apiKey:(NSString *) apiKey;

-(NSString *)faceIdCardOcrVerifyWithIdCardImageData:(NSData *)idCardImageData
                                   faceImageData:(NSData *)faceImageData
                                          apiKey:(NSString *) apiKey;


/**
 *  传入核验图片人证核验
 *
 *  @param idCardImage          身份证图片
 *  @param faceImage            人脸图片
 *  @param idCardImagePath      身份证图片路径
 *  @param faceImagePath        人脸图片路径
 *  @param idCardImageData      身份证图片二进制
 *  @param faceImageData        人脸图片二进制
 *  @param apiKey               apikey
 */

-(void )faceIdCardOcrVerifyWithIdCardImage:(UIImage *)idCardImage
                              faceImage:(UIImage *)faceImage
                                 apiKey:(NSString *) apiKey
                           successBlock:(successBlock)successBlock
                           failureBlock:(failureBlock)failureBlock;

-(void )faceIdCardOcrVerifyWithIdCardImagePath:(NSString *)idCardImagePath
                              faceImagePath:(NSString *)faceImagePath
                                     apiKey:(NSString *) apiKey
                               successBlock:(successBlock)successBlock
                               failureBlock:(failureBlock)failureBlock;

-(void )faceIdCardOcrVerifyWithIdCardImageData:(NSData *)idCardImageData
                              faceImageData:(NSData *)faceImageData
                                     apiKey:(NSString *) apiKey
                               successBlock:(successBlock)successBlock
                               failureBlock:(failureBlock)failureBlock;

#pragma mark 人脸1：1比对
/**
 *  传入图片人脸1：1比对
 *
 *  @param templateImage        模板人脸图片
 *  @param targetImage          目标人脸图片
 *  @param templateImagePath      模板人脸图片路径
 *  @param targetImagePath        目标人脸图片路径
 *  @param templateImageData      模板人脸图片二进制
 *  @param targetImageData        目标人脸图片二进制
 *  @param apiKey               apikey
 *  @return result
 */
-(NSString *)faceOneToOneComparisonWithTemplateImage:(UIImage *)templateImage
                                         targetImage:(UIImage *)targetImage
                                              apiKey:(NSString *) apiKey;

-(NSString *)faceOneToOneComparisonWithTemplateImagePath:(NSString *)templateImagePath
                                         targetImagePath:(NSString *)targetImagePath
                                                  apiKey:(NSString *) apiKey;

-(NSString *)faceOneToOneComparisonWithTemplateImageData:(NSData *)templateImageData
                                         targetImageData:(NSData *)targetImageData
                                                  apiKey:(NSString *) apiKey;


/**
 *  传入图片人脸1：1比对
 *
 *  @param templateImage        模板人脸图片
 *  @param targetImage          目标人脸图片
 *  @param templateImagePath      模板人脸图片路径
 *  @param targetImagePath        目标人脸图片路径
 *  @param templateImageData      模板人脸图片二进制
 *  @param targetImageData        目标人脸图片二进制
 *  @param apiKey               apikey
 *
 */

-(void )faceOneToOneComparisonWithTemplateImage:(UIImage *)templateImage
                                    targetImage:(UIImage *)targetImage
                                         apiKey:(NSString *) apiKey
                                   successBlock:(successBlock)successBlock
                                   failureBlock:(failureBlock)failureBlock;

-(void )faceOneToOneComparisonWithTemplateImagePath:(NSString *)templateImagePath
                                    targetImagePath:(NSString *)targetImagePath
                                             apiKey:(NSString *) apiKey
                                       successBlock:(successBlock)successBlock
                                       failureBlock:(failureBlock)failureBlock;

-(void )faceOneToOneComparisonWithTemplateImageData:(NSData *)templateImageData
                                    targetImageData:(NSData *)targetImageData
                                             apiKey:(NSString *) apiKey
                                       successBlock:(successBlock)successBlock
                                       failureBlock:(failureBlock)failureBlock;


#pragma mark 人脸活体验证
/**
 *  传入图片人脸活体验证
 *  @param faceImage          人脸图片
 *  @param faceImagePath      人脸图片路径
 *  @param faceImageData      人脸图片二进制
 *  @param faceInstruction    人脸动作指令(见FACEINSTRUCTION枚举)
 *  @param apiKey               apikey
 *  @return result
 */
-(NSString *)faceVerifyWithFaceImage:(UIImage *)faceImage
                     faceInstruction:(FACEINSTRUCTION)faceInstruction
                              apiKey:(NSString *) apiKey;

-(NSString *)faceVerifyWithFaceImagePath:(NSString *)faceImagePath
                         faceInstruction:(FACEINSTRUCTION)faceInstruction
                                  apiKey:(NSString *) apiKey;

-(NSString *)faceVerifyWithFaceImageData:(NSData *)faceImageData
                         faceInstruction:(FACEINSTRUCTION)faceInstruction
                                  apiKey:(NSString *) apiKey;


/**
 *  传入图片人脸活体验证
 *  @param faceImage          人脸图片
 *  @param faceImagePath      人脸图片路径
 *  @param faceImageData      人脸图片二进制
 *  @param faceInstruction    人脸动作指令(见FACEINSTRUCTION枚举)
 *  @param apiKey               apikey
 *
 */

-(void )faceVerifyWithFaceImage:(UIImage *)faceImage
                faceInstruction:(FACEINSTRUCTION)faceInstruction
                         apiKey:(NSString *) apiKey
                   successBlock:(successBlock)successBlock
                   failureBlock:(failureBlock)failureBlock;

-(void )faceVerifyWithFaceImagePath:(NSString *)faceImagePath
                    faceInstruction:(FACEINSTRUCTION)faceInstruction
                             apiKey:(NSString *) apiKey
                       successBlock:(successBlock)successBlock
                       failureBlock:(failureBlock)failureBlock;

-(void )faceVerifyWithFaceImageData:(NSData *)faceImageData
                    faceInstruction:(FACEINSTRUCTION)faceInstruction
                             apiKey:(NSString *) apiKey
                       successBlock:(successBlock)successBlock
                       failureBlock:(failureBlock)failureBlock;


#pragma mark 文本商务版识别-企业专用,全文本识别,支持表格,版式还原,文字定位及可信度
/**
 *  传入文本商务版图片识别
 *
 *  @param tableLanguageImage          文本商务版图片
 *  @param tableLanguageImagePath      文本商务版图片路径
 *  @param tableLanguageType           类别,TABLE_LANGUAGE_TYPE
 *  @param tableLanguageImageData      文本商务版图片二进制
 *  @param apiKey               apikey
 *
 *  @return result
 */
-(NSString *)tableLanguageImage:(UIImage *)tableLanguageImage
              tableLanguageType:(TABLE_LANGUAGE_TYPE)type
                      apiKey:(NSString *) apiKey;

-(NSString *)tableLanguageImagePath:(NSString *)tableLanguageImagePath
                  tableLanguageType:(TABLE_LANGUAGE_TYPE)type
                          apiKey:(NSString *) apiKey;

-(NSString *)tableLanguageImageData:(NSData *)tableLanguageImageData
                  tableLanguageType:(TABLE_LANGUAGE_TYPE)type
                          apiKey:(NSString *) apiKey;


/**
 *  传入文本商务版图片识别
 *
 *  @param tableLanguageImage          文本商务版图片
 *  @param tableLanguageImagePath      文本商务版图片路径
 *  @param tableLanguageImageData      文本商务版图片二进制
 *  @param tableLanguageType           类别,见TABLE_LANGUAGE_TYPE枚举
 *  @param apiKey               apikey
 *  @param successBlock         成功回调
 *  @param failureBlock         失败回调
 *
 */
-(void )tableLanguageImage:(UIImage *)tableLanguageImage
         tableLanguageType:(TABLE_LANGUAGE_TYPE)type
                 apiKey:(NSString *) apiKey
           successBlock:(successBlock)successBlock
           failureBlock:(failureBlock)failureBlock;

-(void )tableLanguageImagePath:(NSString *)tableLanguageImagePath
             tableLanguageType:(TABLE_LANGUAGE_TYPE)type
                     apiKey:(NSString *) apiKey
               successBlock:(successBlock)successBlock
               failureBlock:(failureBlock)failureBlock;

-(void )tableLanguageImageData:(NSData *)tableLanguageImageData
             tableLanguageType:(TABLE_LANGUAGE_TYPE)type
                     apiKey:(NSString *) apiKey
               successBlock:(successBlock)successBlock
               failureBlock:(failureBlock)failureBlock;

#pragma mark 人证比对
/**
 *  传入图片人证比对
 *
 *  @param idcardImage            身份证图片
 *  @param faceImage              人脸图片
 *  @param idcardImagePath        身份证图片路径
 *  @param faceImagePath          人脸图片路径
 *  @param idcardImageData        身份证图片二进制
 *  @param faceImageData          人脸图片二进制
 *  @param apiKey                 apikey
 *  @return result
 */
-(NSString *)compareIdCardAndFaceWithIdCardImage:(UIImage *)idcardImage
                                    faceImage:(UIImage *)faceImage
                                       apiKey:(NSString *) apiKey;

-(NSString *)compareIdCardAndFaceWithIdCardImagePath:(NSString *)idcardImagePath
                                    faceImagePath:(NSString *)faceImagePath
                                           apiKey:(NSString *) apiKey;

-(NSString *)compareIdCardAndFaceWithIdCardImageData:(NSData *)idcardImageData
                                    faceImageData:(NSData *)faceImageData
                                           apiKey:(NSString *) apiKey;

/**
 *  传入图片人证比对
 *
 *  @param idcardImage            身份证图片
 *  @param faceImage              人脸图片
 *  @param idcardImagePath        身份证图片路径
 *  @param faceImagePath          人脸图片路径
 *  @param idcardImageData        身份证图片二进制
 *  @param faceImageData          人脸图片二进制
 *  @param apiKey                 apikey
 *
 */


-(void )compareIdCardAndFaceWithIdCardImage:(UIImage *)idcardImage
                               faceImage:(UIImage *)faceImage
                                  apiKey:(NSString *) apiKey
                            successBlock:(successBlock)successBlock
                            failureBlock:(failureBlock)failureBlock;

-(void )compareIdCardAndFaceWithIdCardImagePath:(NSString *)idcardImagePath
                               faceImagePath:(NSString *)faceImagePath
                                      apiKey:(NSString *) apiKey
                                successBlock:(successBlock)successBlock
                                failureBlock:(failureBlock)failureBlock;

-(void )compareIdCardAndFaceWithIdCardImageData:(NSData *)idcardImageData
                               faceImageData:(NSData *)faceImageData
                                      apiKey:(NSString *) apiKey
                                successBlock:(successBlock)successBlock
                                failureBlock:(failureBlock)failureBlock;

#pragma mark 人证合一比对
/**
 *  传入图片人证合一比对
 *
 *  @param idcardImage            身份证图片
 *  @param faceImage              人脸图片
 *  @param idcardImagePath        身份证图片路径
 *  @param faceImagePath          人脸图片路径
 *  @param idcardImageData        身份证图片二进制
 *  @param faceImageData          人脸图片二进制
 *  @param apiKey                 apikey
 *  @return result
 */
-(NSString *)recgIdCardCompareFaceWithIdCardImage:(UIImage *)idcardImage
                                        faceImage:(UIImage *)faceImage
                                           apiKey:(NSString *) apiKey;

-(NSString *)recgIdCardCompareFaceWithIdCardImagePath:(NSString *)idcardImagePath
                                        faceImagePath:(NSString *)faceImagePath
                                               apiKey:(NSString *) apiKey;

-(NSString *)recgIdCardCompareFaceWithIdCardImageData:(NSData *)idcardImageData
                                        faceImageData:(NSData *)faceImageData
                                               apiKey:(NSString *) apiKey;


/**
 *  传入图片人证合一比对
 *
 *  @param idcardImage            身份证图片
 *  @param faceImage              人脸图片
 *  @param idcardImagePath        身份证图片路径
 *  @param faceImagePath          人脸图片路径
 *  @param idcardImageData        身份证图片二进制
 *  @param faceImageData          人脸图片二进制
 *  @param apiKey                 apikey
 *
 */


-(void )recgIdCardCompareFaceWithIdCardImage:(UIImage *)idcardImage
                                   faceImage:(UIImage *)faceImage
                                      apiKey:(NSString *) apiKey
                                successBlock:(successBlock)successBlock
                                failureBlock:(failureBlock)failureBlock;

-(void )recgIdCardCompareFaceWithIdCardImagePath:(NSString *)idcardImagePath
                                   faceImagePath:(NSString *)faceImagePath
                                          apiKey:(NSString *) apiKey
                                    successBlock:(successBlock)successBlock
                                    failureBlock:(failureBlock)failureBlock;

-(void )recgIdCardCompareFaceWithIdCardImageData:(NSData *)idcardImageData
                                   faceImageData:(NSData *)faceImageData
                                          apiKey:(NSString *) apiKey
                                    successBlock:(successBlock)successBlock
                                    failureBlock:(failureBlock)failureBlock;

#pragma mark 人脸定位识别

/**
 *  人脸定位识别
 *
 *  @param faceImage        人脸图片
 *  @param faceImagePath    人脸图片路径
 *  @param faceImageData    人脸图片二进制
 *  @param apiKey           apikey
 *
 *  @return result
 */
-(NSString *)faceImage:(UIImage *)faceImage
                apiKey:(NSString *)apiKey;

-(NSString *)faceImagePath:(NSString *)faceImagePath
                    apiKey:(NSString *)apiKey;

-(NSString *)faceImageData:(NSData *)faceImageData
                    apiKey:(NSString *)apiKey;

/**
 *  人脸定位识别
 *
 *  @param faceImage        人脸图片
 *  @param faceImagePath    人脸图片路径
 *  @param faceImageData    人脸图片二进制
 *  @param apiKey           apikey
 *  @param successBlock     成功回调
 *  @param failureBlock     失败回调
 *
 */
-(void )faceImage:(UIImage *)faceImage
           apiKey:(NSString *)apiKey
     successBlock:(successBlock)successBlock
     failureBlock:(failureBlock)failureBlock;

-(void )faceImagePath:(NSString *)faceImagePath
               apiKey:(NSString *)apiKey
         successBlock:(successBlock)successBlock
         failureBlock:(failureBlock)failureBlock;

-(void )faceImageData:(NSData *)faceImageData
               apiKey:(NSString *)apiKey
         successBlock:(successBlock)successBlock
         failureBlock:(failureBlock)failureBlock;


#pragma mark 年龄、表情识别

/**
 *  传入人脸图片识别年龄、表情
 *
 *  @param faceImage        人脸图片
 *  @param faceImagePath    人脸图片路径
 *  @param faceImageData    人脸图片二进制
 *
 *  @return result
 */
-(NSString *)theFaceImage:(UIImage *)faceImage
                   apiKey:(NSString *)apiKey;

-(NSString *)theFaceImagePath:(NSString *)faceImagePath
                       apiKey:(NSString *)apiKey;

-(NSString *)theFaceImageData:(NSData *)faceImageData
                       apiKey:(NSString *)apiKey;


/**
 *  传入人脸图片识别年龄、表情
 *
 *  @param faceImage        人脸图片
 *  @param faceImagePath    人脸图片路径
 *  @param faceImageData    人脸图片二进制
 *  @param successBlock     成功回调
 *  @param failureBlock     失败回调
 *
 */
-(void )theFaceImage:(UIImage *)faceImage
              apiKey:(NSString *)apiKey
        successBlock:(successBlock)successBlock
        failureBlock:(failureBlock)failureBlock;

-(void )theFaceImagePath:(NSString *)faceImagePath
                  apiKey:(NSString *)apiKey
            successBlock:(successBlock)successBlock
            failureBlock:(failureBlock)failureBlock;

-(void )theFaceImageData:(NSData *)faceImageData
                  apiKey:(NSString *)apiKey
            successBlock:(successBlock)successBlock
            failureBlock:(failureBlock)failureBlock;

#pragma mark 手写公式识别
/**
 *  手写公式识别
 *
 *  @param formulaData      公式数据
 *  @param apiKey           apikey
 *
 *  @return result
 */

-(NSString *)formulaData:(NSString *)formulaData
                  apiKey:(NSString *)apiKey;


/**
 *  手写公式识别
 *
 *  @param formulaData      公式数据
 *  @param apiKey           apikey
 *  @param successBlock     成功回调
 *  @param failureBlock     失败回调
 *
 */
-(void )formulaData:(NSString *)formulaData
             apiKey:(NSString *)apiKey
       successBlock:(successBlock)successBlock
       failureBlock:(failureBlock)failureBlock;

#pragma mark 题目识别

/**
 *  传入题目图片识别
 *
 *  @param problemImage         图片
 *  @param problemImagePath     图片路径
 *  @param problemImageData     图片二进制
 *  @param apiKey               apikey
 *
 *  @return result
 */
-(NSString *)problemImage:(UIImage *)problemImage
                   apiKey:(NSString *)apiKey;


-(NSString *)problemImagePath:(NSString *)problemImagePath
                       apiKey:(NSString *)apiKey;

-(NSString *)problemImageData:(NSData *)problemImageData
                       apiKey:(NSString *)apiKey;


/**
 *  传入题目图片识别
 *
 *  @param problemImage         图片
 *  @param problemImagePath     图片路径
 *  @param problemImageData     图片二进制
 *  @param apiKey               apikey
 *  @param successBlock         成功回调
 *  @param failureBlock         失败回调
 *
 */
-(void )problemImage:(UIImage *)problemImage
              apiKey:(NSString *)apiKey
        successBlock:(successBlock)successBlock
        failureBlock:(failureBlock)failureBlock;

-(void )problemImagePath:(NSString *)problemImagePath
                  apiKey:(NSString *)apiKey
            successBlock:(successBlock)successBlock
            failureBlock:(failureBlock)failureBlock;

-(void )problemImageData:(NSData *)problemImageData
                  apiKey:(NSString *)apiKey
            successBlock:(successBlock)successBlock
            failureBlock:(failureBlock)failureBlock;


/**
 *  云数字识别
 *
 *  @param textImage        文本图片
 *  @param textImageData    文本图片二进制
 *  @param textImagePath    文本图片路径
 *  @param apiKey           apikey
 *  @param successBlock     成功回调
 *  @param failureBlock     失败回调
 *
 */
-(void )digitalImage:(UIImage *) textImage
       apiKey:(NSString *) apiKey
 successBlock:(successBlock)successBlock
 failureBlock:(failureBlock)failureBlock;

-(void )digitalImageData:(NSData *) textImageData
       apiKey:(NSString *) apiKey
 successBlock:(successBlock)successBlock
 failureBlock:(failureBlock)failureBlock;

-(void )digitalImagePath:(NSString *) textImagePath
       apiKey:(NSString *) apiKey
 successBlock:(successBlock)successBlock
 failureBlock:(failureBlock)failureBlock;


@end
