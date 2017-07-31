////获取到了崩溃的日子，如何发送给开发者呢，目前一般有以下两种方式：
//1. 将崩溃信息持久化在本地，下次程序启动时，将崩溃信息作为日志发送给开发者。
//
//2. 通过邮件发送给开发者。 不过此种方式需要得到用户的许可，因为iOS不能后台发送短信或者邮件，会弹出发送邮件的界面，只有用户点击了发送才可发送。 不过，此种方式最符合苹果的以用户至上的原则。
//发送邮件代码也很简单：
//NSString *crashLogInfo = [NSString stringWithFormat:@"exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr];
//NSString *urlStr = [NSString stringWithFormat:@"mailto://tianranwuwai@yeah.net?subject=bug报告&body=感谢您的配合!
//                    
//                    
//                    "
//                    "错误详情:%@",
//                    crashLogInfo];
//NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//[[UIApplication sharedApplication] openURL:url];

//以上就是iOS中捕获异常常用的方法，大家可以不妨一试！
//  CatchCrash.m
//  errorLogFile
//
//  Created by 申超 on 15/11/16.
//  Copyright (c) 2015年 SC. All rights reserved.
//




#import "CatchCrash.h"
//#import "zhitongti-swift.h"
//#import "SCHeader.h"
@interface CatchCrash()

@end
@implementation CatchCrash


void uncaughtExceptionHandler(NSException *exception)
{
    

    NSArray *stackArray = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
    NSString *name = [exception name];//异常类型
    NSString *allInfo=@"";
    NSString *exceptionInfo = @"";
    //IOS-获取设备型号、设备版本号、设备名称、app（程序版本号）
    
    NSDictionary *infoDictionary=[[NSBundle mainBundle]infoDictionary];
    allInfo=[NSString stringWithFormat:@"%@设备名称：%@\n",allInfo,[[UIDevice currentDevice]name]];
    allInfo=[NSString stringWithFormat:@"%@设备型号：%@\n",allInfo,[[UIDevice currentDevice]systemName]];
    allInfo=[NSString stringWithFormat:@"%@设备版本号：%@\n",allInfo,[[UIDevice currentDevice]systemVersion]];
    
    
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    allInfo=[NSString stringWithFormat:@"%@app（程序版本号）：%@\n",allInfo,app_Version];
    
    
    
    //app build版本
    NSString *app_build =[infoDictionary objectForKey:@"CFBundleVersion"];
    allInfo=[NSString stringWithFormat:@"%@app（build版本号）：%@\n",allInfo,app_build];
    
    
    
    exceptionInfo = [NSString stringWithFormat:@"%@Exception reason：%@\nException name：%@\nException stack：%@",allInfo,name, reason, stackArray];
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:stackArray];
    [tmpArr insertObject:reason atIndex:0];
    
    //保存到本地  --  上传这个log
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *_filePath=[paths objectAtIndex:0];
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    date = [formatter stringFromDate:[NSDate date]];
    NSFileManager *fm=[NSFileManager defaultManager];
    //创建文件夹
    [fm createDirectoryAtPath:[NSString stringWithFormat:@"%@/err",_filePath] withIntermediateDirectories:YES attributes:nil error:nil];
    
    _filePath=[NSString stringWithFormat:@"%@/err/ztt-ios-%@error.txt",_filePath,date];
    
    [exceptionInfo writeToFile:_filePath  atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"!!!!!!!----------崩溃日志地址-----------!!!!!!!!!%@",_filePath);
}

+(void)errorLogFile{
    //注册消息处理函数的处理方法
//    1. 在程序启动时加上一个异常捕获监听，用来处理程序崩溃时的回调动作
//    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
//    NSArray *name=[[NSArray alloc]initWithObjects:@"1",@"2",@"3", nil];
//    NSLog(@"-------------%@",name[3]);
    
    NSFileManager *fm=[NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *_filePath=[paths objectAtIndex:0];
    _filePath=[_filePath stringByAppendingPathComponent:@"err"];
    
    BOOL isExist=[fm fileExistsAtPath:_filePath];
    //判断文件是否存在
    if(isExist){
        
//        NSString *us=@""
//        UserInfo.current.token;
//        LoginHelper.isLogin()
//        if (LoginHelper.isLogin()) {
//            UserInfo *user=[[UserInfo alloc]init];
//            NSLog(user.current.token);
//        }
        
        NSString* date;
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYYMMddHHmmss"];
        date = [formatter stringFromDate:[NSDate date]];
        
        
        
         //写入本地上传到服务器
        NSError *error;
        NSArray *arr=[fm  contentsOfDirectoryAtPath:_filePath error:&error];
        NSString *url=[NSString stringWithFormat:@"%@/%@",_filePath,arr[0]];
//        NSData *fileData = [NSData dataWithContentsOfFile:url];
        
        NSString *postUrl=[NSString stringWithFormat:@"%@m/errlog",@""];

        

        [CCPNetworking uploadWith:UpLoadTypeFile fileArr:@[url] url:postUrl filename:nil names:@[@"bug"] params:nil loadingImageArr:nil toShowView:nil progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        } success:^(id response) {
            //删除文件夹
            [fm removeItemAtPath:[NSString stringWithFormat:@"%@",_filePath] error:nil];
        } fail:^(NSError *error) {
            NSLog(@"Failure %@", error);

        } showHUD:NO ];
   
    }
    
}

@end
