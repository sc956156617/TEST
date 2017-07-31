
//
//  SCLoginViewController.m
//  汽车配件
//
//  Created by cb on 2017/3/27.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCLoginViewController.h"
#import "SCRegisterViewController.h"
#import "SCForgetViewController.h"
#import "SCEnterpriseViewController.h"
//#import "SCWhiteNavigationViewController.h"
#import "AppDelegate.h"
#import "AppDelegate+RootController.h"
@interface SCLoginViewController ()
@property(nonatomic,strong) UITextField *usertextfield;
@property(nonatomic,strong) UITextField *passwordtextfield;

@end

@implementation SCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logintouchclicke:) name:@REGISTERLOGIN object:nil];
    //设置导航栏
    [self  setnavigation];
    //设置子视图
    [self   setUpChildView];
}
-(void)setUpChildView{

    self.view.backgroundColor=[UIColor whiteColor];
  
    //登陆界面的忘记密码按钮
//    UIButton *forgetpassword=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [forgetpassword setTitle:@"忘记密码" forState:UIControlStateNormal];
//    [forgetpassword setFrame:CGRectMake(100, 450, 100, 30)];
//    [forgetpassword addTarget:self action:@selector(forgetpasswordclicked:) forControlEvents:UIControlEventTouchUpInside];
//    forgetpassword.backgroundColor=[UIColor blueColor];
//    [self.view addSubview:forgetpassword];
  
    
    //用户名输入框
    UITextField *usertextfield=[[UITextField alloc]initWithFrame:CGRectMake(10,15, kScreenW, 40)];
    usertextfield.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    usertextfield.secureTextEntry=NO;
    usertextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    usertextfield.clearsOnBeginEditing=YES;
    usertextfield.placeholder=@"请输入手机号";
    usertextfield.keyboardType = UIKeyboardTypeNumberPad;
    self.usertextfield= usertextfield;
    [self.view addSubview:usertextfield];
    
    //分割线
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(10, 60, kScreenW-20, 1)];
    line.y = CGRectGetMaxY(usertextfield.frame)+10;
    line.backgroundColor = SCLineGrayColor;
    [self.view addSubview:line];
    UIView *lineX =[[UIView alloc]initWithFrame:CGRectMake(10, 200, kScreenW-20, 1)];
    lineX.backgroundColor = SCLineGrayColor;

    [self.view addSubview:lineX];
    //密码输入框
    UITextField *passwordtextfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 85, kScreenW, 40)];
    lineX.y = CGRectGetMaxY(passwordtextfield.frame)+10;
    passwordtextfield.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    passwordtextfield.secureTextEntry=YES;
    passwordtextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    passwordtextfield.clearsOnBeginEditing=YES;
    passwordtextfield.placeholder=@"请输入密码";
    self.passwordtextfield = passwordtextfield;
    [self.view addSubview:passwordtextfield];
    
    
    //查看密码btn
    UIButton *seeB=[UIButton buttonWithType:UIButtonTypeCustom];
    [seeB setFrame:CGRectMake(kScreenW-50, 40, 40,40)];
    seeB.centerY = passwordtextfield.centerY;
    [seeB setImage:[UIImage imageNamed:@"huiyan"] forState:UIControlStateNormal];
    [seeB setImage:[UIImage imageNamed:@"seepassworld"]       forState:UIControlStateSelected];
    [seeB addTarget:self action:@selector(seePassworld:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seeB];

    
    //登陆界面的点击登陆按钮
    UIButton *logintouch=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logintouch setTitle:@"登录" forState:UIControlStateNormal];
    logintouch.titleLabel.font = [UIFont systemFontOfSize:AdapationLabelFont(17)];
    [logintouch setFrame:CGRectMake(0, self.view.centerY, kScreenW-50, 116/3)];
    logintouch.centerX = self.view.centerX;
    [logintouch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logintouch.backgroundColor = SCThemeColor;
    logintouch.layer.masksToBounds = YES;
    logintouch.layer.cornerRadius = 116/3/2-5;
    [logintouch addTarget:self action:@selector(logintouchclicke:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logintouch];
    
    
    //登陆协议  下两个
    UILabel *passwordlabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenW/4, kScreenH-100, 2000,50 )];
    passwordlabel.text=@"登陆即代表您";
