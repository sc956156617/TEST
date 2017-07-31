//
//  SCWorkerManageViewController.m
//  汽车配件
//
//  Created by cb on 2017/3/31.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCWorkerManageViewController.h"

@interface SCWorkerManageViewController ()
@property(nonatomic,strong) UITextField *nameLX ;
@property(nonatomic,strong) UITextField *phoneX ;
@end

@implementation SCWorkerManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setNavigation];
    [self setUpchildViewes];
}

-(void)setNavigation{
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:SCThemeColor, NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:AdapationLabelFont(19)],NSFontAttributeName,nil];
    self.title = @"添加员工";
    
    //左按钮
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:SCLightGrayColor forState:UIControlStateNormal];
    button.titleLabel.font =[UIFont systemFontOfSize: 15.0f] ;
    //  设置按钮的尺寸
    button.frame=CGRectMake(0, 0, 60, 44);
    [button sizeToFit];
    [button addTarget:self action:@selector(leftclick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    //右按钮
    UIButton *buttonX = [[UIButton alloc]init];
    [buttonX setTitle:@"完成" forState:UIControlStateNormal];
    [buttonX setTitleColor:SCLightGrayColor forState:UIControlStateNormal];
    buttonX.titleLabel.font =[UIFont systemFontOfSize: 15.0f] ;
    //  设置按钮的尺寸
    buttonX.frame=CGRectMake(0, 0, 60, 44);
    [buttonX sizeToFit];
    [buttonX addTarget:self action:@selector(rightclick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonX];
    
}
-(void)leftclick{
    [self.navigationController   popViewControllerAnimated:1];
}
-(void)rightclick{
    self.passBlock(self.nameLX.text,self.phoneX.text);
    
    [self.navigationController   popViewControllerAnimated:1];
}
-(void)setUpchildViewes {
    self.view.backgroundColor = SCLineGrayColor;
    
    UIView  *contentV=[[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenW, 100)];
    contentV.backgroundColor =[UIColor  whiteColor];
    [self.view addSubview:contentV];
    
    UIView  *line=[[UIView alloc]initWithFrame:CGRectMake(10, 10, kScreenW-20, 1)];
    line.centerY = contentV.centerY-10;
    line.backgroundColor =SCLineGrayColor;
    [contentV addSubview:line];
    
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
    nameL.text = @"员工姓名";
    nameL.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
    [nameL  sizeToFit];
    [contentV addSubview:nameL];
    
    
    UITextField *nameLX = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameL.frame)+45, 20, 3000, 20)];
    nameLX.placeholder = @"填写真实姓名";
    self.nameLX = nameLX;
    nameLX.textColor = SCLightGrayColor;
    nameLX.font =[UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
    [contentV addSubview:nameLX];

    
    UILabel *phoneL = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 100, 20)];
    phoneL.text = @"员工手机号";
    phoneL.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
    [phoneL  sizeToFit];
    [contentV addSubview:phoneL];
    
    
    UITextField *phoneLX = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneL.frame)+30, 60, 3000, 20)];
    phoneLX.placeholder = @"填写员工的手机号码";
    phoneLX.centerX = nameLX.centerX;
    phoneLX.textColor = SCLightGrayColor;
    self.phoneX = phoneLX;
    phoneLX.font =[UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
    [contentV addSubview:phoneLX];
    
}
@end
