//
//  PersonInfoDisplayViewController.m
//  SHENCHAO
//
//  Created by cb on 2017/7/4.
//  Copyright © 2017年 SC. All rights reserved.
#import "PersonInfoDisplayViewController.h"
#import "UIBarButtonItem+Item.h"
#import "WRNavigationBar.h"
#import "AppDelegate.h"
#import "ZmjPickView.h"
#import "SCActionSheet.h"
#import "LXAlertView.h"
#import "JPhotoMagenage.h"
#import "SCUserInfo.h"
#import "NSString+SCTool.h"
#import "MJExtension.h"
#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 220
#define NAV_HEIGHT 64
@interface PersonInfoDisplayViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tablev;
@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *fansLabel;
@property (nonatomic, strong) UILabel *detailsLabel;

@property(nonatomic,copy)NSString  * picUrl; //icon
@property(nonatomic,copy)NSString  * picUrlX; //bgimage

@property(nonatomic,copy)NSString  * uploadTape;

@property(nonatomic,strong)NSArray *datasArr;
 @property(nonatomic,strong)  SCUserInfo * model;
@property (strong, nonatomic) ZmjPickView *zmjPickView;
@end

@implementation PersonInfoDisplayViewController

#pragma mark - tableview delegate / dataSourc

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return IMAGE_HEIGHT-20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return   self.datasArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if( indexPath.row == 0){
            return  80;
        }else{
            return 50;
        }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //分割线
        UILabel * line =[[UILabel alloc]initWithFrame: CGRectMake(0, 1, kScreenW, 1)];
        line.backgroundColor = SCLineGrayColor;
        [cell.contentView addSubview:line];
    }
    
    
    cell.textLabel.text = self.datasArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SCWeakSelf(self);

    switch (indexPath.row) {
        case 0: {
            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"信息更改" textView:@"新昵称" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex,NSString * textInput) {
                switch (clickIndex) {
                    case 0:
                        break;
                    case 1:{
                        weakself.model.nickname = textInput;
                        weakself.nameLabel.text = textInput;
                        [SCUserDefaults setObject:textInput forKey:@USERNICKNAME];
                        [weakself  changeNicknameWith:textInput];
                    }
                        break;
                        
                    default:
                        break;
                }
            }];
            alert.animationStyle=LXASAnimationTopShake;
            [alert showLXAlertView];
        
        } break;
        case 3: {
            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"135****3423" message:@"手机号代表着您的身份,如需更改请拨打我们的客户电话" cancelBtnTitle:@"只是看看" otherBtnTitle:@"立即拨打" clickIndexBlock:^(NSInteger clickIndex,NSString * textInput){ }];
            alert.animationStyle=LXASAnimationTopShake;
            [alert showLXAlertView];
        } break;
        case 1: {
        [SCActionSheet showWithTitle:@"请选择您的性别" destructiveTitle:nil otherTitles:@[@"男",@"女"] block:^(int index) {
                    switch (index) {
                        case 0: {
                            _model.sex = @"1";
                            _fansLabel.text =[NSString stringWithFormat:@"%@  |  %@",[SCColorTypeTools getSexStringWith:_model.sex], [SCColorTypeTools  getAreaStringWith:_model.area ]];
                            [self  changeSexWith:@"1"];
                        }      break;
                        case 1:  {
                            _model.sex = @"2";
                         _fansLabel.text =[NSString stringWithFormat:@"%@  |  %@",[SCColorTypeTools getSexStringWith:_model.sex], [SCColorTypeTools  getAreaStringWith:_model.area ]];                            [self  changeSexWith:@"2"];

                        }  break;
                    default:
                        _model.sex = @"0";
                   _fansLabel.text =[NSString stringWithFormat:@"%@  |  %@",[SCColorTypeTools getSexStringWith:_model.sex], [SCColorTypeTools  getAreaStringWith:_model.area ]];
                            [self  changeSexWith:@"0"];
                            break;
                    
                    }}];
        } break;
        case 2: {
           
            [self zmjPickView];[_zmjPickView show];
            _zmjPickView.determineBtnBlock = ^(NSInteger shengId, NSInteger shiId, NSInteger xianId, NSString *shengName, NSString *shiName, NSString *xianName) {
                weakself.model.area = [NSString stringWithFormat:@"%ld",(long)xianId];
                [weakself changeAreaWith:  weakself.model.area];
                weakself.fansLabel.text = [NSString stringWithFormat:@"%@  |  %@",[SCColorTypeTools getSexStringWith:weakself.model.sex], [SCColorTypeTools  getAreaStringWith:weakself.model.area]];

//                [weakself ShengId:shengId ShiId:shiId XianId:xianId];
//                [weakself ShengName:shengName ShiName:shiName XianName:xianName];
            };
        } break;
        case 5: {
            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"信息更改" textView:@"新签名" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex,NSString * textInput) {
                switch (clickIndex) {
                    case 0:
                        break;
                    case 1:{
                        NSLog(@"%@",textInput);
                        weakself.model.signature = textInput;
                        weakself.detailsLabel.text  = textInput;
                        [SCUserDefaults setObject:textInput forKey:@USERNICKNAME];
                        [weakself  changeAutographWith:textInput];
                    }
                        break;
                        
                    default:
                        break;
                }
            }];
            alert.animationStyle=LXASAnimationTopShake;
            [alert showLXAlertView];
        } break;
        case 4: {
        
            [self.navigationController pushViewController:[NSClassFromString(@"SCDisplayErweimaViewController") new] animated:1];

        } break;
        case 6: {} break;
        case 7: {} break;
        default: break;
    }
   
}
- (void)didTipBackgroud{


}

