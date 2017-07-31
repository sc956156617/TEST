//
//  BestListViewController.m
//  汽车配件
//
//  Created by cb on 2017/4/24.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "BestListViewController.h"
#import "JZLNetworkingTool.h"
#import "PeijianModel.h"

#import "ZYPinYinSearch.h"
#import "HCSortString.h"


#import "FDCellModel.h"
#import "FDTableViewCell.h"
#import "NSObject+SaveModelArray.h"

//随意弹出视图
#import "KWPopoverView.h"
#import "DXPopover.h"

@interface BestListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,passModelVewdeldegate>
@property (strong, nonatomic) UITableView *friendTableView;
@property (strong, nonatomic) UISearchBar *searchBar;


//模型数组
@property (nonatomic,strong) NSArray *models;
@property (nonatomic,strong)UILabel *maskLab;
@property (nonatomic,strong)NSArray *biLv;


@property (strong, nonatomic) NSArray *dataSource;/**<排序前的整个数据源*/
@property (strong, nonatomic) NSDictionary *allDataSource;/**<排序后的整个数据源*/
@property (strong, nonatomic) NSMutableArray *searchDataSource;/**<搜索结果数据源*/
@property (strong, nonatomic) NSArray *indexDataSource;/**<索引数据源*/
@property (assign, nonatomic) BOOL isSearch;

@end

@implementation BestListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"选择精品";
    //解决search bar。跳动问题
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    [self setExtendedLayoutIncludesOpaqueBars:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showHudInView:self.view hint:nil];
    
//    [CCPNetworking  getOrPostWithType:GET WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,JINGPIN]
//                               params:nil
//                      loadingImageArr:nil toShowView:nil
//                              success:^(id response) {
//                                  NSLog(@"%@",response);
//                                  if([response[@"code"]  isEqual: @1001]){
//                                      
//                                      NSArray * arr = response[@"data"];
//                                      NSMutableArray *datasourse  = [NSMutableArray array];
//                                      
//                                      for (NSDictionary *  dic in responseObject) {
//                                          FDCellModel *model =[FDCellModel new];
//                                          model.number = [NSString stringWithFormat:@"%@",dic[@"id"]];
//                                          model.name =  dic[@"name"];
//                                          [datasourse  addObject:model];
//                                      }
//                                      if (self.dataSource) {
//                                          
//                                      }else{
//                                          self.dataSource = datasourse;
//                                      }
//                                      
// 
//                                      
//                                  }
//                                  
//                              } fail:^(NSError *error) {
//                                  
//                              } showHUD:1] ;
    
    
    [JZLNetworkingTool getWithUrl:[NSString stringWithFormat:@"%@",BESTList] params:nil isReadCache:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSMutableArray *datasourse  = [NSMutableArray array];
        
        for (NSDictionary *  dic in responseObject) {
            FDCellModel *model =[FDCellModel new];
            model.number = [NSString stringWithFormat:@"%@",dic[@"id"]];
            model.name =  dic[@"name"];
            [datasourse  addObject:model];
        }
        if (self.dataSource) {
            
        }else{
            self.dataSource = datasourse;
        }
        
        //        FDCellModel *model =self.dataSource[0];
        //        NSLog(@"%@",model.name);
        [self initData];
        
        //        FDCellModel *modelX =self.dataSource[0];
        //        NSLog(@"======%@",modelX.name);
        [self.view addSubview:self.friendTableView];
        //        [self.view addSubview:self.searchBar];
        
        //        self.friendTableView.tableHeaderView =self.searchBar;
        
        [self hideHud];
        
    } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
        [self hideHud];
        [self showHint:@"列表服务器没开"];
    }];
    
    
//    [self initData];
//    [self.view addSubview:self.friendTableView];

    self.navigationItem.leftBarButtonItem = [SCColorTypeTools itemWithImageName:@"fanhuihei" highImageName:@"fanhui"  addTarget:self action:@selector(backClick) tintColor:nil];
}
-(void)backClick{
    //通过归档将模型数组写入本地文件中
    [NSArray saveArrayData:self.dataSource andSaveName:@"jingpin.pl"];
    if (self.callBackBlok) {
        self.callBackBlok(self.dataSource);
    }
    [self.navigationController popViewControllerAnimated:1];
}

