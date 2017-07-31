//
//  ZttApp.m
//  zhitongti
//
//  Created by SC on 16/1/21.
//  Copyright (c) 2016年 SC. All rights reserved.
//

#import "ZttApp.h"

//#define YDXTNEWSHOMEURL @"http://www.ydxt.com/case/hotdetail?caseId="
//  types 1：移动学堂朋友圈，2：移动学堂好友（群）（暂无），3：QQ空间，4：新浪微博，5：微信朋友圈
typedef enum : int {
    ShareTypeNone,
    ShareTypeToYdxt,
    ShareTypeToYdxtFriend,
    ShareTypeToQQ,
    ShareTypeToSina,
    ShareTypeToWeiXin,
} ShareType;


@interface ZttApp ()


@end

@implementation ZttApp
//网页关闭接口

-(void)close{
//      UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"GGGGGGG" message:nil delegate:nil cancelButtonTitle:@"cancle" otherButtonTitles:nil, nil];
//       [alert show];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate zttDelegateWith:@"关闭"];
    });
}
//couse的四个大方法
- (void)showProjectLib:(NSString *)uid{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.delegate zttDelegateWith:@"专题"];
    });
}
- (void)showLiveLib:(NSString *)uid{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate zttDelegateWith:@"直播"];
    });
    
}
- (void)showShalongLib:(NSString *)uid{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate zttDelegateWith:@"沙龙"];
    });
}
- (void)showStudyLib:(NSString *)uid{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate zttDelegateWith:@"学习"];
    });
}
-(void)showlogin:(NSString *)uid{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.delegate zttDelegateWith:@"登录"];
//    });

}
- (void)showUserInfo:(NSString *)uId
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([uId isEqualToString:@""]) {
            if (self.delegate != nil &&[_delegate respondsToSelector:@selector(GoToInfoViewController:)]) {
                [_delegate GoToInfoViewController:nil];
            }
        }else{
            
            if (self.delegate != nil &&[_delegate respondsToSelector:@selector(GoToInfoViewController:)]) {
                [_delegate GoToInfoViewController:uId];
            }
        }
    });
    
}


-(void)showHonorCoinRoll:(NSString *)uid{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.delegate zttDelegateWith:@"积分"];
    });
    
}
-(void)showHonorInteractionRoll:(NSString *)uid{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.delegate zttDelegateWith:@"互动"];
    });
    
}
-(void)showHonorStudyRoll:(NSString *)uid{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.delegate zttDelegateWith:@"学霸"];
    });
}
//传送到所有界面的点击信息。
-(void)showCourse:(NSString *)courseid :(int)type{
    //   1课程，2 直播，3沙龙，4 专题，5 H5页面
    //    NSLog(@"===-%d",type);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([self.delegate respondsToSelector:@selector(passCourseid:andType:)]) {
            [self.delegate passCourseid:courseid andType:type];
        }
        
    });
}
-(void)showCourseInfo:(NSString *)courseid{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate zttDelegateWith:courseid];
    });
}

//let sheet = UIActionSheet()
//sheet.tag = 301
//sheet.title = "分享"
//sheet.delegate = self
//sheet.cancelButtonIndex = sheet.addButtonWithTitle("取消")
//
//shareOurAppIndex = Int64(sheet.addButtonWithTitle("移动学堂"))
//sheet.showInView(self.view)


//  types 1：移动学堂友圈，2：移动学堂好友（群）（暂无），3：QQ空间，4：新浪微博，5：微信朋友圈
/**
 *
 *  @param newid   新闻id
 *  @param types   分享的客户端类型
 *  @param title   分享的标题
 *  @param summary  分享的语句
 *  @param picurl  图片
 */
- (void)shareNews:(NSString *)newid :(NSString *)types :(NSString *)title :(NSString *)summary :(NSString *)picurl
{
    NSLog(@"newid==%@\n types==%@\n title==%@\n summary==%@\n picurl==%@",newid,types,title,summary,picurl);
    
    NSString *gbkTitle = [title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *gbkSummary = [summary stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSLog(@"gbkString ----->>> %@\n gbk ========<<< %@",gbkTitle,gbkSummary);
    
    
    if ([types intValue] == ShareTypeNone) {
        return;
    }
    
    //
    if ([types intValue] == ShareTypeToYdxt) {
        
        NSDictionary *dict = @{@"url":picurl,@"title":title,@"courseid":newid};
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:dict];
        
        // type：1文字图片  3:课件资源

        
    }
    
    // 分享到移动学堂群组（暂无）
    if ([types intValue] == ShareTypeToYdxtFriend) {
        
    }
    
    if ([types intValue] == ShareTypeToQQ) {
        
        
    }
    
    
    
    // 分享到微信
    if ([types intValue] == ShareTypeToWeiXin) {
        
       }
    
    
    //  分享到新浪
    if ([types intValue] == ShareTypeToSina) {
        
        
    }
    
    
    
    
    
}

//  types 1：移动学堂友圈，2：移动学堂好友（群）（暂无），3：QQ空间，4：新浪微博，5：微信朋友圈
/**
 *
 *  @param title   分享的标题
 *  @param picurl  图片
 */
-(void)shareCert:(NSString *)Certid :(NSString *)type :(NSString *)title  :(NSString *)picurl{
    
    
    
    NSString *shalongid = Certid;
    NSLog(@"newid==%@\n types==%@\n title==%@\n  picurl==%@",Certid,type,title,picurl);
    
    NSString *gbkTitle = [title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSString *gbkSummary = [sum];
    //    NSLog(@"gbkString ----->>> %@\n gbk ========<<< %@",gbkTitle,gbkSummary);
    if ([type intValue] == ShareTypeNone) {
        NSLog(@"未分享");
        return;
    }
    
    //
    if ([type intValue] == ShareTypeToYdxt) {
        NSLog(@"移动学堂");
        if (Certid==nil) {
            Certid=@"";
        }
        NSDictionary *dict = @{@"url":picurl,@"title":title,@"courseid":Certid};
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:dict];
        
        // type：1文字图片  3:课件资源
  
    }
    
    // 分享到移动学堂群组（暂无）
    if ([type intValue] == ShareTypeToYdxtFriend) {
        NSLog(@"群组");
        
    }
    
    if ([type intValue] == ShareTypeToQQ) {
        NSLog(@"qq空间");
        
        
    }
    
    
    
    // 分享到微信
    if ([type intValue] == ShareTypeToWeiXin) {
        NSLog(@"微信");
         }
    
    
    //  分享到新浪
    if ([type intValue] == ShareTypeToSina) {
        
        NSLog(@"新浪");
       
    }
    //
}


//  types 1：移动学堂友圈，2：移动学堂好友（群）（暂无），3：QQ空间，4：新浪微博，5：微信朋友圈
/**
 *
 *  @param newid   新闻id
 *  @param types   分享的客户端类型
 *  @param title   分享的标题
 *  @param summary  分享的语句
 *  @param picurl  图片
 */
-(void)shareShalong:(NSString *)shalongid :(NSString *)type :(NSString *)title :(NSString *)summary :(NSString *)picurl{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate passWebviewControllerWithID:shalongid title:title pic:picurl summary:summary type:type];
        
    });
}
-(void)goToUrl:(NSString *)url :(NSString *)title{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //        NSLog(@"%@==%@=======%@",url,title,UserInfo.current.token);
        [self.delegate passWebviewControllerWithtitle:title and:url];
    });
    
}
/**
 *  下载接口
 */
-(void)down:(NSString *)url{
    
}


@end