#pragma mark 头像选择

-(void)pickview{
    SCWeakSelf(self);
    [JPhotoMagenage JphotoGetFromSystemInController:self finish:^(UIImage *image) {
        if ( [_uploadTape isEqualToString: @"1"]) { //背景
            _topView.image = image;
            [weakself uploadImage];
        }else if ([_uploadTape isEqualToString: @"2"]){
            _iconView.image = image;
            [weakself uploadImage];
        }else{
            
        }
    } cancel:^{
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        self.title = @"wangrui460";
    }
    else
    {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTintColor:[UIColor whiteColor]];
        [self wr_setNavBarTitleColor:[UIColor whiteColor]];
        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        self.title = @"";
    }
}

//背景点击
-(void)singleTapAction:(id)gt
{
    
    NSString * title = @"";
    if ([NSStringFromClass([gt class]) isEqualToString:@"UIButton"]){
        title = @"定义自己的个性背景图吧";
        _uploadTape = @"1";

    }else{
        title = @"定义自己的个性头像吧";
        _uploadTape = @"2";

    }
    [SCActionSheet showWithTitle:title  destructiveTitle:nil otherTitles:@[@"从相册中选取",@"拍照"] block:^(int index) {
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
#pragma mark 拍照
-(void)takePhoto{
    SCWeakSelf(self);
    [JPhotoMagenage JphotoTakePhotoInController:self finish:^(UIImage *image) {
        
        if ( [_uploadTape isEqualToString: @"1"]) { //背景
          [_topView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEHEADER,_model.background]] placeholderImage:[UIImage imageNamed:@"wbBG"]];
            [weakself uploadImage];
        }else if ([_uploadTape isEqualToString: @"2"]){
            _iconView.image = image;
            [weakself uploadImage];
        }else{
            
        }

     
    } cancel:^{
        
    }];
}


/*
 上传图片
 */
-(void)uploadImage{
    UIImage *  image =  self.iconView.image;
    SCWeakSelf(self);
    [CCPNetworking uploadWith:UpLoadTypeImage fileArr:@[image] url:[NSString stringWithFormat:@"%@%@",HTTPHEADER,UPLOADIMAGE] filename:nil names:@[@"upfile"] params:nil loadingImageArr:nil toShowView:nil progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    } success:^(id response) {
        SCLOG(@"%@",response);
        if([response[@"code"]  isEqual: @1001]){
            [SCProgressHUD hideHUDForView:kUIWindow animated:0];
            if ( [_uploadTape isEqualToString: @"1"]) { //背景
                weakself.picUrl = response[@"dictionary"][@"imageUrl"];
                [weakself  changeBGIMAGE];
            }else if ([_uploadTape isEqualToString: @"2"]){
                weakself.picUrlX = response[@"dictionary"][@"imageUrl"];
                [weakself  changeICON];
            }else{
                
            }
        }
        
    } fail:^(NSError *error) {
        [SCProgressHUD showAlertView:@"tips" andMessage:[NSString stringWithFormat:@"%@",error]];
    } showHUD:1];
}
-(void)changeBGIMAGE{

    [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,CHANGEBACKGROUND]
                               params:@{
                                        @"token": [SCUserDefaults objectForKey:@USERTOKEN],
                                        @"imageUrl":_picUrl
                                        }
                      loadingImageArr:nil toShowView:nil
                              success:^(id response) {
                                  NSLog(@"%@",response);
                                  if([response[@"code"]  isEqual: @1001]){
                                      [SCUserDefaults setObject:response[@"dictionary"][@"backgroundImageUrl"] forKey:@USERBACKGROUND];
                                      NSLog(@"%@",_picUrl);
                                      _picUrl = nil;
                                      _uploadTape = nil;
                                  }
                              } fail:^(NSError *error) {
                                  
                              } showHUD:1] ;
}
-(void)changeICON{
    
    NSLog(@"%@",_picUrlX);
    [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,UPDATEHEAD]
                               params:@{
                                        @"token": [SCUserDefaults objectForKey:@USERTOKEN],
                                        @"headUrl":_picUrlX
                                        }
                      loadingImageArr:nil toShowView:nil
                              success:^(id response) {
                                  NSLog(@"%@",response);
                                  if([response[@"code"]  isEqual: @1001]){
                                      [SCUserDefaults setObject:response[@"dictionary"][@"headUrl"] forKey:@USERHEADSMAALL];
                                      _picUrlX = nil;
                                      _uploadTape = nil;
                                  }
                              } fail:^(NSError *error) {
                                  NSLog(@"%@",error);
                              } showHUD:1] ;
}
//修改那个人信息
-(void)changeUserInfo {
//    
//    SCUserInfo *model =  [SCUserInfo getUserModel];
//    
//    //    NSDictionary * para = @{@"uid":uid,@"nickname":_userInfoDic[@"nickname"],@"area":_arraycity ,@"sex":_arraysex,@"signature":_userInfoDic[@"signature"],@"qr_code":_userInfoDic[@"qr_code"],@"address":_userInfoDic[@"address"]};
//    NSString * sexX;
//    if (kStringIsEmpty(_sex.text)) {
//        sexX = @"0";
//    }else if([_sex.text isEqualToString:@"男"]){
//        sexX =@"1";
//    }else if([_sex.text isEqualToString:@"女"]){
//        sexX =@"2";
//    }else{
//        sexX =@"0";
//    }
//    NSString * picX;
//    if (kStringIsEmpty(_picUrl)) {
//        picX = @"xxxx";
//    }else{
//        picX = _picUrl;
//    }
//    
//    NSLog(@"%@==%@====%@===%@====%@====%@",model.uid,_nickname.text,_area.text,picX,sexX,_sign.text);
//    
//    NSDictionary * para;
//    if (self.areaX) {
//        para = @{@"uid":model.uid,@"nickname":_nickname.text,@"area":self.areaX,@"address":_area.text,@"headsmall" : picX,@"sex":sexX,@"signature":_sign.text};
//    }else{
//        
//        para = @{@"uid":model.uid,@"nickname":_nickname.text,@"address":@"00000",@"headsmall" : picX,@"sex":sexX,@"signature":_sign.text};
//    }
//    
    
    
//    
//    [[JZLNetworkingTool sharedManager] POST:ModifyInfoURL parameters:para success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
//        //        [self showHint:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
//        //        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        if ([responseObject[@"code"]integerValue]==0) {
//            NSMutableDictionary * userInfo = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]];
//            //            [userInfo setObject:dic[@"data"][@"headsmall"] forKey:@"headsmall"];
//            [[NSUserDefaults standardUserDefaults]setObject:userInfo forKey:@"userInfo"];
//            [self.navigationController popViewControllerAnimated:YES];
//            
//            SCUserInfo * model =[SCUserInfo mj_objectWithKeyValues:responseObject[@"data"]];
//            [SCUserInfo setuserInfo:model];
//        }else if ([responseObject[@"code"]integerValue]==-2){
//            [self showHint:@"请填写个人信息"];
//        }else if ([responseObject[@"code"]integerValue]==-3){
//            [self.navigationController popViewControllerAnimated:YES];
//        }else if ([responseObject[@"code"]integerValue]==-4){
//            [self showHint:@"身份号位数不对"];
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self showHint:@"请检查网络状况"];
//    }];
}