//-(void)clickDone{
//
//    [self dismissViewControllerAnimated:YES completion:nil];
//}



#pragma mark - Init


- (void)initData {
    
    //加载模型数据 ，数据源,未排序的.
    
    _searchDataSource = [NSMutableArray new];
    //排序后的数据源
    _allDataSource   =   [HCSortString sortAndGroupForArray:self.dataSource PropertyName:@"name"];
    //字母分组数据源
    _indexDataSource = [HCSortString sortForStringAry:[_allDataSource allKeys]];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!_isSearch) {
        return _indexDataSource.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_isSearch) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[section]];
        return value.count;
    }else {
        return _searchDataSource.count;
    }
}
//头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!_isSearch) {
        return _indexDataSource[section];
    }else {
        return nil;
    }
}
//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!_isSearch) {
        return _indexDataSource;
    }else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    FDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        
        cell = [[FDTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];

    }
    if (!_isSearch) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
        
        FDCellModel *model =value[indexPath.row];
        cell.model = model;
        cell.biLv = self.biLv[indexPath.row];
        
        
    }else{
        FDCellModel *model =  _searchDataSource[indexPath.row];
        cell.model = model;
        cell.biLv = self.biLv[indexPath.row];
    }
    //给cell的模型属性赋值
cell.deldegate = self;
//cell.block = ^(id name, id sender) {
//    
//    FDCellModel *model = name;
//    
//    UIButton *btn =(UIButton *)sender;
//    
//    
//    UIWindow* window = [UIApplication sharedApplication].keyWindow;
//    
//    CGRect rect1 = [btn convertRect:btn.bounds toView:self.friendTableView];//获取button在contentView的位置
//    
//    CGRect rect2 = [btn convertRect:rect1 toView:window];
//    //    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
//    //    CGRect rect=[btn convertRect:btn.bounds toView:window];
//    
//    
//    UIView *tempview  =[[UIView alloc]initWithFrame:rect1];
//    
//    [self.view addSubview:tempview];
//    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, rect2.origin.y, kScreenW-15, 100)];
//    textLabel.text = model.name;
//    textLabel.numberOfLines = 0;
//    textLabel.textColor = [UIColor whiteColor];
//    //    textLabel.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
//    
//    DXPopover *popover = [DXPopover popover];
//    [popover showAtView:tempview withContentView:textLabel inView:self.friendTableView];
//};
    return cell;
}

-(void)passModel:(FDCellModel *)model with:(id)sender{

    
    UIButton *btn =(UIButton *)sender;
    
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    CGRect rect1 = [btn convertRect:btn.bounds toView:self.friendTableView];//获取button在contentView的位置
    
    CGRect rect2 = [btn convertRect:rect1 toView:window];
//    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
//    CGRect rect=[btn convertRect:btn.bounds toView:window];

    
    UIView *tempview  =[[UIView alloc]initWithFrame:rect1];
    
    [self.view addSubview:tempview];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, rect2.origin.y, kScreenW-15, 100)];
    textLabel.text = model.name;
    textLabel.numberOfLines = 0;
    textLabel.textColor = [UIColor whiteColor];
//    textLabel.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    
    DXPopover *popover = [DXPopover popover];
    [popover showAtView:tempview withContentView:textLabel inView:self.friendTableView];
    
    //    UIImageView *imageV= [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, kScreenW-20, 200)];
    //    imageV.image = [UIImage imageNamed:@"tishii"];
    //
    //
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //    if(!window) {
    //        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    //    }
    //    NSSet *set = event.allTouches;
    //    UITouch *touch = [set anyObject];
    //    CGPoint point1 = [touch locationInView:window];
    //    //    CGPoint point = sender.center;
    //    [KWPopoverView showPopoverAtPoint:point1 inView:self.view withContentView:imageV];
}




