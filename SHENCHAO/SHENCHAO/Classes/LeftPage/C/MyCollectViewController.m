
//
//  MyCollectViewController.m
//  SHENCHAO
//
//  Created by cb on 2017/6/26.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "MyCollectViewController.h"
#import "CollectionCell.h"
#import "CollectionModel.h"
@interface MyCollectViewController ()<SlideDeleteCellDelegate>
@property (nonatomic, strong) NSMutableArray *CollectionList;

@end

@implementation MyCollectViewController

#pragma mark 滑动删除
-(void)slideToDeleteCell:(CollectionCell *)slideDeleteCell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:slideDeleteCell];
    [self.CollectionList removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.CollectionList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.delegate = self;
    [cell updateWithApp:self.CollectionList[indexPath.row] ];
    cell.IMclick = ^(NSString *IM) {
        NSLog(@"%@",IM);
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setupData];
}
- (void)setupData {
    self.title = @"收藏";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu"] highImage:[UIImage imageNamed:@"menu"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.estimatedRowHeight = 84;
    [self.tableView registerClass:CollectionCell.class forCellReuseIdentifier:@"cell"];
    CollectionModel *model =[CollectionModel new];
    model.UID = @"111";
    model.company = @"北京汽配通达商贸有限公司";
    model.brands = @"宝马 大众";
    model.IM = @"11234567";
    model.IM = @"11234567";
    self.CollectionList = [NSMutableArray arrayWithObjects:model,model,model,model,nil];
}
- (void)back
{
    [self dismissViewControllerAnimated:1 completion:nil];
}

@end