//-(void)setModel:(UserModel *)model{
//    [self.icon  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP_Header,model.headsmall]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
//    self.nickname.text =  model.nickname;
//    self.phone.text =  model.phone;
//    [self.phone  sizeToFit];
//    
//    
//    self.sign.text = model.signature;
//    NSDictionary *attrsx = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:AdapationLabelFont(17)]};
//    CGSize sizex=[_sign.text sizeWithAttributes:attrsx];
//    _sign.x = kScreenW - sizex.width-40;
//    _sign.width =  sizex.width;
//    
//    
//    [self.erweimaV   sd_setImageWithURL:[NSURL URLWithString:model.qr_code] placeholderImage:[UIImage imageNamed:@"erweima"]];
//    if ([model.sex isEqualToString:@"0"]) {
//        self.sex.text = @"保密";
//    } else if ([model.sex isEqualToString:@"1"]) {
//        self.sex.text = @"男";
//    } else {
//        self.sex.text = @"女";
//    }
//    self.area.text = model.address;
//    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:AdapationLabelFont(17)]};
//    CGSize size=[self.area.text sizeWithAttributes:attrs];
//    self.area.width =  size.width;
//    self.area.x = kScreenW - size.width-40;
//}
//

#pragma mark  pickview  deldegate
- (void)ShengId:(NSInteger)shengId ShiId:(NSInteger)shiId XianId:(NSInteger)xianId{
//    self.areaX = [NSString stringWithFormat:@"%ld,%ld,%ld",shengId,shiId,xianId];
//    
////    [SCUserInfo setEnterpriseCity:[NSString stringWithFormat:@"%ld",shiId]];
//    
//    NSLog(@"%ld,%ld,%ld",shengId,shiId,xianId);
}