#pragma mark 索引列点击事件
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    //点击索引，列表跳转到对应索引的行
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self showHint:title];
    return index;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (!_isSearch) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
        
        FDCellModel *model =value[indexPath.row];
        
        NSMutableArray *temp=[NSMutableArray array];
        
        //修改模型数据
        [value enumerateObjectsUsingBlock:^(FDCellModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.isClick) {
                
                [temp addObject:self.biLv[obj.tag]];
            }
        }];
        //修改模型数据
        model.isClick = !model.isClick;
        
        if (temp.count) {
            
            NSString *str = self.biLv[model.tag];
            if (![str isEqualToString:temp.lastObject]) {
                
                //            NSLog(@"选择错误");
                model.isClick = NO;
                self.maskLab.alpha=1;
                [self.view addSubview:self.maskLab];
                
                [UIView animateWithDuration:1.0 animations:^{
                    
                    //进行隐藏
                    self.maskLab.alpha=0;
                }];
            }
        }
        //刷新当前行
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }else{
        //        self.block(_searchDataSource[indexPath.row]);
        
        FDCellModel *model = _searchDataSource[indexPath.row];
        
        NSMutableArray *temp=[NSMutableArray array];
        
        //修改模型数据
        [ _searchDataSource enumerateObjectsUsingBlock:^(FDCellModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.isClick) {
                
                [temp addObject:self.biLv[obj.tag]];
            }
        }];
        //修改模型数据
        model.isClick = !model.isClick;
        
        if (temp.count) {
            
            NSString *str = self.biLv[model.tag];
            if (![str isEqualToString:temp.lastObject]) {
                
                //            NSLog(@"选择错误");
                model.isClick = NO;
                self.maskLab.alpha=1;
                [self.view addSubview:self.maskLab];
                
                [UIView animateWithDuration:1.0 animations:^{
                    
                    //进行隐藏
                    self.maskLab.alpha=0;
                }];
            }
        }
        //刷新当前行
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    [self searchBarCancelButtonClicked:self.searchBar];
    //    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    
    [_searchDataSource removeAllObjects];
    NSArray *ary = [HCSortString getAllValuesFromDict:_allDataSource];
    
    if (searchText.length == 0) {
        _isSearch = NO;
        [_searchDataSource addObjectsFromArray:ary];
    }else {
        _isSearch = YES;
        ary = [ZYPinYinSearch searchWithOriginalArray:ary andSearchText:searchText andSearchByPropertyName:@"name"];
        [_searchDataSource addObjectsFromArray:ary];
    }
    [self.friendTableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBarHidden = YES;
        _searchBar.frame = CGRectMake(0, 20, kScreenW, 44);
        _searchBar.showsCancelButton = NO;
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _searchBar.frame = CGRectMake(0, 64, kScreenW, 44);
    self.navigationController.navigationBarHidden = NO;
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    _isSearch = NO;
    [_friendTableView reloadData];
}

#pragma mark - block
-(void)cellback:(CallBackBlock)callBackBlok{
    self.callBackBlok=callBackBlok;
}

#pragma mark 无用的懒加载
-(NSArray *)biLv{
    
    if (_biLv==nil) {
        
        _biLv=@[@"10%",@"20%",@"10%",@"10%",@"80%",@"10%",@"10%",@"10%",@"10%",@"10%",@"100%",@"10%",@"10%",@"10%",@"10%",@"30%",@"120%",@"10%",@"90%",@"10%",@"10%",@"10%",@"10%",@"10%",@"10%",@"10%"];
    }
    
    return _biLv;
}

-(UILabel *)maskLab{
    
    if (_maskLab==nil) {
        _maskLab=[[UILabel alloc]init];
        _maskLab.backgroundColor=[UIColor blackColor];
        _maskLab.text=@"选择错误";
        _maskLab.textAlignment=NSTextAlignmentCenter;
        _maskLab.textColor=[UIColor whiteColor];
        //设置约束
        CGFloat W=300;
        CGFloat H=50;
        _maskLab.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-W)/2, ([UIScreen mainScreen].bounds.size.height-H)/2,W , H);
    }
    return _maskLab;
}

- (UITableView *)friendTableView {
    if (!_friendTableView) {
        _friendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStylePlain];
        _friendTableView.backgroundColor = SCBackgroundGrayColor;
        _friendTableView.delegate = self;
        _friendTableView.dataSource = self;
        _friendTableView.sectionIndexColor = SCGrayColor;
    }
    return _friendTableView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.showsCancelButton = NO;
    }
    return _searchBar;
}

-(NSArray *)dataSource{
    if (_dataSource ==nil) {
        NSArray *arrayDict=[NSArray getArraySaveName:@"jingpin.pl"];
        if (arrayDict.count) {
            _dataSource=arrayDict;
        }
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
