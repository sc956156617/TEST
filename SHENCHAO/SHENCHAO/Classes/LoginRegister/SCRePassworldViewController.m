//
//  SCRePassworldViewController.m
//  汽车配件
//
//  Created by cb on 2017/3/28.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCRePassworldViewController.h"
#import "SCUserInfo.h"
@interface SCRePassworldViewController ()
@property(nonatomic,strong) UITextField * oldPassworld;
@property(nonatomic,strong) UITextField * newpassworld;
@property(nonatomic,strong) UITextField * renewpassworld;
@end

@implementation SCRePassworldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setNavigation];
    [self  setUpChildViews];
}

- (void)setNavigation {
        self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = [SCColorTypeTools itemWithImageName:@"fanhuihei" highImageName:@"fanhui"  addTarget:self action:@selector(editClick:)  tintColor:nil];
}
-(void)editClick:(UIButton *)btn{
    [self.navigationController   popViewControllerAnimated:1];
}
- (void)setUpChildViews {
    
    
    //手机号
    UITextField *usertextfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 14, kScreenW, 40)];
    usertextfield.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    usertextfield.secureTextEntry=NO;
    usertextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    usertextfield.clearsOnBeginEditing=YES;
    usertextfield.placeholder=@"请输入旧密码";
    self.oldPassworld= usertextfield;
    
    [self.view addSubview:usertextfield];
    
    
    //验证码
    UITextField *passwordtextfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 74, kScreenW, 40)];
    passwordtextfield.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    passwordtextfield.secureTextEntry=NO;
    passwordtextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    passwordtextfield.clearsOnBeginEditing=YES;
    passwordtextfield.placeholder=@"请输入新密码";
    self.newpassworld = passwordtextfield;
    [self.view addSubview:passwordtextfield];
    
    
    //密码输入框
    UITextField *passwordtextfieldX=[[UITextField alloc]initWithFrame:CGRectMake(10, 134, kScreenW, 40)];
    passwordtextfieldX.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    passwordtextfieldX.secureTextEntry=NO;
    passwordtextfieldX.autocorrectionType=UITextAutocorrectionTypeNo;
    passwordtextfieldX.clearsOnBeginEditing=YES;
    passwordtextfieldX.placeholder=@"请再次输入新密码";
    self.renewpassworld = passwordtextfieldX;
    [self.view addSubview:passwordtextfieldX];

    //分割线
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(10, 60, kScreenW-20, 1)];
    line.y = CGRectGetMaxY(usertextfield.frame);
    line.backgroundColor = SCLineGrayColor;
    [self.view addSubview:line];
    
    
    UIView *lineX =[[UIView alloc]initWithFrame:CGRectMake(10, 200, kScreenW-20, 1)];
    lineX.backgroundColor = SCLineGrayColor;
    lineX.y = CGRectGetMaxY(passwordtextfield.frame);
    [self.view addSubview:lineX];
    
    UIView *lineY =[[UIView alloc]initWithFrame:CGRectMake(10, 340, kScreenW-20, 1)];
    lineY.backgroundColor = SCLineGrayColor;
    lineY.y = CGRectGetMaxY(passwordtextfieldX.frame);
    [self.view addSubview:lineY];
    
    //确定按钮
    UIButton *logintouch=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logintouch setTitle:@"确定" forState:UIControlStateNormal];
    logintouch.titleLabel.font = [UIFont systemFontOfSize:AdapationLabelFont(17)];
    [logintouch setFrame:CGRectMake(0, self.view.centerY, kScreenW-50, 116/3)];
    logintouch.centerX = self.view.centerX;
    [logintouch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logintouch.backgroundColor = SCThemeColor;
    logintouch.layer.masksToBounds = YES;
    logintouch.layer.cornerRadius = 5;
    [logintouch addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logintouch];
}

-(void)nextClick:(UIButton *)btn{
    [self.view endEditing:YES];
  
    
    if (self.oldPassworld.text.length ==0) {
       [self showHint:@"旧密码不能为空"];

    }else if (self.newpassworld.text.length ==0){
        [self showHint:@"新密码不能为空"];
    }else if (self.renewpassworld.text.length ==0){
        [self showHint:@"确认密码不能为空"];
    }else if (self.renewpassworld.text.length <6 || self.renewpassworld.text.length >11){
        [self showHint:@"密码长度为6～11位"];
    }else if  (![self.renewpassworld.text isEqualToString:self.newpassworld.text]){
        [self showHint:@"与原密码相同"];
    }else {
        SCUserInfo * modelX=   [SCUserInfo getUserModel];
     
        NSString *token =modelX.token;
        
        NSDictionary * pare = @{@"token": token ,@"newpassword":_newpassworld.text,@"confirmassword":_renewpassworld.text,@"oldpassword":_oldPassworld.text};
//
        [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,REPASSWORLD]
                                   params:pare
                          loadingImageArr:nil toShowView:nil
                                  success:^(id response) {
                                      NSLog(@"%@",response);
                                      if([response[@"code"]  isEqual: @1001]){
                                          
                                          //推出登录
                                          [SCUserDefaults  setBool:false forKey:@ISLOGIN];
                                          //更改账号信息
                                          [SCUserDefaults setObject:_newpassworld.text forKey:@USEREPASSWORLD];
                                          //返回跟控制器
                                          [self.navigationController popToRootViewControllerAnimated:1];
                                      }
                                  } fail:^(NSError *error) {
                                      [SCProgressHUD showInformation:[NSString stringWithFormat:@"%@",error] toView:nil andAfterDelay:2];
                                  } showHUD:1] ;

       
   }
   
   
}

@end