- (void)ShengName:(NSString *)shengName ShiName:(NSString *)shiName XianName:(NSString *)xianName{
//    self.area.text = [NSString stringWithFormat:@"%@-%@-%@",shengName,shiName,xianName];
//    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:AdapationLabelFont(17)]};
//    CGSize size=[self.area.text sizeWithAttributes:attrs];
//    self.area.width =  size.width;
//    self.area.x = kScreenW - size.width-40;
//    
}
#pragma mark UI / data
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.model = [SCUserInfo getUserModel];
    [self getUserInfo];
    [self setUI];
    [self  preparedata];
}
-(void)back{
    [self dismissViewControllerAnimated:1 completion:nil];
}
-(void)clickBl:(UIButton *)btn{


    [UIView animateWithDuration:1 animations:^{
        btn.frame =CGRectMake(kScreenW-50, 64, 50, kScreenH-64);
    }];

}
-(void)setUI{
    self.view.backgroundColor = [UIColor greenColor];

    self.title = @"个人信息";
    self.iconView.center = CGPointMake(self.topView.center.x, self.topView.center.y - 10);
    self.iconView.userInteractionEnabled = YES;
    self.nameLabel.frame = CGRectMake(0, self.iconView.frame.size.height + self.iconView.frame.origin.y + 6, self.view.frame.size.width, 19);
    self.fansLabel.frame = CGRectMake(0, self.nameLabel.frame.origin.y + 19 + 5, self.view.frame.size.width, 16);
    
    
    CGSize size=  [_model.signature sizeWithFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(kScreenW-20, 40)];

    self.detailsLabel.frame = CGRectMake(10, self.fansLabel.frame.origin.y + 16 + 5, size.width, size.height);
    
    //初始化一个手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    //为图片添加手势
    [self.iconView addGestureRecognizer:singleTap];
    [self.topView addSubview:self.iconView];
    [self.topView addSubview:self.nameLabel];
    [self.topView addSubview:self.fansLabel];
    [self.topView addSubview:self.detailsLabel];
    self.tableView.tableHeaderView = self.topView;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"fengmian"] highImage:[UIImage imageNamed:@"fengmian"] target:self action:@selector(singleTapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"fanhui"] highImage:[UIImage imageNamed:@"fanhui"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBar.translucent = YES;   // 设置导航栏颜色
    [self wr_setNavBarBarTintColor:[UIColor grayColor]];
    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];
    // 设置导航栏按钮和标题颜色
    [self wr_setNavBarTintColor:[UIColor whiteColor]];
    
}
-(void)preparedata{
    self.datasArr = @[@"编辑昵称",@"性别修改",@"地区修改",@"手机号查看",@"二维码查看",@"编辑个性签名"];
    self.tablev.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tablev];
}


