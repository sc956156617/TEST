//
//  SCQiPeiViewController.m
//  汽车配件
//
//  Created by cb on 2017/3/29.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCQiPeiViewController.h"
#import "SCQIPeiQIxiuHeaderView.h"
#import "SCWhichEnterpriseViewController.h"


//相册相关
//#import "MLSelectPhotoAssets.h"
//#import "MLSelectPhotoPickerAssetsViewController.h"
//#import "MLSelectPhotoBrowserViewController.h"
//#import "MLSelectPhotoPickerViewController.h"
#import "ACMediaFrame.h"

#import "SCActionSheet.h"


#import "LXAlertView.h"

#import "SCWorkerManageViewController.h"
#import "SCWorkerListViewController.h"

#import "SCQipeiListDispalyViewController.h"


//配件列表
#import "PeiJianListViewController.h"
//精品列表
#import "BestListViewController.h"
//品牌列表
#import "BandsListViewController.h"
//模型存储
#import "NSObject+SaveModelArray.h"
#import "FDCellModel.h"

#import "ZhuyingBandsViewController.h"
#import "JianuyongBandsViewController.h"

//名片扫描
//#import "CCPTakePicturesController.h"
//#import "CCPPhotoAlbumViewController.h"
//#import "CCPShowPhotoVC.h"
//#import "CCPBecomeBeautifulController.h"

//汉王头文件
#import "HWCloudsdk.h"
@interface SCQiPeiViewController ()<UITableViewDelegate,UITableViewDataSource,iconclickDelegete,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView *tableview;

//企业信息
@property(nonatomic,strong)UITextField *enterpriseName;
@property(nonatomic,strong)UITextField *enterpriseAdress;
@property(nonatomic,strong)UITextField *enterpriseArea;


//基本信息
@property(nonatomic,strong)UITextField *enterpriseMobile;
@property(nonatomic,strong)UITextField *enterprisePhone;
@property(nonatomic,strong)UITextField *enterpriseMPer;

//照片容器
@property (nonatomic,strong)NSMutableArray * photoArr;
@property (nonatomic,strong)UIButton *iconBtn;



//分用lable
@property(nonatomic ,strong) UILabel * zhuyingL;
@property(nonatomic ,strong) UILabel * jianyingL;
@property(nonatomic ,strong) UILabel * zhuanyingL;
@property(nonatomic ,strong) UILabel * peijianL;
@property(nonatomic ,strong) UILabel * jingpinL;

/*上传的图片地址*/
@property(nonatomic,copy)NSString  * picUrl;

//五种类型的ID拼接字符串

@property(nonatomic,copy)NSString  * zhuyingIDs;
@property(nonatomic,copy)NSString  * zhuanyingIDs;
@property(nonatomic,copy)NSString  * jianyingIDs;
@property(nonatomic,copy)NSString  * jingpinIDs;
@property(nonatomic,copy)NSString  * peijianIDs;

/** ACSelectMediaView object */
@property (nonatomic, weak) ACSelectMediaView *mediaView;
@end

@implementation SCQiPeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setNavigation];
    [self setUpchildViewes];
    
}
-(void)setNavigation{
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:SCThemeColor, NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:AdapationLabelFont(19)],NSFontAttributeName,nil];
    self.title = @"完善企业信息";
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

#pragma mark  ####导航栏点击######
-(void)leftclick{
    [self.navigationController   popViewControllerAnimated:1];
}

