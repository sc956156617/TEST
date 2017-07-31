//
//  SCForgetRePasswordViewController.m
//  汽车配件
//
//  Created by cb on 2017/3/28.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCForgetRePasswordViewController.h"
#import "SCLoginViewController.h"
#import "SCUserInfo.h"
@interface SCForgetRePasswordViewController ()
@property(nonatomic,strong) UITextField * oldPassworld;
@property(nonatomic,strong) UITextField * newpassworld;
@end

@implementation SCForgetRePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setNavigation];
    [self  setUpChildViews];
}
- (void)setNavigation {
    self.title = @"新密码";
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [SCColorTypeTools itemWithImageName:@"fanhui" highImageName:@"fanhui"  addTarget:self action:@selector(editClick:)  tintColor:nil];
}
-(void)editClick:(UIButton *)btn{
    [self.navigationController   popViewControllerAnimated:1];
}
- (void)setUpChildViews {
    //手机号
    UITextField *usertextfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 84, kScreenW, 40)];
    usertextfield.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    usertextfield.secureTextEntry=NO;
    usertextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    usertextfield.clearsOnBeginEditing=YES;
    usertextfield.placeholder=@"请输入新密码";
    self.oldPassworld= usertextfield;
    [self.view addSubview:usertextfield];
    
    
    //验证码
    UITextField *passwordtextfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 144, kScreenW, 40)];
    passwordtextfield.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    passwordtextfield.secureTextEntry=NO;
    passwordtextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    passwordtextfield.clearsOnBeginEditing=YES;
    passwordtextfield.placeholder=@"请再次输入新密码";
    self.newpassworld = passwordtextfield;
    [self.view addSubview:passwordtextfield];
    
    
    
    //分割线
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(10, 60, kScreenW-20, 1)];
    line.y = CGRectGetMaxY(usertextfield.frame)+10;
    line.backgroundColor = SCLineGrayColor;
    [self.view addSubview:line];
    UIView *lineX =[[UIView alloc]initWithFrame:CGRectMake(10, 200, kScreenW-20, 1)];
    lineX.backgroundColor = SCLineGrayColor;
    lineX.y = CGRectGetMaxY(passwordtextfield.frame)+10;
    [self.view addSubview:lineX];
    
//    UIView *lineY =[[UIView alloc]initWithFrame:CGRectMake(10, 340, kScreenW-20, 1)];
//    lineY.backgroundColor = SCLineGrayColor;
//    lineY.y = CGRectGetMaxY(passwordtextfieldX.frame)+10;
//    [self.view addSubview:lineY];
    
    //确定按钮
    UIButton *logintouch=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logintouch setTitle:@"确定" forState:UIControlStateNormal];
    logintouch.titleLabel.font = [UIFont systemFontOfSize:AdapationLabelFont(17)];
    [logintouch setFrame:CGRectMake(0, self.view.centerY, kScreenW-50, 116/3)];
    logintouch.centerX = self.view.centerX;
    [logintouch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logintouch.backgroundColor = SCThemeColor;
    logintouch.layer.masksToBounds = YES;
    logintouch.layer.cornerRadius = 116/3/2-5;
    [logintouch addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logintouch];
}

-(void)nextClick:(UIButton *)btn{
    [self.view endEditing:YES];
    
    
    
    if ([self.oldPassworld.text isEqualToString:self.newpassworld.text]) {
        NSDictionary * pare = @{@"phone" : self.phone,
                                @"code" : self.phoneCode,
                                @"password" : self.oldPassworld.text,
                                };
        [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,FORGETPASSWORLD]
                                   params:pare
                          loadingImageArr:nil toShowView:nil
                                  success:^(id response) {
                                      [SCUserDefaults setObject:_newpassworld.text forKey:@USEREPASSWORLD];
                                      //返回跟控制器                                      [self.navigationController popToRootViewControllerAnimated:1];
                                  } fail:^(NSError *error) {
                                      [SCProgressHUD showInformation:[NSString stringWithFormat:@"%@",error] toView:nil andAfterDelay:2];
                                  } showHUD:1];

    }else if( self.oldPassworld.text.length < 7 ||  self.newpassworld.text.length < 7){
    
        [SCProgressHUD showInformation:@"密码长度应大于6" toView:nil andAfterDelay:2];
    
    }else{
    
        [self showHint:@"新旧密码不一致"];
    }
                  //密码修改按钮
    
}


@end