-(void)changeSexWith:(NSString *)sex{

    [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,CHANGESEX]
                               params:@{@"token":[SCUserInfo getUserModel].token,
                                        @"sex":sex,
                                        }
                      loadingImageArr:nil toShowView:nil
                              success:^(id response) {
                                  NSLog(@"%@",response);
                                  if([response[@"code"]  isEqual: @1001]){
                                      [SCUserDefaults setObject:response[@"dictionary"][@"sex"] forKey:@USERSEX];
                                  }
                              } fail:^(NSError *error) {
                                  
                                  
                              } showHUD:1] ;
}
-(void)changeAreaWith:(NSString *)cityId{

    [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,CHANGEAREA]
                               params:@{@"token":[SCUserInfo getUserModel].token,
                                        @"cityId":cityId,
                                        }
                      loadingImageArr:nil toShowView:nil
                              success:^(id response) {
                                  NSLog(@"%@",response);
                                  if([response[@"code"]  isEqual: @1001]){
                                      [SCUserDefaults setObject:response[@"dictionary"][@"cityId"] forKey:@USERAREA];
                                  }
                                  
                              } fail:^(NSError *error) {
                                  
                              } showHUD:1] ;



}

-(void)changeNicknameWith:(NSString *)nickname{
    
    [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,CHANGENICKNAME]
                               params:@{@"token":[SCUserInfo getUserModel].token,
                                        @"userName":nickname,
                                        }
                      loadingImageArr:nil toShowView:nil
                              success:^(id response) {
                                  NSLog(@"%@",response);
                                  if([response[@"code"]  isEqual: @1001]){
                                      [SCUserDefaults setObject:response[@"dictionary"][@"userName"] forKey:@USERNICKNAME];
                                  }
                                  
                              } fail:^(NSError *error) {
                                  
                              } showHUD:1] ;
    
    
    
}
-(void)changeIdentityWith:(NSString *)Identity{
    
    [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,CHANGEIDCARD]
                               params:@{@"token":[SCUserInfo getUserModel].token,
                                        @"identity":Identity,
                                        }
                      loadingImageArr:nil toShowView:nil
                              success:^(id response) {
                                  NSLog(@"%@",response);
                                  if([response[@"code"]  isEqual: @1001]){
                                      [SCUserDefaults setObject:response[@"dictionary"][@"identity"] forKey:@USERAREA];
                                  }
                                  
                              } fail:^(NSError *error) {
                                  
                              } showHUD:1] ;
    
    
    
}
-(void)changeAutographWith:(NSString *)Autograph{
    
    [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,CHANGESIGN]
                               params:@{@"token":[SCUserInfo getUserModel].token,
                                        @"autograph":Autograph,
                                        }
                      loadingImageArr:nil toShowView:nil
                              success:^(id response) {
                                  NSLog(@"%@",response);
                                  if([response[@"code"]  isEqual: @1001]){
                                      [SCUserDefaults setObject:response[@"dictionary"][@"autograph"] forKey:@USERNICKNAME];
                                  }
                                  
                              } fail:^(NSError *error) {
                                  
                              } showHUD:1] ;
}
//刷新表格数据方法
-(void)getUserInfo{
    

    
//    NSLog(@"%@==%@",self.model.headsmall,self.model.ba);
    [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,USERINFODISPLAY]
                               params:@{@"token":[SCUserInfo getUserModel].token,
                                        }
                      loadingImageArr:nil toShowView:nil
                              success:^(id response) {
                                  NSLog(@"%@",response);
                                  
                                  if([response[@"code"]  isEqual: @1001]){
//                                      NSString *cityId = response[@"dictionary"][@"cityId"];
//                                      NSString *username = response[@"dictionary"][@"userName"];
//                                      NSString *phone = response[@"dictionary"][@"phone"];
//                                      NSString *name = response[@"dictionary"][@"name"];
//                                      
//                                      NSString *headsmall = response[@"dictionary"][@"headUrl"];
//                                      NSString *qr_code = response[@"dictionary"][@"identity"];
//                                      NSString *code = response[@"dictionary"][@"code"]; //二维码
//                                      NSString *bgimage = response[@"dictionary"][@"backgUrl"];
//                                      
//                                      NSString *sex = response[@"dictionary"][@"sex"];
//                                      NSString *autograph = response[@"dictionary"][@"autograph"]; //签名
//
                                     
                        
//                                      SCUserInfo * model = [SCUserInfo new];
//                                      model.area =  checkIsNULL(response[@"dictionary"][@"cityId"]);
//                                      model.nickname =checkIsNULL(response[@"dictionary"][@"userName"]) ;
//                                      model.name = checkIsNULL(response[@"dictionary"][@"name"]);
//                                      model.phone = checkIsNULL(response[@"dictionary"][@"phone"]);
//                                      model.headsmall = checkIsNULL(response[@"dictionary"][@"headUrl"]);
//                                      mode.code = checkIsNULL(response[@"dictionary"][@"code"]);
//                                      mode.signature = checkIsNULL(response[@"dictionary"][@"autograph"]);
//                                      mode.sex = checkIsNULL(response[@"dictionary"][@"sex"]);
//                                      mode.qr_code = checkIsNULL(response[@"dictionary"][@"identity"]);
//                                      mode.bgimage = checkIsNULL(response[@"dictionary"][@"backgUrl"]);
                              
                                      
//                                      NSLog(@"%@==%@==%@==%@",checkIsNULL(response[@"dictionary"][@"code"]),checkIsNULL(response[@"dictionary"][@"headUrl"]),checkIsNULL(response[@"dictionary"
                                      SCUserInfo * modelx=[SCUserInfo mj_objectWithKeyValues:response[@"dictionary"]];
                                      [SCUserInfo setuserInfo:modelx];
                    
                                  }
                                  
                              } fail:^(NSError *error) {
                                  
                              } showHUD:1] ;
}
- (ZmjPickView *)zmjPickView {
    if (!_zmjPickView) {
        _zmjPickView = [[ZmjPickView alloc]init];
    }
    return _zmjPickView;
}