#pragma mark  修改企业信息
-(void)rightclick{
    
    [self  isEmpty];
    [self  registerEnterprise];
    LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"完善成功" message:@"恭喜您拥有自己的企业，您已成为企业的管理员，您还可以在自己的企业里添加两名客服人人员" cancelBtnTitle:@"先等等" otherBtnTitle:@"现在就去" clickIndexBlock:^(NSInteger clickIndex,NSString * textInput) {
        switch (clickIndex) {
                case 0:
                [self.navigationController pushViewController:[SCWorkerListViewController new] animated:1];
                break;
                
                case 1:
                  [self.navigationController pushViewController:[SCWorkerListViewController new] animated:1];
                break;
                
            default:
                break;
        }
    }];
    alert.animationStyle=LXASAnimationTopShake;
    [alert showLXAlertView];
}
-(void)isEmpty{
    
    if(kStringIsEmpty(self.picUrl)){
        [self  showHint:@"企业logo不能为空"];
    }
    if (kStringIsEmpty(self.enterpriseName.text)) {
        [self  showHint:@"企业名称不能为空"];
    }else if (kStringIsEmpty(self.enterpriseAdress.text)){
        [self  showHint:@"企业地址不能为空"];
    }else if (kStringIsEmpty(self.enterpriseAdress.text)){
        [self  showHint:@"移动电话不能为空"];
    }else if (kStringIsEmpty(self.zhuanyingL.text) && kStringIsEmpty(self.zhuyingL.text)  && kStringIsEmpty(self.jingpinL.text)&& kStringIsEmpty(self.peijianL.text)){
        [self  showHint:@"请选择经营类型"];
    }
}
-(void)back{
    [self.navigationController   popViewControllerAnimated:1];
}
-(void)finish{
    [self.navigationController   popViewControllerAnimated:1];
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _tableview.delegate =self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = SCLineGrayColor;
        //适配5s滑动到最底部反弹
        if (IS_IPHONE_5) {
            self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
        }
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"one"];
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"two"];
        [_tableview registerClass:[SCQIPeiQIxiuHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    }
    return _tableview;
}
- (void)setUpchildViewes {
    
    //添加tableview
    [self.view addSubview:self.tableview];
    //关闭
//    SCQIPeiQIxiuHeaderView * herderview =[[SCQIPeiQIxiuHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 140)];
//    //设置
//    herderview.delegegate = self;
//    self.tableview.tableHeaderView = herderview;
    
    self.tableview.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    CGFloat height = [ACSelectMediaView defaultViewHeight];
    UIView *headerView = [[UIView alloc] init];
    
    //    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 20)];
    //    lab.text = @"展示区域";
    //    [headerView addSubview:lab];
    
    ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, height)];
    mediaView.showDelete = NO;
    mediaView.showAddButton = NO;
    //png、jpg、gif(本地和网络)
    
    //预展示视频
    ACMediaModel *md = [ACMediaModel new];
    md.mediaURL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1451897812703c.mp4"];
    md.isVideo = YES;
    //封面
    md.image = [UIImage imageNamed:@"memory"];
    
    mediaView.preShowMedias = @[];
    mediaView.allowMultipleSelection = NO;
    mediaView.allowPickingVideo = YES;
    self.mediaView = mediaView;
    self.mediaView.showAddButton = YES;
    self.mediaView.showDelete = YES;
    
    SCWeakSelf(self);
    [mediaView observeViewHeight:^(CGFloat mediaHeight) {
        CGRect rect = headerView.frame;
        rect.size.height = CGRectGetMaxY(mediaView.frame);
        headerView.frame = rect;
        [weakself.tableview reloadData];
    }];
    [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
        // do something
        for (ACMediaModel *model in list) {
            //遍历得到模型中想要的数据  e.g.
            // id uplodaType = model.uploadType;
            // NSString *name = model.name;
        }
        NSLog(@"list.count = %lu",(unsigned long)list.count);
    }];
    [headerView addSubview:mediaView];
    
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMaxY(mediaView.frame));
    self.tableview.tableHeaderView = headerView;

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return   3;
            break;
        case 1:
            return   3;
            break;
        case 2:
            if (self.engageIn == EngageInManyBrand) {
                return 2;
            }else{
                return   1;
            }
            break;
        default:
            return   1;
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 12)];
    bgView.backgroundColor = SCLineGrayColor;
    UILabel * sectionTitle =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenW, 20)];
    sectionTitle.font =[UIFont boldSystemFontOfSize:AdapationLabelFont(13)];
    sectionTitle.textColor = SCLightGrayColor;
    switch (section) {
        case 0:{
            sectionTitle.text = @"基本信息";
        }
            break;
        case 1:{
            sectionTitle.text = @"通讯信息";
        }
            break;
        case 2:{
            sectionTitle.text = @"经营类型";
        }
            break;
        default:
            sectionTitle.text = @"";

            break;
    }
    
    [bgView addSubview:sectionTitle];
    return bgView;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell ;
    if (!cell) {
        if (indexPath.section==0) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"one"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
            
            if( indexPath.row == 0){
                
                UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
                nameL.text = @"企业名称";
                nameL.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                nameL.centerY = view.centerY;
                [nameL  sizeToFit];
                [view addSubview:nameL];
                
                UITextField *nameLX = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameL.frame)+30, 15, kScreenW-CGRectGetMaxX(nameL.frame)-40, 20)];
                nameLX.placeholder = @"填写真正的名称";
                nameLX.font =[UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                nameLX.textColor = SCLightGrayColor;
                self.enterpriseName = nameLX;
                
                [view addSubview:nameLX];
            }else if(indexPath.row==1){
                UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
                nameL.text = @"所在地区";
                nameL.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                nameL.centerY = view.centerY;
                [nameL  sizeToFit];
                [view addSubview:nameL];
                
                UITextField *nameLX = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameL.frame)+30, 15, kScreenW-CGRectGetMaxX(nameL.frame)-40, 20)];
                nameLX.placeholder = @"10至30个字符";
                nameLX.font =[UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                
                self.enterpriseArea = nameLX;
                nameLX.textColor = SCLightGrayColor;
                [view addSubview:nameLX];
                
                UIView *line =[[UIView alloc]initWithFrame:CGRectMake(20, 0, kScreenW, 1)];
                line.backgroundColor = SCLineGrayColor;
                [view addSubview:line];
            }else{
                
                UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
                nameL.text = @"详细地址";
                nameL.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                nameL.centerY = view.centerY;
                [nameL  sizeToFit];
                [view addSubview:nameL];
                
                UITextField *nameLX = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameL.frame)+30, 15, kScreenW-CGRectGetMaxX(nameL.frame)-40, 20)];
                nameLX.placeholder = @"10至30个字符";
                nameLX.font =[UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                
                self.enterpriseAdress = nameLX;
                nameLX.textColor = SCLightGrayColor;
                [view addSubview:nameLX];
                
                UIView *line =[[UIView alloc]initWithFrame:CGRectMake(20, 0, kScreenW, 1)];
                line.backgroundColor = SCLineGrayColor;
                [view addSubview:line];
                
                
            }
            [cell.contentView addSubview:view];
            
        }else if(indexPath.section ==1) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"one"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
            if( indexPath.row == 0){
                
                UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
                nameL.text = @"联系人";
                nameL.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                nameL.centerY = view.centerY;
                [nameL  sizeToFit];
                [view addSubview:nameL];
                
                UITextField *nameLX = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameL.frame)+30, 15, kScreenW-CGRectGetMaxX(nameL.frame)-40, 20)];
                nameLX.placeholder = @"企业负责人名称";
                nameLX.font =[UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                self.enterpriseMPer = nameLX;
                nameLX.textColor = SCLightGrayColor;
                [view addSubview:nameLX];
                
            }else if( indexPath.row == 1){
                UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
                nameL.text = @"移动电话";
                nameL.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                
                nameL.centerY = view.centerY;
                [nameL  sizeToFit];
                [view addSubview:nameL];
                
                UITextField *nameLX = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameL.frame)+30, 15, kScreenW-CGRectGetMaxX(nameL.frame)-40, 20)];
                nameLX.placeholder = @"请填写您的手机号码";
                nameLX.font =[UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                nameLX.textColor = SCLightGrayColor;
                self.enterpriseMobile = nameLX;
                [view addSubview:nameLX];
            }else{
                UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
                nameL.text = @"固定电话";
                nameL.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                nameL.centerY = view.centerY;
                [nameL  sizeToFit];
                [view addSubview:nameL];
                
                UITextField *nameLX = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameL.frame)+30, 15, kScreenW-CGRectGetMaxX(nameL.frame)-40, 20)];
                nameLX.placeholder = @"电话号码前请加区号";
                nameLX.font =[UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                self.enterprisePhone = nameLX;
                nameLX.textColor = SCLightGrayColor;
                [view addSubview:nameLX];
                
            }
            [cell.contentView addSubview:view];
        }else if(indexPath.section ==2){
        
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"two"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (_engageIn == EngageInManyBrand) {  //兼营
                if (indexPath.row==0) {
                    UIImageView * arrow =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenW-30, 20, 10, 15)];
                    arrow.image  =  [UIImage imageNamed:@"gengduo"];
                    [cell.contentView addSubview:arrow];
                    cell.textLabel.text = @"主营";
                    
                    UILabel *brandNameL = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreenW-50, 20)];
                    brandNameL.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                    brandNameL.text = @"本田";
                    brandNameL.textAlignment = NSTextAlignmentRight;
                    brandNameL.textColor = SCLightGrayColor;
                    
                    self.zhuyingL =brandNameL;
                    [cell.contentView addSubview:brandNameL];
                    cell.textLabel.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                    
                    //                cell.textLabel.x = 20;
                }else if (indexPath.row==1){
                    UIImageView * arrow =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenW-30, 20, 10, 15)];
                    arrow.image  =  [UIImage imageNamed:@"gengduo"];
                    [cell.contentView addSubview:arrow];
                    
                    UILabel *brandNameL = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreenW-50, 20)];
                    brandNameL.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                    brandNameL.text = @"本田";
                    brandNameL.textAlignment = NSTextAlignmentRight;
                    brandNameL.textColor = SCLightGrayColor;
                    [cell.contentView addSubview:brandNameL];
                    self.jianyingL =brandNameL;

                    cell.textLabel.text = @"兼营";
                    cell.textLabel.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                    
                    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(20, 0, kScreenW, 1)];
                    line.backgroundColor = SCLineGrayColor;
                    [cell.contentView addSubview:line];

                }else{
                
                
                
                
                
                
                }
            }else if (_engageIn == EngageInOneBrand){  //专营
                UIImageView * arrow =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenW-30, 20, 10, 15)];
                arrow.image  =  [UIImage imageNamed:@"gengduo"];
                [cell.contentView addSubview:arrow];
                cell.textLabel.text = @"专营";
                
                UILabel *brandNameL = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreenW-50, 20)];
                brandNameL.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                brandNameL.text = @"本田";
                brandNameL.textAlignment = NSTextAlignmentRight;
                brandNameL.textColor = SCLightGrayColor;
                self.zhuanyingL =brandNameL;
                [cell.contentView addSubview:brandNameL];
                cell.textLabel.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
            }else if (_engageIn == EngageInPart){  //配件
            
                                                                        
            }else{   //精品
                UIImageView * arrow =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenW-30, 20, 10, 15)];
                arrow.image  =  [UIImage imageNamed:@"gengduo"];
                [cell.contentView addSubview:arrow];
                cell.textLabel.text = @"精品";
                UILabel *brandNameL = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreenW-50, 20)];
                brandNameL.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                brandNameL.text = @"本田";
                brandNameL.textAlignment = NSTextAlignmentRight;
                self.jingpinL =brandNameL;

                brandNameL.textColor = SCLightGrayColor;
                [cell.contentView addSubview:brandNameL];
                cell.textLabel.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
            }
            
            
            
        }else{ //section3
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"two"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            UIImageView * arrow =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenW-30, 20, 10, 15)];
//            arrow.image  =  [UIImage imageNamed:@"gengduo"];
//            [cell.contentView addSubview:arrow];
//                
//            UILabel *brandNameL = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreenW-50, 20)];
//            brandNameL.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
//            brandNameL.text = @"本田";
//            brandNameL.textAlignment = NSTextAlignmentRight;
//            brandNameL.textColor = SCLightGrayColor;
//            [cell.contentView addSubview:brandNameL];
//            cell.textLabel.text = @"专营";
//            cell.textLabel.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
            
        }
    }
    
    return cell;
}
-(void)iconSelect{
}

