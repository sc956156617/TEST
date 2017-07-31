

#ifndef SCApi_h
#define SCApi_h

#define NETTYPE_W @"1"

#ifdef NETTYPE_W
#define HTTPHEADER                 @"http://192.168.1.111:8080/carMagazine/"
#else
#define HTTPHEADER                 @"http://192.168.1.111:8080/AutoParts/auto.action?"
#endif

//图片服务器域名

#define   IMAGEHEADER @"http://pic-xiupeilian.cn-bj.ufileos.com/"

//获取验证码
#define   PHONECODE @"user/getValidateCode.do"

//注册
#define   REGISTER @"user/registerUser.do"


//修改密码
#define   REPASSWORLD @"user/updatePassword.do"

//忘记密码
#define   FORGETPASSWORLD @"user/forgotPassword.do"

//登录
#define   LOGIN @"user/login.do"

//图片上传
#define   UPLOADIMAGE @"picture/upload.do"

//完善信息
#define   UPINFO @"user/perfectPersonalInfo.do"

//精品列表
#define   JINGPIN @"scopeBusiness/getPrimes.do"
//修改头像
#define   UPDATEHEAD @"user/updateHead.do"

//修改个人背景图
#define   CHANGEBACKGROUND @"user/updateBackgroundImage.do"

//修改性别
#define   CHANGESEX @"user/updateSex.do"

//修改昵称
#define   CHANGENICKNAME @"user/updateUserName.do"
//修改个人所在地
#define   CHANGEAREA @"user/updateLocation.do"
//
////修改签名
#define   CHANGESIGN @"user/updateAutograph.do"
//
////修改身份证号
#define   CHANGEIDCARD @"user/updateIdentity.do"
//登录
#define   LOGIN @"user/login.do"

//退出
#define   LOGOUT @"user/signOut.do"


//获取token
#define   GETRTOKEMN @"user/getToken.do"

//个人展示
#define   USERINFODISPLAY @"user/personalInfo.do"

// 图片路径
#define MLSelectPhotoSrcName(file) [@"MLSelectPhoto.bundle" stringByAppendingPathComponent:file]
/**
 *  配件列表
 *
 *
 */
#define PeiJianList  [NSString stringWithFormat:@"http://192.168.1.107:8080/carInternal/openInterface/getDatasInterface/getOtherParts.do"]
/**
 *  精品列表
 *
 *
 */
#define BESTList  [NSString stringWithFormat:@"http://192.168.1.107:8080/carInternal/openInterface/getDatasInterface/getPrime.do"]
/**
 品牌列表
 *
 *
 */
#define BandsList  [NSString stringWithFormat:@"http://192.168.1.109:8080/carInternal/openInterface/getDatasInterface/getCarModel.do"]
/**
 地区列表
 *
 *
 */
#define areaList  [NSString stringWithFormat:@"http://116.75.103.107：8080/carInternal/openInterface/getDatasInterface/getArea.do"]


#endif /* SCApi_h */
