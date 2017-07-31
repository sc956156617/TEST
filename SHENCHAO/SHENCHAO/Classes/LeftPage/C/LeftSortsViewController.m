//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"

//换肤设置
#import "MyThemes.h"
#import "SHENCHAO-Swift.h"

#import "LoginIconView.h"
#import "SCLoginViewController.h"



//跳转
#import "MySkinViewController.h"
#import "MyCollectViewController.h"
#import "MySettingViewController.h"
#import "MyNoticeListViewController.h"
#import "MyEnterpriseInfoViewController.h"

//弹出
#import "MLMOptionSelectView.h"

#import "PersonInfoDisplayViewController.h"
//城市变化
#import "CityTools.h"

@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource,LoginIconViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *sectionArray;//section标题
@property(nonatomic, strong)NSMutableArray *rowInSectionArray;//section中的cell个数
@property(nonatomic, strong)NSMutableArray *selectedArray;//是否被点击

@property (nonatomic, strong) MLMOptionSelectView *cellView;
@property(nonatomic, strong)NSMutableArray *muneArr;// 切换


@property(nonatomic,strong)CityTools * cityModel;  //城市模型
@end

@implementation LeftSortsViewController

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    CityTools *tool = object;
    NSLog(@"%@",tool.fromCity);
}
#pragma mark 切换定位源
-(void)location:(NSInteger)row{
    if (row==0){ //当前定位
        
    }else{//常用地
    
    }
}
#pragma mark button点击方法
-(void)buttonAction:(UIButton *)button
{
    switch (button.tag) {
        case 1000:
        {
            if ([_selectedArray[button.tag - 1000] isEqualToString:@"0"]) {
                //如果当前点击的section是缩回的,那么点击后就需要把它展开,是_selectedArray对应的值为1,这样当前section返回cell的个数就变为真实个数,然后刷新这个section就行了
                [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"1"];
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
            }
            else
            {
                //如果当前点击的section是展开的,那么点击后就需要把它缩回,使_selectedArray对应的值为0,这样当前section返回cell的个数变成0,然后刷新这个section就行了
                [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"0"];
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
            }
        }break;
        case 1001:// @"我的企业"
        {
            if( [SCUserDefaults objectForKey:@USERENTERPRISEID]){
                [self prensentTo:[NSClassFromString(@"MyEnterpriseInfoViewController") new]];
            }else{
                [self prensentTo:[NSClassFromString(@"SCWhichEnterpriseViewController") new]];
            }
        }break;
        case 1002://@"我的收藏",
        {
            [self prensentTo:[NSClassFromString(@"MyCollectViewController") new]];
        } break;
        case 1003://@"系统通知",
        {
            [self prensentTo:[NSClassFromString(@"MyNoticeListViewController") new]];
        }break;
        case 1005://@"换肤
        {
            
        } break;
        case 1006://,@"设置"
        {
            [self prensentTo:[NSClassFromString(@"MySettingViewController") new]];
        }
            break;
        default:
            break;
    }
}
-(void)prensentTo:(id)VC{
    SCNavigationViewController* nac = [[SCNavigationViewController alloc]initWithRootViewController:VC];
    [self  presentViewController:nac animated:1 completion:nil];
}