-(void)scangogo:(UIImage *)photo{
    
    HWCloudsdk *sdk = [[HWCloudsdk alloc]init];
    // 使用https请求，默认http
    [sdk useHttpsRequest];
    //    UIImage *cardImg = [UIImage imageNamed:@"cardimage.jpg"];
    //apiKey 需要您到developer.hanvon.com 自行申请
    NSString *apiKey = @"3e8cc3ba-dbbc-4fbe-a271-de65d211de5e";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:1];
    [sdk cardLanguage:@"auto" cardImage:photo apiKey:apiKey successBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:1];
        
        NSDictionary * dic =[self dictionaryWithJsonString:responseObject];
        NSString *code =dic[@"code"];
        
        if([code isEqualToString:@"0"]){
            
            //负责人
            NSString *name;
            if (kObjectIsEmpty([dic objectForKey:@"name"])) {
                name = @"";
                
            }else{
                NSArray *arr =[dic objectForKey:@"name"];
                if (arr.count>0) {
                    name =[dic objectForKey:@"name"][0];
                }else{
                    name = @"";
                }
            }
            //电话
            
            NSString *tel;
            if (kObjectIsEmpty([dic objectForKey:@"tel"])) {
                tel = @"";
            }else{
                NSArray *arr =[dic objectForKey:@"tel"];
                if (arr.count>0) {
                    tel =[dic objectForKey:@"tel"][0];
                }else{
                    tel = @"";
                }
            }
            //手机
            
            NSString *mobile;
            if (kObjectIsEmpty([dic objectForKey:@"mobile"])) {
                NSArray *arr =[dic objectForKey:@"mobile"];
                if (arr.count>0) {
                    mobile =[dic objectForKey:@"mobile"][0];
                }else{
                    mobile = @"";
                }
            }else{
                NSArray *arr =[dic objectForKey:@"mobile"];
                if (arr.count>0) {
                    mobile =[dic objectForKey:@"mobile"][0];
                }else{
                    mobile = @"";
                }
                mobile = @"";
            }
            
            //公司名称
            NSString *comp;
            if (kObjectIsEmpty([dic objectForKey:@"comp"])) {
                comp = @"";
                
            }else{
                NSArray *arr =[dic objectForKey:@"comp"];
                if (arr.count>0) {
                    comp =[dic objectForKey:@"comp"][0];
                }else{
                    comp = @"";
                }
            }
            
            //详细地址
            
            NSString *addr;
            if (kObjectIsEmpty([dic objectForKey:@"addr"])) {
                addr = @"";
            }else{
                NSArray *arr =[dic objectForKey:@"addr"];
                if (arr.count>0) {
                    addr =[dic objectForKey:@"addr"][0];
                }else{
                    addr = @"";
                }
            }
            
            
            self.enterpriseName.text =comp;
            self.enterpriseMPer.text =name;
            //                self.enterpriseArea.text =comp;
            self.enterprisePhone.text =tel;
            self.enterpriseAdress.text =addr;
            self.enterpriseMobile.text =mobile;
            
        }else{
            [self showHint:@"提示技术员查看扫描结果出错"];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section ==2 ) {
        
 
    if (_engageIn == EngageInManyBrand) {
        
        if (indexPath.row == 1 ) {
            
            
            JianuyongBandsViewController *search = [JianuyongBandsViewController new];
              search.title =  @"兼营选择列表";
            //返回选中搜索的结果
//            [search didSelectedItem:^(NSString *item) {
//                NSLog(@"%@",item);
//            }];
            
            search.callBackBlok = ^(NSArray *arrString) {
                self.jianyingL.text=[self enumerateArrayString:arrString];
                self.jingpinIDs = [self jointSyringID:arrString];
            };
            [self.navigationController pushViewController:search animated:YES];
        }else{
        
            ZhuyingBandsViewController *search = [ZhuyingBandsViewController new];
                    search.title = @"主营选择列表";
            //返回选中搜索的结果
               search.callBackBlok = ^(BandsModel *model) {
                   self.zhuyingL.text = model.name;
                   self.jingpinIDs = model.ID;

               };
            [self.navigationController pushViewController:search animated:YES];

        
        }
    }else if (_engageIn == EngageInOneBrand){
   
        BandsListViewController *vc = [BandsListViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        

    }else if (_engageIn == EngageInPart){//配件
        
        PeiJianListViewController *vc = [PeiJianListViewController new];
        [vc cellback:^(NSArray *arrString) {
            //遍历取出模型中包含的疾病名称
               self.peijianL.text=[self enumerateArrayString:arrString];
            self.peijianIDs = [self jointSyringID:arrString];

        }];
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        
        
        BestListViewController *vc = [BestListViewController new];
        [vc cellback:^(NSArray *arrString) {
            //遍历取出模型中包含的疾病名称
            
            if ([self enumerateArrayString:arrString]) {
                 self.jingpinL.text=[self enumerateArrayString:arrString];
            }
            self.jingpinIDs = [self jointSyringID:arrString];

        }];
        [self.navigationController pushViewController:vc animated:YES];

    }
}
}

