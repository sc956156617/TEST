//
//  SCWorkerListViewController.m
//  汽车配件
//
//  Created by cb on 2017/3/31.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCWorkerListViewController.h"
#import "SCWorkingInfoTableViewCell.h"
#import "SCWorkerModel.h"
#import "SCWorkerManageViewController.h"

#import "AppDelegate.h"
//#import "ViewTabBarController.h"
@interface SCWorkerListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;


@property (nonatomic,strong) NSMutableArray *dataSourseArr;

@end

@implementation SCWorkerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self  setNavigation];
    [self setUpchildViewes];
    
    [self  setAdviceBtn];
}

-(void)setAdviceBtn{
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(10, kScreenH-200, kScreenW/2+60, 40)];
    btn.layer.cornerRadius=10;
    [btn setBackgroundColor:SCThemeColor];
    [btn setTitle:@"添加员工" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightclick) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    btn.centerX = self.view.centerX;
    [self.view addSubview:btn];
    
}
-(void)prepareData{
    
    self.dataSourseArr = [NSMutableArray array];
    SCWorkerModel *model =[SCWorkerModel new];
    
    model.iconUrl = @"http://img.zcool.cn/community/01b2ea564497cf6ac7259e0f3825f1.jpg";
    model.type = @"管理员";
    model.name = @"gogogo";
    
    SCWorkerModel *modelX =[SCWorkerModel new];
    
    modelX.iconUrl = @"http://img.zcool.cn/community/01b2ea564497cf6ac7259e0f3825f1.jpg";
    modelX.type = @"客服";
    modelX.name = @"小小鸟";

    [self.dataSourseArr addObject:model];
    [self.dataSourseArr addObject:modelX];

}
-(void)setNavigation{
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:SCThemeColor, NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:AdapationLabelFont(19)],NSFontAttributeName,nil];
    self.title = @"客服列表";
    
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
    [buttonX addTarget:self action:@selector(finishclick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonX];
    
}
-(void)finishclick{

//    ViewTabBarController *VC = [[ViewTabBarController alloc]init];
//    AppDelegate * app =(AppDelegate *)[UIApplication sharedApplication].delegate;
//    app.window.rootViewController = VC;
//    [app.window makeKeyAndVisible];

}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _tableview.delegate =self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = SCLineGrayColor;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableview registerClass:[SCWorkingInfoTableViewCell class] forCellReuseIdentifier:@"SCWorkingInfoTableViewCell"];
    }
    return _tableview;
}
-(void)leftclick{
    [self.navigationController   popViewControllerAnimated:1];
}
-(void)rightclick{
    
    SCWorkerManageViewController *vc =[SCWorkerManageViewController new];
    vc.passBlock = ^(NSString *name ,NSString *phone){
        
        SCWorkerModel *model =[SCWorkerModel new];
        
        model.iconUrl = @"http://img.zcool.cn/community/01b2ea564497cf6ac7259e0f3825f1.jpg";
        model.type = @"客服";
        model.name = name;
        [self.dataSourseArr addObject:model];
        
        [self.tableview reloadData];
    };
    
    [self.navigationController pushViewController:vc animated:1];
}
-(void)setUpchildViewes {
    [self.view addSubview:self.tableview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSourseArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCWorkingInfoTableViewCell *cell =[[SCWorkingInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SCWorkingInfoTableViewCell"];
    cell.model = self.dataSourseArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewRowAction *dele = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        QiugouModel *mode = self.dataArray[indexPath.row];
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
//        hud.labelText = @"正在删除";
//        NSDictionary * para = @{@"supply_id":mode.id};
//        
//        [RequestData requestWithUrl:DeletebusinessURL para:para Complete:^(NSData *data) {
//            NSDictionary *registerDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSUInteger code = [registerDic[@"code"] integerValue];
//            if (code == 0) {
//                // 删除模型
//                [_dataArray removeObjectAtIndex:indexPath.row];
//                // 刷新表格
//                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//            }
//            [self showHint:registerDic[@"message"]];
//            
//            [self.tableView reloadData];
//            [self hideHud];
//            hud.hidden = YES;
//        } fail:^(NSError *error) {
//            
//            [self showHint:@"删除失败，请检查网络！"];
//            hud.hidden = YES;
//            [self hideHud];
//        }];
    }];
    UITableViewRowAction *top = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"刷新" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"刷新");
    }];
    dele.backgroundColor = [UIColor redColor];
    top.backgroundColor = [UIColor grayColor];
    
    
    return @[dele, top];
}
@end
