//
//  SCRegisterViewController.m
//  汽车配件
//
//  Created by cb on 2017/3/27.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCRegisterViewController.h"
#import "SCPooCodeView.h"
#import "SCCountDownButton.h"
#import "SCForgetRePasswordViewController.h"
#import "SCRePassworldViewController.h"
#import "SCLoginViewController.h"
#import "SCEnterpriseViewController.h"
#import "SCUserInfo.h"
@interface SCRegisterViewController (){
    SCPooCodeView *_pooCodeView;
    SCCountDownButton *_countDownCode;
}
@property(nonatomic,strong) UITextField * phoneTextFild;
@property(nonatomic,strong) UITextField * passworldTextFild;
@property(nonatomic,strong) UITextField * imageCodeTextFild;
@property(nonatomic,strong) UITextField * phoneCodeTextFild;
@end

@implementation SCRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  setUpNavigate];
    [self setUpChildView];
}

-(void)setUpNavigate{
    
    
    self.view.backgroundColor =[UIColor  whiteColor];
    self.title = @"注册";
    self.navigationItem.leftBarButtonItem = [SCColorTypeTools itemWithTitleName:@"取消" highTitleName:@"取消"   addTarget:self action:@selector(editClick:) tintColor:nil];
}
-(void)editClick:(UIButton *)btn{
    [self.navigationController   popViewControllerAnimated:1];
}

- (void)setUpChildView {
    //手机号
    UITextField *usertextfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 84, kScreenW, 40)];
    usertextfield.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    usertextfield.secureTextEntry=NO;
    usertextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    usertextfield.clearsOnBeginEditing=YES;
    usertextfield.placeholder=@"请输入手机号";
    self.phoneTextFild= usertextfield;
    [self.view addSubview:usertextfield];
    
    //密码
    UITextField *passworld=[[UITextField alloc]initWithFrame:CGRectMake(10, 144, kScreenW, 40)];
    passworld.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    passworld.secureTextEntry=NO;
    passworld.autocorrectionType=UITextAutocorrectionTypeNo;
    passworld.clearsOnBeginEditing=YES;
    passworld.placeholder=@"请输入密码";
    self.passworldTextFild= passworld;
    [self.view addSubview:passworld];
   
    //验证码
    UITextField *passwordtextfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 204, 150, 40)];
    passwordtextfield.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    passwordtextfield.secureTextEntry=NO;
    passwordtextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    passwordtextfield.clearsOnBeginEditing=YES;
    passwordtextfield.placeholder=@"请输入图片验证码";
    self.imageCodeTextFild = passwordtextfield;
    [self.view addSubview:passwordtextfield];
    
    
    //密码输入框
    UITextField *passwordtextfieldX=[[UITextField alloc]initWithFrame:CGRectMake(10, 264, 150, 40)];
    passwordtextfieldX.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    passwordtextfieldX.secureTextEntry=NO;
    passwordtextfieldX.autocorrectionType=UITextAutocorrectionTypeNo;
    passwordtextfieldX.clearsOnBeginEditing=YES;
    passwordtextfieldX.placeholder=@"请输入手机验证码";
    self.phoneCodeTextFild = passwordtextfieldX;
    [self.view addSubview:passwordtextfieldX];
    
    //分割线
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(10, 60, kScreenW-20, 1)];
    line.y = CGRectGetMaxY(passworld.frame)+10;
    line.backgroundColor = SCLineGrayColor;
    [self.view addSubview:line];
    UIView *lineX =[[UIView alloc]initWithFrame:CGRectMake(10, 200, kScreenW-20, 1)];
    lineX.backgroundColor = SCLineGrayColor;
    lineX.y = CGRectGetMaxY(usertextfield.frame)+10;
    [self.view addSubview:lineX];
    
    UIView *lineY =[[UIView alloc]initWithFrame:CGRectMake(10, 340, kScreenW-20, 1)];
    lineY.backgroundColor = SCLineGrayColor;
    lineY.y = CGRectGetMaxY(passwordtextfield.frame)+10;
    [self.view addSubview:lineY];
    
    UIView *lineZ =[[UIView alloc]initWithFrame:CGRectMake(10, 480, kScreenW-20, 1)];
    lineZ.backgroundColor = SCLineGrayColor;
    lineZ.y = CGRectGetMaxY(passwordtextfieldX.frame)+10;
    [self.view addSubview:lineZ];
    
    
    //竖线
    
    UIView *verticallineX =[[UIView alloc]initWithFrame:CGRectMake(kScreenW/5*3, 30, 1, 40)];
    verticallineX.backgroundColor = SCBlackColor;
    verticallineX.y = CGRectGetMaxY(passworld.frame)+20;
    [self.view addSubview:verticallineX];
    
    UIView *verticallineY =[[UIView alloc]initWithFrame:CGRectMake(kScreenW/5*3, 200, 1, 40)];
    verticallineY.backgroundColor = SCBlackColor;
    verticallineY.y = CGRectGetMaxY(passwordtextfield.frame)+20;
    [self.view addSubview:verticallineY];
    
    
    //下一步按钮
    UIButton *logintouch=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logintouch setTitle:@"注册" forState:UIControlStateNormal];
    logintouch.titleLabel.font = [UIFont systemFontOfSize:AdapationLabelFont(17)];
    [logintouch setFrame:CGRectMake(0, self.view.centerY, kScreenW-50, 116/3)];
    logintouch.centerX = self.view.centerX;
    [logintouch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logintouch.backgroundColor = SCThemeColor;
    logintouch.layer.masksToBounds = YES;
    logintouch.layer.cornerRadius = 116/3/2-5;
    [logintouch addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logintouch];
    
    //图片验证码
    _pooCodeView = [[SCPooCodeView alloc] initWithFrame:CGRectMake(CGRectGetMinX(verticallineX.frame)+(kScreenW/5*2-82)/2, 100, 82, 32)];
    _pooCodeView.centerY = passwordtextfield.centerY ;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [_pooCodeView addGestureRecognizer:tap];
    [self.view addSubview:_pooCodeView];
    
    //短信验证码
    
    _countDownCode = [SCCountDownButton buttonWithType:UIButtonTypeCustom];
    [_countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    _countDownCode.titleLabel.font = [UIFont systemFontOfSize:AdapationLabelFont(12)];
    [_countDownCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_countDownCode setFrame:CGRectMake(CGRectGetMinX(verticallineX.frame)+(kScreenW/5*2-82)/2, self.view.centerY, 82, 32)];
    _countDownCode.centerY = passwordtextfieldX.centerY ;
    _countDownCode.backgroundColor = SCThemeColor;
    _countDownCode.layer.masksToBounds = YES;
    _countDownCode.layer.cornerRadius = 5;
    
    [self.view addSubview:_countDownCode];
    
    
    [_countDownCode countDownButtonHandler:^(SCCountDownButton*sender, NSInteger tag) {
        if (_phoneTextFild.text.length ==0) {
            [self showHint:@"请输入手机号码"];
        }else if ( _phoneTextFild.text.length != 11){
            [self showHint:@"手机号码位数错误"];
        }else{
            [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,PHONECODE]
                                       params:@{
                                          @"type":@"1",
                                          @"phone":_phoneTextFild.text
                                                }
                              loadingImageArr:nil toShowView:nil
                                      success:^(id response) {
                               NSLog(@"%@",response[@"message"]);
                                          [SCUserInfo  SetUpAcountInfo:_phoneTextFild.text :_passworldTextFild.text];
                                      } fail:^(NSError *error) {
                                         [SCProgressHUD showInformation:[NSString stringWithFormat:@"%@",error] toView:nil andAfterDelay:2];
                                      } showHUD:1];
        }
        sender.enabled = NO;
        [sender startCountDownWithSecond:60];
        [sender countDownChanging:^NSString *(SCCountDownButton *countDownButton,NSUInteger second) {
            _countDownCode.backgroundColor = SCLightGrayColor;
            NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
            return title;
        }];
        [sender countDownFinished:^NSString *(SCCountDownButton *countDownButton, NSUInteger second) {
            _countDownCode.backgroundColor = SCThemeColor;
            countDownButton.enabled = YES;
            return @"点击重新获取";
        }];
        
    }];
}

