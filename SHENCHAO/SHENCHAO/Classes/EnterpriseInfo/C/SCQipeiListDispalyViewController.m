//
//  SCQipeiListDispalyViewController.m
//  汽车配件
//
//  Created by cb on 2017/4/18.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCQipeiListDispalyViewController.h"
#import "ZYPinYinSearch.h"
#import "HCSortString.h"


#import "PeijianModel.h"

#import "BestModel.h"
#define kColor          [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];

@interface SCQipeiListDispalyViewController ()<UISearchResultsUpdating,UISearchControllerDelegate>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *dataSource;/**<排序前的整个数据源*/
@property (strong, nonatomic) NSDictionary *allDataSource;/**<排序后的整个数据源*/
@property (strong, nonatomic) NSMutableArray *searchDataSource;/**<搜索结果数据源*/
@property (strong, nonatomic) NSArray *indexDataSource;/**<索引数据源*/

@end

@implementation SCQipeiListDispalyViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self   networking];
    [self initData];
    self.tableView.backgroundColor = kColor;
    [self.tableView setTableHeaderView:self.searchController.searchBar];
}
-(void)networking{

//    [JZLNetworkingTool getWithUrl:BESTList params:nil isReadCache:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
//        
//       _dataSource=[BestModel mj_objectArrayWithKeyValuesArray:responseObject];
//        [self initData];
//        self.tableView.backgroundColor = kColor;
//        [self.tableView setTableHeaderView:self.searchController.searchBar];
//        
//        [self hideHud];
//        
//    } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
//        [self hideHud];
//        [self showHint:@"列表服务器没开"];
//    }];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _searchController = nil;
    self.tableView = nil;
}

#pragma mark - Init
- (void)initData {
//    _dataSource = @[@"九寨沟",@"鼓浪屿",@"香格里拉",@"千岛湖",@"西双版纳",@"+-*/",@"故宫",@"上海科技馆",@"东方明珠",@"外滩",@"CapeTown",@"The Grand Canyon",@"4567.com",@"长江",@"长江1号",@"&*>?",@"弯弯月亮",@"that is it ?",@"山水之间",@"倩女幽魂",@"疆土无边",@"荡秋千"];
    
    _searchDataSource = [NSMutableArray new];
    
    _allDataSource = [HCSortString sortAndGroupForArray:_dataSource PropertyName:@"name"];
    _indexDataSource = [HCSortString sortForStringAry:[_allDataSource allKeys]];
    
}
- (void)willPresentSearchController:(UISearchController *)searchController{
    _searchController.searchBar.showsCancelButton = NO;

}
- (void)didPresentSearchController:(UISearchController *)searchController{
    _searchController.searchBar.showsCancelButton = NO;

}
- (void)willDismissSearchController:(UISearchController *)searchController{
    _searchController.searchBar.showsCancelButton = NO;

}
- (void)didDismissSearchController:(UISearchController *)searchController{

    _searchController.searchBar.showsCancelButton = NO;

}
- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
        _searchController.dimsBackgroundDuringPresentation = YES;
        //不上移动
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.searchBar.backgroundImage=[UIImage imageNamed:@"搜索背景.png"];
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.searchBar.showsCancelButton = NO;
        [_searchController.searchBar sizeToFit];
    }
    return _searchController;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return _indexDataSource.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[section]];
        return value.count;
    }else {
        return _searchDataSource.count;
    }
}
//头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!self.searchController.active) {
        return _indexDataSource[section];
    }else {
        return nil;
    }
}
//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return _indexDataSource;
    }else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
        cell.textLabel.text = value[indexPath.row];
    }else{
        cell.textLabel.text = _searchDataSource[indexPath.row];
    }
    return cell;
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
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
        self.block(value[indexPath.row]);
    }else{
        self.block(_searchDataSource[indexPath.row]);
    }
    self.searchController.active = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [_searchDataSource removeAllObjects];
    NSArray *ary = [HCSortString getAllValuesFromDict:_allDataSource];
    
    if (searchController.searchBar.text.length == 0) {
        [_searchDataSource addObjectsFromArray:ary];
    }else {
        ary = [ZYPinYinSearch searchWithOriginalArray:ary andSearchText:searchController.searchBar.text andSearchByPropertyName:@"name"];
        [_searchDataSource addObjectsFromArray:ary];
    }
    [self.tableView reloadData];
}

#pragma mark - block
- (void)didSelectedItem:(SelectedItem)block {
    self.block = block;
}

- (void)searchResult: (UISearchController *)searchController {
    NSPredicate *precidate = [NSPredicate predicateWithFormat:@"displayName CONTAINS[cd] %@", searchController.searchBar.text];
    
}

@end