//    passwordlabel.backgroundColor=[UIColor yellowColor];
    passwordlabel.font=[UIFont systemFontOfSize:AdapationLabelFont(12)];
    passwordlabel.textColor  = SCGrayColor;
    [passwordlabel sizeToFit];
    
    [self.view addSubview:passwordlabel];

    UILabel *userlabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(passwordlabel.frame),CGRectGetMinY(passwordlabel.frame), 2000, 50)];
    userlabel.text=@"同意用户协议及隐私条款";
    userlabel.font=[UIFont systemFontOfSize:AdapationLabelFont(12)];
    userlabel.centerY = passwordlabel.centerY;
    userlabel.textColor = SCThemeColor;
    [passwordlabel  sizeToFit];
    [self.view addSubview:userlabel];
    
    
    //登陆界面的点击登陆按钮
    UIButton *forget=[UIButton buttonWithType:UIButtonTypeCustom];
    [forget setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forget setTitleColor:SCGrayColor forState:UIControlStateNormal];

    forget.titleLabel.font = [UIFont systemFontOfSize:AdapationLabelFont(14)];
    [forget setFrame:CGRectMake(kScreenW-100,CGRectGetMaxY(logintouch.frame), 80, 20)];
    [forget addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forget];

    
}
#pragma mark 点击方法
-(void)forget{
    [self.navigationController pushViewController:[NSClassFromString(@"SCForgetViewController")  new] animated:1];
}
-(void)seePassworld:(UIButton *)btn{
    self.passwordtextfield.secureTextEntry = !self.passwordtextfield.secureTextEntry;
    btn.selected  = ! btn.selected;
}
-(void)logintouchclicke:(UIButton *)btn{
        if (![self isEmpty]) {
    [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,LOGIN]
                               params:@{@"phone":_usertextfield.text,
                                         @"password": _passwordtextfield.text
                                        }
                      loadingImageArr:nil toShowView:nil
                              success:^(id response) {
                                  NSLog(@"%@",response);
                                  
                                  if([response[@"code"]  isEqual: @1001]){

                                  
                                  NSString *ID = response[@"dictionary"][@"uid"];
                                  NSString *username = response[@"dictionary"][@"nickname"];
                                  NSString *phone = response[@"dictionary"][@"phone"];
                                  NSString *userlevel = response[@"dictionary"][@"userlevel"];
                                  NSString *headsmall = response[@"dictionary"][@"headsmall"];
                                  NSString *token = response[@"dictionary"][@"token"];
                                  NSString *qr_code = response[@"dictionary"][@"qr_code"];
                                      
                                      
                                                  [SCUserDefaults  setBool:true forKey:@ISLOGIN];
                                                  [SCUserDefaults setObject:userlevel forKey:@USERLEVEL];
                                                  [SCUserDefaults setObject:ID forKey:@USERID];
                                                  [SCUserDefaults setObject:username forKey:@USERNICKNAME];
                                                  [SCUserDefaults setObject:phone forKey:@USERPHONE];
                                                  [SCUserDefaults setObject:headsmall forKey:@USERHEADSMAALL];
                                                  [SCUserDefaults setObject:token forKey:@USERTOKEN];
                                                  [SCUserDefaults setObject:qr_code forKey:@USERQRCODE];
                                      [self  dismissViewControllerAnimated:1 completion:nil];

                                  }
                                  
                              } fail:^(NSError *error) {
                               
                              } showHUD:1] ;
        }

}
-(void)setnavigation{
    
    
//    NSLog(@"%ld",self.navigationController.viewControllers.count);
//    [UINavigationBar appearance].barTintColor = SCThemeColor;
    self.navigationController.navigationBar.translucent = NO;
    self.title=@"登录";
    self.navigationItem.leftBarButtonItem = [SCColorTypeTools itemWithTitleName:@"取消"  highTitleName:@"取消" addTarget:self action:@selector(backClick) tintColor:nil ];
    self.navigationItem.rightBarButtonItem = [SCColorTypeTools itemWithTitleName:@"注册"  highTitleName:@"注册" addTarget:self action:@selector(registerClick:) tintColor:nil];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(0, 63, kScreenW, 1)];
    line.backgroundColor = SCLineGrayColor;
    [self.navigationController.navigationBar didAddSubview:line];
}
-(void)backClick{
    [self dismissViewControllerAnimated:1 completion:nil];
}




/**
 跳转到注册界面
 */
-(void)registerClick:(UIButton *)btn{
    [self.navigationController pushViewController:[SCRegisterViewController  new]  animated:1];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if(textView.tag == 0) {
        textView.textColor = [UIColor blackColor];
        textView.tag = 1;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length] == 0)
    {
        textView.textColor = SCGrayColor;
        textView.tag = 0;
    }
}

#pragma mark ----保存所需信息
-(void)saveUserInfo:(NSMutableDictionary *)userInfoDic{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:self.usertextfield.text forKey:@"username"];
    [user setObject:self.passwordtextfield.text forKey:@"password"];
    [user setObject:userInfoDic[@"data"][@"uid"] forKey:@"uid"];
    [user setObject:userInfoDic[@"data"][@"headsmall"] forKey:@"headsmall"];
    [user setObject:userInfoDic[@"data"][@"signature"] forKey:@"signature"];
    [user setObject:userInfoDic forKey:@"userInfo"];
}
//判断账号和密码是否为空
- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = self.usertextfield.text;
    NSString *password = self.passwordtextfield.text;
    if (username.length == 0 || password.length == 0) {
        [self showHint:@"请输入手机号或密码"];
        ret = YES;
    }else if (username.length!=11) {
         ret = YES;
        [self showHint:@"请检查手机号长度"];
    }else if (password.length > 11 ||   password.length<6) {
         ret = YES;
        [self showHint:@"密码长度为6-11位"];
    }else{
        ret = NO;
    }
    return ret;
}
#pragma  mark - private
//- (void)saveLastLoginUsername
//{
//    NSString *username = [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:kSDKUsername];
//    if (username && username.length > 0) {
//        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_%@",kSDKUsername]];
//        [ud synchronize];
//    }
//}
//
//- (NSString*)lastLoginUsername
//{
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSString *username = [ud objectForKey:[NSString stringWithFormat:@"em_lastLogin_%@",kSDKUsername]];
//    if (username && username.length > 0) {
//        return username;
//    }
//    return nil;
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear: animated];
//    
//    //显示账号信息
//    NSArray * account=[SCUserInfo getAcountInfo];
//    self.usertextfield.text = account[0];
//    self.passwordtextfield.text = account[1];
//}
@end
