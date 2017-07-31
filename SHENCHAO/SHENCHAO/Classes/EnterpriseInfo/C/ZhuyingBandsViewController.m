
//
//  OneBandsViewController.m
//  汽车配件
//
//  Created by cb on 2017/4/27.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "ZhuyingBandsViewController.h"
#import "SCBandsTableViewCell.h"
#import "BandsModel.h"

//本地存储字典
#import "NSObject+SaveModelArray.h"
//数据筛选结构
#import "ZYPinYinSearch.h"
#import "HCSortString.h"


@interface ZhuyingBandsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL close[10000];
    UITableView *_tableView;
    UITableView *_detailTableView;
}

/*
 数据源
 */
@property(nonatomic,strong) NSArray *datasourse;
/*
 排序后的数据源
 */
@property(nonatomic,strong) NSDictionary *allDataSource;
/*
 字母分组数据源
 */
@property(nonatomic,strong) NSArray *indexDataSource;
/*
 本地存储已点击
 */
@property(nonatomic,strong) NSMutableArray *localSourse;
@end

@implementation ZhuyingBandsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专营列表";
    //这个的目的是为了使得启动app时，单元格是收缩的
    for (int i=0; i<10000; i++) {
        close[i] = YES;
    }
    //创建
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionIndexColor = SCGrayColor;
    [self showHudInView:self.view hint:nil];
    [JZLNetworkingTool getWithUrl:BandsList params:nil isReadCache:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
        _datasourse =[BandsModel mj_objectArrayWithKeyValuesArray:responseObject[@"carModelJson"]];
        //排序后的数据源
        _allDataSource   =   [HCSortString sortAndGroupForArray:_datasourse PropertyName:@"name"];
        //字母分组数据源
        _indexDataSource = [HCSortString sortForStringAry:[_allDataSource allKeys]];
        [self.view addSubview:_tableView];
        [self hideHud];
        
    } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
        [self hideHud];
        [self showHint:@"列表服务器没开"];
    }];
    
    
    self.navigationItem.leftBarButtonItem = [SCColorTypeTools itemWithImageName:@"fanhuihei" highImageName:@"fanhui"  addTarget:self action:@selector(backClick) tintColor:nil];
}
-(void)backClick{
    //    通过归档将模型数组写入本地文件中
    [NSArray saveArrayData:self.localSourse andSaveName:@"bands.pl"];
    //    if (self.callBackBlok) {
    //        self.callBackBlok(self.dataSource);
    //    }
    [self.navigationController popViewControllerAnimated:1];
}

#pragma mark   deldegate
//数据源方法的实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.indexDataSource.count;
}
//组头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *value = [_allDataSource objectForKey:_indexDataSource[section]];
    return value.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
    return 30*value.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return _indexDataSource[section];
    
}
//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _indexDataSource;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
    BandsModel *model =value[indexPath.row];
    
    NSLog(@"%@",model.level);
    
    if ([model.level isEqualToString:@"1"]) {
        static NSString *ID = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.text =  model.name;
        return cell;
    }else{
        
        static NSString *ID = @"cell2";
        SCBandsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            
            cell = [[SCBandsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        BandsModel *model = [BandsModel new];
        model.name =value[indexPath.row][@"name"];
        model.ID = value[indexPath.row][@"id"];
        
        //             if ( [self.localSourse  containsObject:tempArr[indexPath.row]]) {
        //                 model.isSelsect = YES;
        //             }else{
        //                model.isSelsect = NO;
        //             }
        cell.model = model;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
    BandsModel *model =value[indexPath.row];
        if (self.callBackBlok) {
            self.callBackBlok(model);
        }
    [self.navigationController popViewControllerAnimated:0];
}
#pragma mark  title标题
////创建组头视图
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
//    view.tag = 1000 + section;
//    view.backgroundColor = SCBackgroundGrayColor;
//    [view addTarget:self action:@selector(sectionClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, 70, 30)];
//    label.textColor = SCBlackColor;
//    label.font = [UIFont systemFontOfSize:14];
//    label.text =  self.datasourse[section][@"name"];
//    [view addSubview:label];
//    return view;
//}
//-(void)sectionClick:(UIControl *)view{
//    //获取点击的组
//    NSInteger i = view.tag - 1000;
//    //取反
//    close[i] = !close[i];
//    //刷新列表
//    NSIndexSet * index = [NSIndexSet indexSetWithIndex:i];
//    [_tableView reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
//}
#pragma mark 懒加载


-(NSMutableArray *)localSourse{
    
    if (!_localSourse) {
        _localSourse =[NSMutableArray array];
    }
    
    return _localSourse;
}
@end
