//
//  MyEnterpriseInfoViewController.m
//  SHENCHAO
//
//  Created by cb on 2017/6/26.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "MyEnterpriseInfoViewController.h"

@interface MyEnterpriseInfoViewController ()

@end

@implementation MyEnterpriseInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的企业";
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu"] highImage:[UIImage imageNamed:@"menu"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)back
{
    [self dismissViewControllerAnimated:1 completion:nil];
}
@end
