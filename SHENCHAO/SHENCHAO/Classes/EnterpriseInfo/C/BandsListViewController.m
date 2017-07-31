
//
//  BandsListViewController.m
//  汽车配件
//
//  Created by cb on 2017/4/24.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "BandsListViewController.h"
#import "SCBandsTableViewCell.h"
#import "BandsModel.h"
#import "BandsFrameModel.h"
#import "OneBandsTableViewCell.h"

//本地存储字典
#import "NSObject+SaveModelArray.h"
//数据筛选结构
#import "ZYPinYinSearch.h"
#import "HCSortString.h"

#import "XFDialogOptionButton.h"



@interface BandsListViewController ()<UITableViewDataSource,UITableViewDelegate,OneBandsTableViewCellDelegate>{
    BOOL isOpen;
    UITableView *_tableView;
    UITableView *_detailTableView;
}

@property (nonatomic, strong)NSIndexPath * selectedIndex;

/*
 字典数据源
 */
@property(nonatomic,strong) NSArray *datasourseDicArr;
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

@implementation BandsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专营列表";
    isOpen = YES;

    //创建
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionIndexColor = SCGrayColor;
    [self showHudInView:self.view hint:nil];
//    [JZLNetworkingTool getWithUrl:BandsList params:nil isReadCache:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
    
    _datasourseDicArr = [SCColorTypeTools  JsonObjectwith:@"品牌.json"];
        _datasourse =[BandsModel mj_objectArrayWithKeyValuesArray:_datasourseDicArr];
        //排序后的数据源
        _allDataSource   =   [HCSortString sortAndGroupForArray:_datasourse PropertyName:@"name"];
        //字母分组数据源
        _indexDataSource = [HCSortString sortForStringAry:[_allDataSource allKeys]];
        [self.view addSubview:_tableView];
//        [self hideHud];
//        
//    } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
//        [self hideHud];
//        [self showHint:@"列表服务器没开"];
//    }];
    
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath == _selectedIndex && _selectedIndex != nil ) {
        if (isOpen == YES) {
            
            NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
            BandsModel *model =value[indexPath.row];//二级
            
            /*
             *
             三级
             */
            NSMutableArray * dataArr = [NSMutableArray array];;
            for (NSDictionary * dic  in  self.datasourseDicArr) {
                
                if ( [[NSString stringWithFormat:@"%@",dic[@"id"]]  isEqualToString:model.ID] ) {
                    NSArray * childArr = dic[@"child"];
                    
                    
                    for (int i=0; i<childArr.count; i++) {
                        NSDictionary * tempdic = childArr[i];
                        BandsModel *model=[BandsModel new];
                        model.name =tempdic[@"name"];
                        model.ID =tempdic[@"id"];
                        [dataArr addObject:model];
                    }
                }
            }
            return (dataArr.count+1) * 30;

        }else{
            
            return 30;
        }
    }else{
        
        return 30;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *value = [_allDataSource objectForKey:_indexDataSource[section]];
    return value.count;
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
    BandsModel *model =value[indexPath.row];//二级
    
    /*
     *
     三级
     */
    NSMutableArray * dataArr = [NSMutableArray array];;
    for (NSDictionary * dic  in  self.datasourseDicArr) {
        
        if ( [[NSString stringWithFormat:@"%@",dic[@"id"]]  isEqualToString:model.ID] ) {
            NSArray * childArr = dic[@"child"];
            
            
            for (int i=0; i<4; i++) {
                
                if (i<childArr.count) {
                    NSDictionary * tempdic = childArr[i];
                    BandsModel *model=[BandsModel new];
                    model.name =tempdic[@"name"];
                    model.ID =tempdic[@"id"];
                    [dataArr addObject:model];
                }else{
                    BandsModel *model=[BandsModel new];
                    model.name =@"000000";
                    model.ID =@"000000";
                    [dataArr addObject:model];
                }
                
            }

        }
    }
    /*
     *
     数据准备
     */
    BandsFrameModel * modelX = [BandsFrameModel new];
    modelX.mainModel = model;
    modelX.childModels = dataArr;
    
        static NSString *ID = @"cell1";
        OneBandsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[OneBandsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.delegate = self;
        cell.model = modelX;
        return cell;
}
#pragma mark  选择操作
-(void)OneBandsClick:(NSString *)ID{
    NSLog(@"=======%@",ID);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];

    if (self.selectedIndex != nil && indexPath.row == _selectedIndex.row) {
        //将选中的和所有索引都加进数组中
        //        indexPaths = [NSArray arrayWithObjects:indexPath,selectedIndex, nil];
        isOpen = !isOpen;
    }else if (self.selectedIndex != nil && indexPath.row != _selectedIndex.row) {
        indexPaths = [NSArray arrayWithObjects:indexPath,_selectedIndex, nil];
        isOpen = YES;
    }
    //记下选中的索引
    self.selectedIndex = indexPath;
    //刷新
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
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
-(void)sectionClick:(UIControl *)view{
    //获取点击的组
    NSInteger i = view.tag - 1000;
    //取反
    NSIndexSet * index = [NSIndexSet indexSetWithIndex:i];
    [_tableView reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark 懒加载


-(NSMutableArray *)localSourse{

    if (!_localSourse) {
        _localSourse =[NSMutableArray array];
    }
    
    return _localSourse;
}
@end