- (void)tapClick:(UITapGestureRecognizer*)tap{
    [_pooCodeView changeCode];
    NSLog(@"%@",_pooCodeView.changeString);
//    self.imageCode = _pooCodeView.changeString;
    
    
}
//下一步进行的操作
-(void)nextClick:(UIButton *)btn{
    [self.view endEditing:YES];
    [SCUserInfo  SetUpAcountInfo:_phoneTextFild.text :_passworldTextFild.text];
//    [self.navigationController pushViewController:[SCEnterpriseViewController new] animated:1];
    
    if (_phoneTextFild.text.length == 0 ) {
        [self showHint:@"电话号码不能为空"];
    }else if ( _passworldTextFild.text.length ==0 ){
        [self showHint:@"密码不能为空"];
    }else if ( _imageCodeTextFild.text.length == 0){
        [self showHint:@"图片验证码不能为空"];
    }else if (_phoneCodeTextFild.text.length ==0 ) {
        [self showHint:@"请输入手机验证码"];
    }else if (_phoneTextFild.text.length !=11 ){
        [self showHint:@"手机号码位数错误"];
    }else if (_passworldTextFild.text.length <6 || _passworldTextFild.text.length >11){
        [self showHint:@"密码长度为6-11位"];
    }else if (_phoneCodeTextFild.text.length != 4){
        [self showHint:@"验证码长度为4"];
    }
    else{
        [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,REGISTER]
                                   params:@{
                                            @"phone":_phoneTextFild.text,
                                            @"password":_passworldTextFild.text,
                                            @"code":_phoneCodeTextFild.text
                                            }
                          loadingImageArr:nil toShowView:nil
                                  success:^(id response) {
                                      NSLog(@"%@",response);
                                      if([response[@"code"]  isEqual: @1001]){
                    [self.navigationController pushViewController:[SCEnterpriseViewController new] animated:1];
                                      }
                                  } fail:^(NSError *error) {
                                      [SCProgressHUD showInformation:[NSString stringWithFormat:@"%@",error] toView:nil andAfterDelay:2];
                                  } showHUD:1] ;
    }
}

@end