#pragma mark 类型返回。 拼接字符串id 

-(NSString *)jointSyringID:(NSArray *) arrStr{

    FDCellModel * mode= arrStr[0];
    NSLog(@"%lu",(unsigned long)mode.number);
    NSMutableString *string=[NSMutableString string];
    
    [arrStr enumerateObjectsUsingBlock:^(FDCellModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isClick) {
            NSString *tempString=[NSString stringWithFormat:@",%@",obj.number];
            [string appendString:tempString];
        }
    }];
    
    //截取前面的顿号
    if (string.length) {
        string=(NSMutableString *)[string substringFromIndex:1];
    }
    return string;
}

//遍历取出模型中包含的模型名称
-(NSString *)enumerateArrayString:(NSArray *)arrString{
    
    NSMutableString *string=[NSMutableString string];
    
    [arrString enumerateObjectsUsingBlock:^(FDCellModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isClick) {
            
            NSString *tempString=[NSString stringWithFormat:@"、%@",obj.name];
            [string appendString:tempString];
        }
    }];
    
    //截取前面的顿号
    if (string.length) {
        
        string=(NSMutableString *)[string substringFromIndex:1];
    }
    return string;
}
-(void)logintouchclicke:(UIButton *)btn{
    [self.navigationController popToRootViewControllerAnimated:1];
}