- (void)setUI {
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView = tableview;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = SCThemeColor;
    tableview.scrollEnabled = NO;
    [self.view addSubview:tableview];
//    self.view.backgroundColor = SCThemeColor;
//    tableview.theme_backgroundColor = [ThemeColorPicker pickerWithColors:@[@"#EB4F38", @"#F4C600", @"#56ABE4", @"#ECF0F1"]];
    //设置头
    LoginIconView * iconview =  [[LoginIconView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, LoginIconViewHeight)];
    iconview.delegate = self;
    [iconview updateWithApp:nil index:2];
    self.tableView.tableHeaderView = iconview;
    [self dataSource];
    //设置尾视图

    UIView * view= View.xywh(0, kScreenH-50, kLeftTableviewW, 50).bgColor(@"#ECF0F1").opacity(0.7).border(1, @"#3d3d3d").addTo(self.tableView);
    NSString *str =@"北京";
    UILabel *quiz = Label.str(@"当前城市：%@", str).fnt(@17).color(@"66,66,66").xywh(30,10,200,30).fitSize.addTo(view);

    
    SCWeakSelf(self);
    Button.str(@"切换").insets(5, 10).border(1).xy( quiz.x + quiz.width +20 ,10).wh(50,30).fitSize.cy(quiz.centerY).onClick((^(UIButton *btn) {
        _muneArr =(NSMutableArray *)@[@"使用当前定位",@"切换到常用地"];
        _cellView = [[MLMOptionSelectView alloc] initOptionView];
        [self defaultCell];
        _cellView.vhShow = NO;
        _cellView.optionType = MLMOptionSelectViewTypeArrow;
//#warning ---- 想保持无论何种情况都左、右对齐,可以选择自己想要对齐的边，重新设置edgeInset
//        CGRect rect = [MLMOptionSelectView targetView:btn];
//        _cellView.edgeInsets = UIEdgeInsetsMake(10, rect.origin.x, 10, SCREEN_WIDTH - rect.origin.x - rect.size.width);
        _cellView.selectedOption = ^(NSIndexPath *aa) {
            [weakself location:aa.row];
        };
        [_cellView showOffSetScale:0.5 viewWidth:150 targetView:btn direction:MLMOptionSelectViewBottom];
    })).addTo(view);
//    UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLRView:)];
//    [btn addGestureRecognizer:pan2];
}
- (void)defaultCell {
    
    WEAK(weaklistArray, _muneArr);
    WEAK(weakSelf, self);
    _cellView.canEdit = NO;
    [_cellView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DefaultCell"];
    _cellView.cell = ^(NSIndexPath *indexPath){
        UITableViewCell *cell = [weakSelf.cellView dequeueReusableCellWithIdentifier:@"DefaultCell"];
        cell.textLabel.text = weakSelf.muneArr[indexPath.row];
        return cell;
    };
    _cellView.optionCellHeight = ^{
        return 40.f;
    };
    _cellView.rowNumber = ^(){
        return (NSInteger)weaklistArray.count;
    };
}
- (void)moveLRView:(UIGestureRecognizer *)ges {
//    if (ges.state != UIGestureRecognizerStateEnded && ges.state != UIGestureRecognizerStateFailed){
//        //通过使用 locationInView 这个方法,来获取到手势的坐标
//        CGPoint location = [ges locationInView:ges.view.superview];
//        ges.view.center = location;
//    }
}
#pragma mark  弹出视图点击

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    self.tableview.tableHeaderView.height = 100;
//    LoginIconView * iconview =  [[LoginIconView alloc]init];
//    iconview.delegate = self;
//    [iconview updateWithApp:nil index:2];
//
////    __block  typeof(self) tmpSelf = self;
//    iconview.block=^(){
////        NSLog(@"-------------");
//    };
//    return iconview;
//}

-(void)IconClick{
    if ([SCUserDefaults objectForKey:@ISLOGIN]) {
        [self prensentTo:[PersonInfoDisplayViewController new]];
    }else{
        [self prensentTo:[SCLoginViewController new]];
    }
}

#pragma mark deldegate and datasouse
- (void)dataSource
{
    _sectionArray = [NSMutableArray arrayWithObjects:@"汽配商城市选择：唐山", @"我的企业",@"我的收藏",@"系统通知",@"常用地：唐山",@"换肤",@"设置", nil];//每个分区的标题
    _rowInSectionArray = [NSMutableArray arrayWithObjects:@"4",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];//每个分区中cell的个数
    _selectedArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];//这个用于判断展开还是缩回当前section的cell
}

#pragma mark cell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _sectionArray[indexPath.section];
    return cell;
}

#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断section的标记是否为1,如果是说明为展开,就返回真实个数,如果不是就说明是缩回,返回0.
    if ([_selectedArray[section] isEqualToString:@"1"]) {
        return [_rowInSectionArray[section] integerValue];
    }
    return 0;
}
#pragma mark section的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionArray.count;
}

#pragma cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - section内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //每个section上面有一个button,给button一个tag值,用于在点击事件中改变_selectedArray[button.tag - 1000]的值
    UIButton *sectionView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kLeftTableviewW, 40)];
//    sectionView.backgroundColor = [UIColor cyanColor];
    UIButton *btn=  Button.str([_sectionArray objectAtIndex:section]).fitSize.xywh(0, 0, 200, 40).onClick(@"buttonAction:").fnt([UIFont systemFontOfSize:18]).tg(1000 + section).addTo(sectionView);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    UIView *view1 = View.xywh(kLeftTableviewW-40, 0, 40, 40).bgColor(@"red").opacity(0.7).border(3, @"#3d3d3d").addTo(sectionView);
    if ([self.selectedArray[section] isEqualToString:@"0"]) {
        view1.backgroundColor = SCGrayColor;
    }else{
        view1.backgroundColor = [UIColor cyanColor];
    }
    if (section==4) {
        Button.str(@"").xywh(kLeftTableviewW-80, 10, 20, 20).bgColor(@"red").opacity(0.7).border(3, @"#3d3d3d").addTo(sectionView).onClick(^{
            [self showHint:@"将当前城市设为常用地"];
        });
    }
    return sectionView;
}

-(void)closelefeview{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate  colseLeftView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setUI];
    
    self.cityModel =  [CityTools share];
    self.cityModel.fromCity = @"北京";
    self.cityModel.toCity   = @"上海";
    [[CityTools share] addObserver:[CityTools share] forKeyPath:@"city" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"%@==%@", self.cityModel.fromCity,[CityTools share].toCity);
     self.cityModel.fromCity = @"shanghai";
    NSLog(@"%@", self.cityModel.fromCity);
}
@end
