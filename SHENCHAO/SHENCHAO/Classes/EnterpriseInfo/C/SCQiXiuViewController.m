
//
//  SCQiXiuViewController.m
//  汽车配件
//
//  Created by cb on 2017/3/29.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCQiXiuViewController.h"
#import "SCQIPeiQIxiuHeaderView.h"
#import "SCWhichEnterpriseViewController.h"
#import "SCWorkerManageViewController.h"

#import "SCWorkerListViewController.h"
#import "SCWorkerModel.h"
#import "LXAlertView.h"


//相册相关

#import "ACMediaFrame.h"


#import "SCActionSheet.h"

#import "SCQipeiListDispalyViewController.h"

//配件列表
#import "JianuyongBandsViewController.h"

//模型存储
#import "NSObject+SaveModelArray.h"
#import "FDCellModel.h"


//名片扫描
//#import "CCPTakePicturesController.h"
//#import "CCPPhotoAlbumViewController.h"
//#import "CCPShowPhotoVC.h"
//#import "CCPBecomeBeautifulController.h"
#import "JPhotoMagenage.h"

//汉王头文件
#import "HWCloudsdk.h"

@interface SCQiXiuViewController ()<UITableViewDelegate,UITableViewDataSource,iconclickDelegete,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
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

/*上传的图片地址*/
@property(nonatomic,copy)NSString  * picUrl;

//擅长车型

@property(nonatomic,strong)UILabel *ShanChang;
@property(nonatomic,copy)NSString *ShanChangIDs;


/** ACSelectMediaView object */
@property (nonatomic, weak) ACSelectMediaView *mediaView;
@end

@implementation SCQiXiuViewController

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
-(void)leftclick{
    [self.navigationController   popViewControllerAnimated:1];
}

#pragma mark 完成
-(void)rightclick{
    //判断信息是否完整
    [self  isEmpty];
    [self  registerEnterprise];
}

-(void)showServiseL{
        LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"完善成功" message:@"恭喜您拥有自己的企业，您已成为企业的管理员，您还可以在自己的企业里添加两名客服人人员" cancelBtnTitle:@"先等等" otherBtnTitle:@"现在就去" clickIndexBlock:^(NSInteger clickIndex,NSString * textInput) {
            //        NSLog(@"点击index====%ld",clickIndex);
    
    
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
    if (kStringIsEmpty(self.enterpriseName.text)) {
        [self  showHint:@"企业名称不能为空"];
    }else if (kStringIsEmpty(self.enterpriseAdress.text)){
        [self  showHint:@"企业地址不能为空"];
    }else if (kStringIsEmpty(self.enterprisePhone.text)){
        [self  showHint:@"移动电话不能为空"];
    }else if (kStringIsEmpty(self.ShanChang.text)){
        [self  showHint:@"请选择擅长车型"];
    }else{
        [self  registerEnterprise];
        
    }
}
-(void)registerEnterprise{
    
    
//    SCUserInfo *model= [SCUserInfo getUserModel];
//    
//    int type = model.enterprise_id.intValue;
//    NSString * UID = [NSString stringWithFormat:@"%@",model.uid];
//    
//    int city = [SCUserInfo getEnterpriseCity].intValue;
//    
//    //没有完善企业信息的企业用户
//    if (type != 0) {
//        NSDictionary * parameter = @{
//                                     @"uid" : @(UID.intValue),
//                                     @"pic1": self.picUrl,
//                                     @"companyName" :self.enterpriseName.text ,
//                                     @"address": self.enterpriseAdress.text,
//                                     @"cellPhone": self.enterprisePhone.text,
//                                     @"zone" : @(type),
//                                     @"tel" : self.enterpriseMobile.text,
//                                     
//                                     @"theMain": @2,
//                                     @"zhuYing" : @(type),
//                                     @"zhuanYing": @0,
//                                     @"jianYing1" : @(type),
//                                     @"jianYing2": @0,
//                                     @"peiJian" : @(type),
//                                     @"jingPin": @0,
//                                     @"city": @(city),
//                                     };
//        [self showHudInView:self.view hint:nil];
//        [JZLNetworkingTool postWithUrl:RegisterEnterprise params:parameter isReadCache:0 success:^(NSURLSessionDataTask *task, id responseObject) {
//            [self hideHud];
//            
//            
//            //注册信息外完成去完成客服信息
//            
            [self showServiseL];
//
//        } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
//            [self hideHud];
//            [self showHint:@"列表服务器没开"];
//        }];
//    }
    
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
        for (ACMediaModel * model in list) {
            //遍历得到模型中想要的数据  e.g
            // id uplodaType = model.uploadType;
            // NSString *name = model.name;
        }
        NSLog(@"list.count = %lu",(unsigned long)list.count);
    }];
    [headerView addSubview:mediaView];
    
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMaxY(mediaView.frame));
    self.tableview.tableHeaderView = headerView;
 
}
#pragma mark  tableviewdeldegate
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
            return   1;
            break;
        default:
            return   0;
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
            sectionTitle.text = @"维修范围";
        }
            break;
        default:
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
        }else{
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"two"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.row==0) {
                UIImageView * arrow =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenW-30, 15, 10, 15)];
                arrow.image  =  [UIImage imageNamed:@"gengduo"];
                [cell.contentView addSubview:arrow];
                UILabel *brandNameL = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreenW-50, 20)];
                brandNameL.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                brandNameL.text = @"本田";
                brandNameL.textAlignment = NSTextAlignmentRight;
                brandNameL.textColor = SCLightGrayColor;
                [cell.contentView addSubview:brandNameL];
                self.ShanChang=brandNameL;
                cell.textLabel.text = @"擅长车型";
                cell.textLabel.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];

            }else{
            }
 
        }
    }
    
    return cell;
}
-(void)iconSelect{
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==2 ) {
        JianuyongBandsViewController *search = [JianuyongBandsViewController new];
        search.title =  @"兼营选择列表";
        search.callBackBlok = ^(NSArray *arrString) {
            self.ShanChang.text=[self enumerateArrayString:arrString];
            self.ShanChangIDs = [self jointSyringID:arrString];
        };
        [self.navigationController pushViewController:search animated:YES];
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

#pragma mark 头像选择
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
//名片扫描
-(void)IDcardClick:(UIButton *)btn{

//    CCPTakePicturesController *picturesVC = [[CCPTakePicturesController alloc] init];
//    __weak typeof(self) weakSelf = self;
//    //获取截图
//    picturesVC.iconImage = ^(UIImage *iconImage) {
//        [weakSelf  scangogo:iconImage];
//    };
//    [self presentViewController:picturesVC animated:YES completion:nil];
    
#pragma mark 拍照

        SCWeakSelf(self);
        [JPhotoMagenage JphotoTakePhotoInController:self finish:^(UIImage *image) {
            [_iconBtn  setImage:image forState:UIControlStateNormal];
            [weakself uploadImage];
        } cancel:^{
        }];
    
  
};
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

-(void)pickview{
    
//    self.photoArr =[NSMutableArray arrayWithCapacity:1];
//    
//    
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
/*
 上传头像
 */
-(void)uploadImage{
//    [self showHudInView:self.view hint:NSLocalizedString(@"login.ongoing", @"Is Login...")];
//    
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
//    [JZLNetworkingTool uploadWithUrl:UploadImage params:nil fileData:datax name:@"upfile" fileName:fileName mimeType:@"image/jpeg" progress:^(NSProgress *progress) {
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        self.picUrl = responseObject[@"url"];
//        [self hideHud];
//    } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
//        NSLog(@"%@",error);
//    }];
}



@end
