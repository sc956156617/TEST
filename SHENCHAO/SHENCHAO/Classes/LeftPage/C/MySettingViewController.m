
//
//  MySettingViewController.m
//  SHENCHAO
//
//  Created by cb on 2017/6/26.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "MySettingViewController.h"
#import "UIBarButtonItem+Item.h"
#import "SCUserInfo.h"
@interface MySettingViewController ()


@property(nonatomic,strong) NSArray * datasoure;
@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datasoure = @[@"使用移动网络浏览图片",@"清除缓存",@"推荐给朋友",@"联系我们",@"退出"];
    self.title = @"设置";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu"] highImage:[UIImage imageNamed:@"menu"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}
-(void)back{
    [self dismissViewControllerAnimated:1 completion:nil];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    UIView * view =View.xy(80, 30).wh(kScreenW,10).bgColor(@"blue,0.2").borderRadius(5).shadow(0.8).onClick(^{
        Log(@"w哦爱你");
    });
    
    return view;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (section) {
        case 2:
            return  3;
            break;
        default:
            return   1;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
         }
    cell.textLabel.text = indexPath.row==0 ? self.datasoure[indexPath.section] :self.datasoure[indexPath.row+2];
    if (indexPath.section ==0) {
        cell.accessoryView =[UISwitch new];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 2) {
        //退出登录
        [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,LOGOUT]
                                   params:@{@"token": [SCUserInfo getUserModel].token,
                                            }
                          loadingImageArr:nil toShowView:nil
                                  success:^(id response) {
                                      
                                      if([response[@"code"]  isEqual: @1001]){
//                                          NSLog(@"%@",response);
                                          //清除账号信息
                                          [SCUserInfo clearAcountInfo];
                                          //清除用户信息
                                          [SCUserInfo clearUserInfo];
                                          //清除其他通知等
                                          
                                      }
                                      
                                  } fail:^(NSError *error) {
                                      
                                  } showHUD:1] ;
    }
}
@end