#pragma mark 头像点击之后
-(void)passIconmclick:(UIButton *)btn{
    self.iconBtn = btn;
    [SCActionSheet showWithTitle:@"上传一张满意的头像吧" destructiveTitle:nil otherTitles:@[@"从相册中选取",@"拍照"] block:^(int index) {
        switch (index) {
            case 0:
                [self pickview];
                break;
            case 1:
                [self takePhoto];
                break;
            default:
                break;
        }
    }];
}



-(void)pickview{
    
//    self.photoArr =[NSMutableArray arrayWithCapacity:1];
//    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
//    // 默认显示相册里面的内容SavePhotos
//    pickerVc.status = PickerViewShowStatusSavePhotos;//PickerViewShowStatusCameraRoll;
//    pickerVc.minCount = 3-[_photoArr count];
//    [self presentViewController:pickerVc animated:YES completion:^{
//        
//    }];
//    //[pickerVc show];
//    //    __weak typeof(self) weakSelf = self;
//    //    kWeakSelf(self);
//    pickerVc.callBack = ^(NSArray *assets){
//        for(NSInteger i=0;i<assets.count; i++){
//            MLSelectPhotoAssets *asset = [assets objectAtIndex:i];
//            UIImage * image = [MLSelectPhotoPickerViewController getImageWithImageObj:asset];
//            image = [self compressImage:image toMaxFileSize:3333300]; //压缩图片
//            [_photoArr addObject:image];
//        }
//        //        [weakself.takePhotoView setPhotosArray:_fPhotosArray];
//        //[XYNetPhotoUploadManager shareManager].uploadPicArr = _fPhotosArray;
//        
//        [self.iconBtn setImage:_photoArr[0] forState:UIControlStateNormal];
//        //上传图片。获取地址
//        [self uploadImage];
//    };
    
}
- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    //maxfileSize : 压缩后最大字节数
    CGFloat compression = 0.9f; //像素压缩比例
    CGFloat maxCompression = 0.1f;  //压缩最大比例
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
        if (compression==0.1) {
            maxFileSize = [imageData length];
        }
    }
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    
    
    return compressedImage;
}

