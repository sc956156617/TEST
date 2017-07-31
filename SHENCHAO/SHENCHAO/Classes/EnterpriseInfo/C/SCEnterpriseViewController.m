
//
//  SCEnterpriseViewController.m
//  汽车配件
//
//  Created by cb on 2017/3/28.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCEnterpriseViewController.h"
#import "SCEnterpriseOneIconView.h"
#import "SCWhichEnterpriseViewController.h"



#import "SCActionSheet.h"
#import "JPhotoMagenage.h"

#import "ZmjPickView.h"

#import "AppDelegate.h"

#import "SCUserInfo.h"
#import "JZLNetworkingTool.h"
@interface SCEnterpriseViewController ()<UITableViewDelegate,UITableViewDataSource,iconclickDelegete,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UITableView *tableview;
//昵称
@property(nonatomic,strong)UITextField *nameLX;
//详细地址
@property(nonatomic,strong)UITextField *addressLX;
//身份证号
@property(nonatomic,strong)UITextField *IDNO_LX;
//性别
@property(nonatomic,strong)UILabel *sexL;

@property(nonatomic,strong)UILabel *addressL;
//省市县字符保存
@property(nonatomic,copy)NSString  * areaX;
//照片容器
@property (nonatomic,strong)NSMutableArray * photoArr;

@property (nonatomic,strong)UIButton *iconBtn;
/*上传的图片地址*/
@property(nonatomic,copy)NSString  * picUrl;

@property (strong, nonatomic) ZmjPickView *zmjPickView;

@end