#pragma mark - getter / setter
- (UITableView *)tableView
{
    if (_tablev == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tablev = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStyleGrouped];
        _tablev.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        _tablev.delegate = self;
        _tablev.dataSource = self;
    }
    return _tablev;
}

- (UIImageView *)topView
{
    if (_topView == nil) {
        _topView = [[UIImageView alloc] init];
        [_topView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEHEADER,_model.background]] placeholderImage:[UIImage imageNamed:@"wbBG"]];
        NSLog(@"%@",_model.background);
        _topView.frame = CGRectMake(0, 0, kScreenW, IMAGE_HEIGHT);
        _topView.userInteractionEnabled = YES;

    }
    return _topView;
}

- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEHEADER,_model.headsmall]] placeholderImage:[UIImage imageNamed:@"image5"]];
        _iconView.bounds = CGRectMake(0, 0, 80, 80);
        _iconView.layer.cornerRadius = 40;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        NSLog(@"%@", _model.nickname);
        _nameLabel.text = _model.nickname;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:17];
    }
    return _nameLabel;
}

- (UILabel *)fansLabel
{
    if (_fansLabel == nil) {
        _fansLabel = [UILabel new];
        _fansLabel.backgroundColor = [UIColor clearColor];
        _fansLabel.textColor = [UIColor whiteColor];
        _fansLabel.text = [NSString stringWithFormat:@"%@  |  %@",[SCColorTypeTools getSexStringWith:_model.sex], [SCColorTypeTools  getAreaStringWith:_model.area ]];
        _fansLabel.textAlignment = NSTextAlignmentCenter;
        _fansLabel.font = [UIFont systemFontOfSize:14];
    }
    return _fansLabel;
}

- (UILabel *)detailsLabel
{
    if (_detailsLabel == nil) {
        _detailsLabel = [UILabel new];
        _detailsLabel.backgroundColor = [UIColor clearColor];
        _detailsLabel.textColor = [UIColor whiteColor];
        _detailsLabel.text = _model.signature;
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
        _detailsLabel.font = [UIFont systemFontOfSize:13];
        _detailsLabel.numberOfLines = 0;
    }
    return _detailsLabel;
}

@end