#pragma mark 拍照
-(void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"该设备没有摄像头" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //     获取选中的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //    [self performSelector:@selector(saveImage:)  withObject:_image afterDelay:0.5];
    [picker dismissViewControllerAnimated:YES completion:nil];
     self.photoArr = [NSMutableArray arrayWithObject:image];
    [self.iconBtn setImage:image forState:UIControlStateNormal];
    //上传图片。获取地址
    [self uploadImage];
}
#pragma mark 获取企业信息

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self  loadEnterpriseView];
}
-(void)loadEnterpriseView{
    
//   SCUserInfo *model= [SCUserInfo getUserModel];
//    
//    int type = model.enterprise_id.intValue;
//   
//    //没有完善企业信息的企业用户
//    if (type != 0) {
//        NSDictionary * parameter = @{@"businessId" : @(type),
//                                     @"type": @0,
//                                     };
//        [self showHudInView:self.view hint:nil];
//        [JZLNetworkingTool postWithUrl:GetEnterprise params:parameter isReadCache:0 success:^(NSURLSessionDataTask *task, id responseObject) {
//            [self hideHud];
//        } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
//            [self hideHud];
//            [self showHint:@"列表服务器没开"];
//        }];
//    
//    }
    
}

#pragma mark 点击完成
-(void)registerEnterprise{
////////////////???? 座机
//    NSString * theMain;
//    switch (self.engageIn) {
//        case 0: //专营B
//           theMain = @"B";
//            break;
//        case 1: //多营。A
//            theMain = @"A";
//  
//            break;
//        case 2: //配件C
//            theMain = @"C";
//            break;
//        case 3: //精品D
//            theMain = @"D";
//            break;
//            
//        default:
//            break;
//    }
//    SCUserInfo *model= [SCUserInfo getUserModel];
//    int type = model.enterprise_id.intValue;
//    NSString * UID = [NSString stringWithFormat:@"%@",model.uid];
//    int city = [SCUserInfo getEnterpriseCity].intValue;
//
//    
//    NSString  *zhuyingID = self.zhuyingIDs ? self.zhuyingIDs : @"";
//    NSString  *zhuanyingIDs = self.zhuanyingIDs ? self.zhuanyingIDs : @"";
//    NSString  *jianyingIDs = self.jianyingIDs ? self.jianyingIDs : @"";
//    NSString  *jingpinIDs = self.jingpinIDs ? self.jingpinIDs : @"";
//    NSString  *peijianIDs = self.peijianIDs ? self.peijianIDs : @"";
//    NSArray * jianyings = [jianyingIDs componentsSeparatedByString:@","];
//    
//    NSString *jianying1;
//    NSString * jianying2;
//    if (jianyings.count==0) {
//       jianying1= @"";
//       jianying2= @"";
//
//    }else if(jianyings.count==1){
//    
//        jianying1= jianyings[0];
//        jianying2= @"";
//    }else{
//        jianying1= jianyings[0];
//        jianying2= jianyings[1];
//    }
//    
//    if(kStringIsEmpty(self.picUrl)){
//       self.picUrl = @"";
//    }
//    
//    
//    
//    NSLog(@"%@===%@===",self.enterprisePhone.text,self.enterpriseMobile.text);
//    //没有完善企业信息的企业用户
//    if (type == 0) {
//        NSDictionary * parameter = @{
//                                     @"uid" : @(UID.intValue),
//                                     @"pic1": self.picUrl,
//                                     @"companyName" :self.enterpriseName.text ,
//                                     @"address": self.enterpriseAdress.text,
//                                     @"cellPhone": self.enterprisePhone.text,
//                                     @"zone" : @010,
//                                     @"tel" : self.enterpriseMobile.text,
//                                     @"theMain": theMain,
//                                     @"zhuYing" : zhuyingID,
//                                     @"zhuanYing": zhuanyingIDs,
//                                     @"jianYing1" : jianying1,
//                                     @"jianYing2": jianying2,
//                                     @"peiJian" : peijianIDs,
//                                     @"jingPin": jingpinIDs,
//                                     @"city": @(city),
//                                     };
//        [self showHudInView:self.view hint:nil];
//        [JZLNetworkingTool postWithUrl:RegisterEnterprise params:parameter isReadCache:0 success:^(NSURLSessionDataTask *task, id responseObject) {
//            [self hideHud];
//        } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
//            [self hideHud];
//            [self showHint:@"列表服务器没开"];
//        }];
//        
//    }else{
//        [self showHint:@"企业已注册"];
//    }

}

-(void)uploadImage{
//    //    UIImage *   iconImg =  self.icon.image;
//    //
//    //
//    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"WE.jpg" ofType:nil];
//    //    NSData *data = [NSData dataWithContentsOfFile:path];
//    
//    NSData *datax = nil;
//    
//    if (self.photoArr[0]){
//        datax= UIImageJPEGRepresentation(self.photoArr[0], 0.1);
//    }else{
//        datax= UIImageJPEGRepresentation([UIImage imageNamed:@"touxiang"], 0.1);
//    }
//    
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    // 设置时间格式
//    formatter.dateFormat = @"yyyyMMddHHmmss";
//    NSString *str = [formatter stringFromDate:[NSDate date]];
//    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
//    
//    [self showHudInView:self.view hint:nil];
//    [JZLNetworkingTool uploadWithUrl:UploadImage params:nil fileData:datax name:@"upfile" fileName:fileName mimeType:@"image/jpeg" progress:^(NSProgress *progress) {
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        self.picUrl = responseObject[@"url"];
//        [self hideHud];
//    } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
//        NSLog(@"%@",error);
//    }];
}
@end
