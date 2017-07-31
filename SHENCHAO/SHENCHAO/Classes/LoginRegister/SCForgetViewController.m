//
//  SCForgetViewController.m
//  汽车配件
//
//  Created by cb on 2017/3/27.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCForgetViewController.h"
#import "SCPooCodeView.h"
#import "SCCountDownButton.h"
#import "SCForgetRePasswordViewController.h"
#import "SCRePassworldViewController.h"
#import "SCUserInfo.h"



@interface SCForgetViewController (){
    SCPooCodeView *_pooCodeView;
    SCCountDownButton *_countDownCode;
}
@property(nonatomic,strong) UITextField * phoneTextFild;
@property(nonatomic,strong) UITextField * reWriteTextFild;
@property(nonatomic,strong) UITextField * testTextFild;
@property(nonatomic,copy) NSString * imageCode;
@end

@implementation SCForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setUpNavigate];
    [self setUpChildView];
}
-(void)setUpNavigate{

  self.title = @"忘记密码";
    self.view.backgroundColor =[UIColor whiteColor];
  self.navigationItem.leftBarButtonItem = [SCColorTypeTools itemWithImageName:@"fanhui" highImageName:@"fanhui"  addTarget:self action:@selector(editClick:) tintColor:SCBlackColor];
}
-(void)editClick:(UIButton *)btn{
    [self dismissViewControllerAnimated:1 completion:nil];
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
    
    //验证码
    UITextField *passwordtextfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 144, 150, 40)];
    passwordtextfield.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    passwordtextfield.secureTextEntry=NO;
    passwordtextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    passwordtextfield.clearsOnBeginEditing=YES;
    passwordtextfield.placeholder=@"不区分大小写";
    self.reWriteTextFild = passwordtextfield;
    [self.view addSubview:passwordtextfield];
    
    //密码输入框
    UITextField *passwordtextfieldX=[[UITextField alloc]initWithFrame:CGRectMake(10, 204, 150, 40)];
    passwordtextfieldX.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(16)];
    passwordtextfieldX.secureTextEntry=NO;
    passwordtextfieldX.autocorrectionType=UITextAutocorrectionTypeNo;
    passwordtextfieldX.clearsOnBeginEditing=YES;
    passwordtextfieldX.placeholder=@"请输入手机验证码";
    self.testTextFild = passwordtextfieldX;
    [self.view addSubview:passwordtextfieldX];
 
    //分割线
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(10, 60, kScreenW-20, 1)];
    line.y = CGRectGetMaxY(usertextfield.frame)+10;
    line.backgroundColor = SCLineGrayColor;
    [self.view addSubview:line];
    UIView *lineX =[[UIView alloc]initWithFrame:CGRectMake(10, 200, kScreenW-20, 1)];
    lineX.backgroundColor = SCLineGrayColor;
    lineX.y = CGRectGetMaxY(passwordtextfield.frame)+10;
    [self.view addSubview:lineX];
    
    UIView *lineY =[[UIView alloc]initWithFrame:CGRectMake(10, 340, kScreenW-20, 1)];
    lineY.backgroundColor = SCLineGrayColor;
    lineY.y = CGRectGetMaxY(passwordtextfieldX.frame)+10;
    [self.view addSubview:lineY];
    
    
    //竖线
    
    UIView *verticallineX =[[UIView alloc]initWithFrame:CGRectMake(kScreenW/5*3, 30, 1, 40)];
    verticallineX.backgroundColor = SCBlackColor;
    verticallineX.y = CGRectGetMaxY(usertextfield.frame)+20;
    [self.view addSubview:verticallineX];
    
    UIView *verticallineY =[[UIView alloc]initWithFrame:CGRectMake(kScreenW/5*3, 200, 1, 40)];
    verticallineY.backgroundColor = SCBlackColor;
    verticallineY.y = CGRectGetMaxY(passwordtextfield.frame)+20;
    [self.view addSubview:verticallineY];
    
    
    //下一步按钮
    UIButton *logintouch=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logintouch setTitle:@"下一步" forState:UIControlStateNormal];
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
       
        [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,PHONECODE]
                                   params:@{
                                            @"type":@"2",
                                            @"phone":_phoneTextFild.text
                                            }
                          loadingImageArr:nil toShowView:nil
                                  success:^(id response) {
                                      NSLog(@"%@",response[@"message"]);
//                                                [SCProgressHUD showInformation:[NSString stringWithFormat:@"%@",response[@"message"]] toView:nil andAfterDelay:2];
                                  } fail:^(NSError *error) {
                                      [SCProgressHUD showInformation:[NSString stringWithFormat:@"%@",error] toView:nil andAfterDelay:2];
                                  } showHUD:1];
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
    self.imageCode = _pooCodeView.changeString;
}

- (void)tapClick:(UITapGestureRecognizer*)tap{
    [_pooCodeView changeCode];
    NSLog(@"%@",_pooCodeView.changeString);
    self.imageCode = _pooCodeView.changeString;
    
    
}
//下一步进行的操作
-(void)nextClick:(UIButton *)btn{
    [self.view endEditing:YES];

    
//    NSLog(@"#%@#====#%@#",self.testTextFild.text.uppercaseString,self.phoneCode.uppercaseString);
    
    if (_phoneTextFild.text.length == 0 ) {
        [self showHint:@"电话号码不能为空"];
    }else if ( _reWriteTextFild.text.length ==0 ){
        [self showHint:@"图片验证码不能为空"];
    }else if ( _testTextFild.text.length == 0){
        [self showHint:@"短信验证码不能为空"];
    }else if (_phoneTextFild.text.length != 11) {
        [self showHint:@"电话号码长度错误"];
    }else if (![self.reWriteTextFild.text.uppercaseString isEqualToString: self.imageCode.uppercaseString]){
        [self showHint:@"图片验证码错误"];
    }else if (self.testTextFild.text.length != 4  ){
        [self showHint:@"短信验证码长度为6"];
    }else{
    
        
        SCForgetRePasswordViewController *vc =[SCForgetRePasswordViewController new];
        vc.phone = _phoneTextFild.text;
        vc.phoneCode = self.testTextFild.text;
        [self.navigationController pushViewController:vc animated:1];


        
    }
  
    
    

}
@end