@implementation SCEnterpriseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //企业界面是否进入过
//    [SCUserDefaults setBool:true forKey:@FIRSTLOGIN];
    [self  setNavigation];
    [self setUpchildViewes];
}
-(void)setNavigation{
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"完善个人信息";
//   self.navigationItem.leftBarButtonItem = [SCColorTypeTools itemWithTitleName:@"跳过" highTitleName:@"跳过" addTarget:self action:@selector(editClick:) tintColor:nil];
}
-(void)editClick:(UIButton *)btn{
  
//    ViewTabBarController *VC = [[ViewTabBarController alloc]init];
//    AppDelegate * app =(AppDelegate *)[UIApplication sharedApplication].delegate;
//    app.window.rootViewController = VC;
////    [app.window makeKeyAndVisible];
    
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
        [_tableview registerClass:[SCEnterpriseOneIconView class] forHeaderFooterViewReuseIdentifier:@"header"];
    }
    return _tableview;
}
- (void)setUpchildViewes {
    
    //添加tableview
    [self.view addSubview:self.tableview];
    //关闭
    SCEnterpriseOneIconView * herderview =[[SCEnterpriseOneIconView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
    //设置
    herderview.delegegate = self;
    self.tableview.tableHeaderView = herderview;
    
    //下一步按钮
    UIButton *logintouch=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logintouch setTitle:@"完成" forState:UIControlStateNormal];
    [logintouch setTitleColor:SCThemeColor forState:UIControlStateNormal];
    logintouch.titleLabel.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
    [logintouch setFrame:CGRectMake(0, kScreenH-85-64, 90, 35)];
    logintouch.centerX = self.view.centerX;
    logintouch.backgroundColor = [UIColor whiteColor];
    logintouch.layer.masksToBounds = YES;
    logintouch.layer.cornerRadius = 5;
    logintouch.layer.borderColor = SCThemeColor.CGColor;
    logintouch.layer.borderWidth = 1;
    [logintouch addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logintouch];
}

#pragma mark  信息修改提交信息
-(void)nextClick:(UIButton *)btn{
//    NSLog(@"%@+++++%@+++++%@",self.nameLX.text,self.sexL.text,self.addressL.text);
    if ( [self.nameLX.text isEqualToString:@""]) {
        [self showHint:@"昵称不能为空"];
    }else if ([self.sexL.text isEqualToString:@""]){
        [self showHint:@"请输入性别"];
    }else if([self.addressL.text isEqualToString:@""]) {
        [self showHint:@"请选择地区"];
    }else{
        [self.view endEditing:YES];
        [self  changeUserInfo];
    }
}
-(void)changeUserInfo {
    NSString * sexX;
    if ( [sexX isEqualToString:@"男"]) {
        sexX = @"1";
    }else if ( [sexX isEqualToString:@"女"]){
        sexX = @"2";
    }else{
        sexX = @"0";
    }
    
    NSString * picX;
    if (kStringIsEmpty(_picUrl)) {
        picX = @"";
    }else{
        picX = _picUrl;
    }
    if (kStringIsEmpty(_picUrl)) {
        picX = @"";
    }else{
        picX = _picUrl;
    }
    if (kStringIsEmpty(_addressLX.text)) {
        _addressLX.text = @"";
    }
    if (kStringIsEmpty(_IDNO_LX.text)) {
        _IDNO_LX.text = @"";
    }
    SCLOG(@"%@==%@==%@=%@=%@=%@=%@",[SCUserInfo getAcountInfo][0],_nameLX.text,_picUrl,_areaX,_addressLX.text,sexX,_IDNO_LX.text);
    NSDictionary * para = @{
                            @"phone": [SCUserInfo getAcountInfo][0],
                            @"userName":_nameLX.text,
                            @"headUrl" : _picUrl,
                            @"cityId":_areaX ,
                            @"address":  _addressLX.text,
                            @"sex":sexX,
                            @"identity" :_IDNO_LX.text
                            };
    [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,UPINFO] params:para loadingImageArr:nil toShowView:nil success:^(id response) {
        NSLog(@"%@",response);
        if([response[@"code"]  isEqual: @1001]){
            [self.navigationController pushViewController:[NSClassFromString(@"SCLoginViewController") new] animated:1];
        }
    } fail:^(NSError *error){
        [SCProgressHUD showAlertView:@"tips" andMessage:[NSString stringWithFormat:@"%@",error]];
    } showHUD:1];
    
//   [[JZLNetworkingTool sharedManager] POST:ModifyInfoURL parameters:para success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull      responseObject) {
//        NSLog(@"%@",responseObject);
//        //        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        if ([responseObject[@"code"]integerValue]==0) {
//            NSMutableDictionary * userInfo = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]];
//            //            [userInfo setObject:dic[@"data"][@"headsmall"] forKey:@"headsmall"];
//            [[NSUserDefaults standardUserDefaults]setObject:userInfo forKey:@"userInfo"];
////            [self.navigationController popViewControllerAnimated:YES];
//            SCWhichEnterpriseViewController *vc =[SCWhichEnterpriseViewController new];
//            vc.canBack = NO;
//            [self.navigationController pushViewController:vc animated:1];
//            [self hideHud];
//        }else if ([responseObject[@"code"]integerValue]==-2){
//            [self showHint:@"请填写个人信息"];
//        }else if ([responseObject[@"code"]integerValue]==-3){
//            [self.navigationController popViewControllerAnimated:YES];
//        }else if ([responseObject[@"code"]integerValue]==-4){
//            [self showHint:@"身份号位数不对"];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self showHint:@"请检查网络状况"];
//    }];
}
-(void)uploadImage{
    UIImage *  image =  self.iconBtn.imageView.image;
    SCWeakSelf(self);
    [CCPNetworking uploadWith:UpLoadTypeImage fileArr:@[image] url:[NSString stringWithFormat:@"%@%@",HTTPHEADER,UPLOADIMAGE] filename:nil names:@[@"upfile"] params:nil loadingImageArr:nil toShowView:nil progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    } success:^(id response) {
        SCLOG(@"%@",response);
        weakself.picUrl = response[@"dictionary"][@"imageUrl"];
    } fail:^(NSError *error) {
        [SCProgressHUD showAlertView:@"tips" andMessage:[NSString stringWithFormat:@"%@",error]];
    } showHUD:1];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
         return   1;
            break;
        case 1:
            return   2;
            break;
        case 2:
            return   2;
            break;
        default:
            return   0;
            break;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 12)];
        lineV.backgroundColor = SCLineGrayColor;
    return lineV;
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

//            cell.textLabel.text = @"昵称";
//            cell.detailTextLabel.text = @"区分大小写不超过6个字符";
            
            UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
            UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
            nameL.text = @"昵称";
            nameL.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                       nameL.centerY = view.centerY;
            [nameL  sizeToFit];
            [view addSubview:nameL];
            UITextField *nameLX = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameL.frame)+30, 15, 3000, 20)];
            nameLX.placeholder = @"区分大小写不超过6个字符";
//            [nameLX  sizeToFit];
//            nameLX.centerY = nameLX.centerY;
            nameLX.textColor = SCLightGrayColor;
            self.nameLX = nameLX;
            nameLX.font =[UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
            [view addSubview:nameLX];
            [cell.contentView addSubview:view];
            
        }else if (indexPath.section==1){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"two"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            if (indexPath.row==0) {
                UIImageView * arrow =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenW-30, 20, 10, 15)];
                arrow.image  =  [UIImage imageNamed:@"gengduo"];
                [cell.contentView addSubview:arrow];
                cell.textLabel.text = @"性别";
                cell.textLabel.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                
                UILabel *brandNameL = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreenW-50, 20)];
                brandNameL.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                brandNameL.text = @"";
                brandNameL.textAlignment = NSTextAlignmentRight;
                brandNameL.textColor = SCLightGrayColor;
                self.sexL = brandNameL;
                [cell.contentView addSubview:brandNameL];

            }else{
                UIImageView * arrow =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenW-30, 20, 10, 15)];
                arrow.image  =  [UIImage imageNamed:@"gengduo"];
                [cell.contentView addSubview:arrow];
                UIView *line =[[UIView alloc]initWithFrame:CGRectMake(20, 0, kScreenW, 1)];
                line.backgroundColor = SCLineGrayColor;
                [cell.contentView addSubview:line];
                cell.textLabel.text = @"地区";
                cell.textLabel.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                
                UILabel *brandNameL = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreenW-50, 20)];
                brandNameL.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                brandNameL.text = @"";
                brandNameL.textAlignment = NSTextAlignmentRight;
                brandNameL.textColor = SCLightGrayColor;
                self.addressL = brandNameL;
                [cell.contentView addSubview:brandNameL];
            }
        }else{
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"two"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.row==0) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"one"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
                UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
                nameL.text = @"详细地址";
                nameL.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                nameL.centerY = view.centerY;
                [nameL  sizeToFit];
                [view addSubview:nameL];
                
                UITextField *nameLX = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameL.frame)+30, 15, 3000, 20)];
                nameLX.placeholder = @"区分大小写不超过6个字符";
                nameLX.textColor = SCLightGrayColor;
                nameLX.font =[UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                [view addSubview:nameLX];
                self.addressLX = nameLX;
                [cell.contentView addSubview:view];
            }else{
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"one"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
                UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
                nameL.text = @"身份证号";
                nameL.font =[UIFont systemFontOfSize:AdapationLabelFont(17)];
                nameL.centerY = view.centerY;
                [nameL  sizeToFit];
                [view addSubview:nameL];
                
                UITextField *nameLX = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameL.frame)+30, 15, 3000, 20)];
                nameLX.placeholder = @"您更改手机号的重要凭证（选填）";
                nameLX.textColor = SCLightGrayColor;
                nameLX.font =[UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
                [view addSubview:nameLX];
                self.IDNO_LX = nameLX;
                [cell.contentView addSubview:view];
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1 && indexPath.row==0) {
        [SCActionSheet showWithTitle:@"请选择您的性别" destructiveTitle:nil otherTitles:@[@"男",@"女",@"保密"] block:^(int index) {
            switch (index) {
                case 0:
                    self.sexL.text = @"男";
                    break;
                case 1:
                    self.sexL.text = @"女";
                    break;
                default:
                    self.sexL.text = @"保密";
                    break;
            }
        }];
    }
    if (indexPath.section==1 && indexPath.row==1) {
        [self zmjPickView];
        [_zmjPickView show];
        __weak typeof(self) weakSelf = self;
        _zmjPickView.determineBtnBlock = ^(NSInteger shengId, NSInteger shiId, NSInteger xianId, NSString *shengName, NSString *shiName, NSString *xianName){
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf ShengId:shengId ShiId:shiId XianId:xianId];
            [strongSelf ShengName:shengName ShiName:shiName XianName:xianName];
        };
    }
}

#pragma mark  pickview  deldegate
- (void)ShengId:(NSInteger)shengId ShiId:(NSInteger)shiId XianId:(NSInteger)xianId{
    self.areaX = [NSString stringWithFormat:@"%ld",xianId];
//    NSLog(@"%ld,%ld,%ld",shengId,shiId,xianId);
}

- (void)ShengName:(NSString *)shengName ShiName:(NSString *)shiName XianName:(NSString *)xianName{
    self.addressL.text = [NSString stringWithFormat:@"%@-%@-%@",shengName,shiName,xianName];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:AdapationLabelFont(20)]};
    CGSize size=[self.addressL.text sizeWithAttributes:attrs];
    self.addressL.width =  size.width;
    self.addressL.x = kScreenW - size.width-40;
}
-(void)logintouchclicke:(UIButton *)btn{
    [self.navigationController popToRootViewControllerAnimated:1];
}
#pragma mark 头像选择
-(void)passIconmclick:(UIButton *)btn{
    self.iconBtn = btn;
    [SCActionSheet showWithTitle:@"/上传一张满意的头像吧" destructiveTitle:nil otherTitles:@[@"从相册中选取",@"拍照"] block:^(int index) {
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
    SCWeakSelf(self);
    [JPhotoMagenage JphotoGetFromSystemInController:self finish:^(UIImage *image) {
        [_iconBtn  setImage:image forState:UIControlStateNormal];
        [weakself uploadImage];
    } cancel:^{
        
    }];
}
//- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
//    //maxfileSize : 压缩后最大字节数
//    CGFloat compression = 0.9f; //像素压缩比例
//    CGFloat maxCompression = 0.1f;  //压缩最大比例
//    NSData *imageData = UIImageJPEGRepresentation(image, compression);
//    while ([imageData length] > maxFileSize && compression > maxCompression) {
//        compression -= 0.1;
//        imageData = UIImageJPEGRepresentation(image, compression);
//        if (compression==0.1) {
//            maxFileSize = [imageData length];
//        }
//    }
//    UIImage *compressedImage = [UIImage imageWithData:imageData];
//    return compressedImage;
//}
#pragma mark 拍照
-(void)takePhoto{
    SCWeakSelf(self);
    [JPhotoMagenage JphotoTakePhotoInController:self finish:^(UIImage *image) {
        [_iconBtn  setImage:image forState:UIControlStateNormal];
        [weakself uploadImage];
    } cancel:^{
    }];
    
//    debug
//    //资源类型为照相机
//    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
//    //判断是否有相机
//    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        //设置拍照后的图片可被编辑
//        picker.allowsEditing = YES;
//        //资源类型为照相机
//        picker.sourceType = sourceType;
//        [self presentViewController:picker animated:YES completion:nil];
//    }
//    else {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"该设备没有摄像头" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [alertController addAction:okAction];
//        [self presentViewController:alertController animated:YES completion:nil];
//        
//    }
}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//{
//      // 获取选中的图片
//      UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
////    [self performSelector:@selector(saveImage:)  withObject:_image afterDelay:0.5];
//      [picker dismissViewControllerAnimated:YES completion:nil];
//    
//      self.photoArr = [NSMutableArray arrayWithObject:image];
//      [self.iconBtn setImage:image forState:UIControlStateNormal];
//
//      //上传图片。获取地址
//      [self uploadImage];
//    
//    
//}
- (ZmjPickView *)zmjPickView {
    if (!_zmjPickView) {
        _zmjPickView = [[ZmjPickView alloc]init];
    }
    return _zmjPickView;
}
@end
