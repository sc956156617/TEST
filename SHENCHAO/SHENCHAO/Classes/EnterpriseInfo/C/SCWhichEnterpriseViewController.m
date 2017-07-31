//
//  SCWhichEnterpriseViewController.m
//  汽车配件
//
//  Created by cb on 2017/3/29.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCWhichEnterpriseViewController.h"
#import "SCQiPeiViewController.h"
#import "SCQiXiuViewController.h"
//弹出视图
#import "XFDialogBuilder.h"

#import "SCWorkerListViewController.h"
#import "DWBubbleMenuButton.h"

#import "AppDelegate.h"
#import "LXAlertView.h"



@interface SCWhichEnterpriseViewController (){
    BOOL _isTip;

}
@property (nonatomic, weak) XFDialogFrame *dialogView;
@property(nonatomic,strong)UIButton * qipeishang;
@end

@implementation SCWhichEnterpriseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setNavigation];
    [self setUpchildViewes];
}

-(void)setNavigation{
    _isTip = YES;
//    self.navigationItem.leftBarButtonItem = [SCColorTypeTools itemWithImageName:@"chahao" highImageName:@"chahao"  addTarget:self action:@selector(editClick:) tintColor:nil];
     self.navigationItem.leftBarButtonItem = [SCColorTypeTools itemWithTitleName:@"返回" highTitleName:@"返回" addTarget:self action:@selector(editClick) tintColor:nil];
}
-(void)editClick{
    [self dismissViewControllerAnimated:1 completion:nil];
}
- (void)setUpchildViewes {
    UILabel *titleL=[[UILabel alloc]initWithFrame:CGRectMake(kScreenW/4, 64, 2000,50 )];
    titleL.text=@"完善下您的资料吧？";
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font=[UIFont boldSystemFontOfSize:AdapationLabelFont(20)];
    titleL.textColor  = SCThemeColor;
    [titleL sizeToFit];
    titleL.centerX = self.view.centerX;
    [self.view addSubview:titleL];
    
    
    //灰色字体
    UILabel *SubtitleL=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleL.frame)+25, 2000,50 )];
    SubtitleL.text=@"认证身份可以让更多人找到你，您的身份是";
    SubtitleL.textAlignment = NSTextAlignmentCenter;
    SubtitleL.font=[UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
    SubtitleL.textColor  = SCLightGrayColor;
    [SubtitleL sizeToFit];
    SubtitleL.centerX = self.view.centerX;
    [self.view addSubview:SubtitleL];
    self.view.backgroundColor =[UIColor whiteColor];
    
  
    
    
    CGFloat span = kScreenW * 170/1080;
    CGFloat iconW = (kScreenW -3*span)/2;
    
    //汽配商
    UIButton *logintouch=[UIButton buttonWithType:UIButtonTypeCustom];
    [logintouch setFrame:CGRectMake(0, kScreenH/2-100, iconW+30,iconW+30)];
    logintouch.centerX = span +iconW/2 ;
    logintouch.tag = 1000+1;
    [logintouch setImage:[UIImage imageNamed:@"qipeishang-wxz"] forState:UIControlStateNormal];
    [logintouch setImage:[UIImage imageNamed:@"qipeishang-xuanzhong"] forState:UIControlStateSelected];
    [logintouch addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    self.qipeishang = logintouch;
    [self.view addSubview:logintouch];

    
    //汽修商
    UIButton *logintouchX=[UIButton buttonWithType:UIButtonTypeCustom];
    [logintouchX setFrame:CGRectMake(0, kScreenH/2-100, iconW+30,iconW+30)];
    logintouchX.centerX = 2*span + iconW/2*3;
    [logintouchX setImage:[UIImage imageNamed:@"qixiushang-wxz"] forState:UIControlStateNormal];
    [logintouchX setImage:[UIImage imageNamed:@"qixiushang-xz"] forState:UIControlStateSelected];

    [logintouchX addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    logintouchX.tag =1000+2;

    [self.view addSubview:logintouchX];
    
    //上一步按钮
    UIButton *logintouchY=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logintouchY setTitle:@"上一步" forState:UIControlStateNormal];
    [logintouchY setTitleColor:SCThemeColor forState:UIControlStateNormal];
    logintouchY.titleLabel.font = [UIFont boldSystemFontOfSize:AdapationLabelFont(17)];
    [logintouchY setFrame:CGRectMake(0, kScreenH-85-64, 90, 35)];
    logintouchY.centerX = self.view.centerX;
    logintouchY.backgroundColor = [UIColor whiteColor];
    logintouchY.layer.masksToBounds = YES;
    logintouchY.layer.cornerRadius = 5;
    logintouchY.layer.borderColor = SCThemeColor.CGColor;
    logintouchY.layer.borderWidth = 1;
    logintouchY.hidden =!_canBack;
    [logintouchY addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logintouchY];
}
-(void)nextClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case 1001:
        {
            [[XFDialogOptionButton dialogWithTitle:@"选择经营方式"
                                             attrs:@{
                                                     XFDialogMaskViewBackgroundColor:[UIColor blackColor],
                                                     XFDialogMaskViewAlpha:@(0.2f),
                                                     XFDialogTitleViewBackgroundColor : SCThemeColor,
                                                     XFDialogTitleColor: [UIColor whiteColor],
                                                     XFDialogOptionTextList: @[@"品牌专营",@"品牌多营",@"配件经营",@"精品经营"]
                                                     }
                                    commitCallBack:^(NSString *inputText) {
                                        SCQiPeiViewController *vc =[SCQiPeiViewController new];
                                        if ([inputText isEqualToString:@"品牌专营"]) {
                                            vc.engageIn = EngageInOneBrand;
                                        }else if ([inputText isEqualToString:@"品牌多营"]){
                                            vc.engageIn = EngageInManyBrand;
                                        }else if ([inputText isEqualToString:@"配件经营"]) {
                                            vc.engageIn = EngageInPart;
                                        }else{
                                            vc.engageIn = EngageInQuality;
                                        }
                                        [self.navigationController pushViewController:vc animated:1];
                                    }] showWithAnimationBlock:nil];
            
            
    
//            
//            DWBubbleMenuButton *downMenuButton = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(100.f,
//                                                                                                      100.f,
//                                                                                                      self.qipeishang.width,
//                                                                                                      self.qipeishang.height)
//                                                                        expansionDirection:DirectionDown];
//            downMenuButton.homeButtonView = self.qipeishang;
//            
//            [downMenuButton addButtons:[self createDemoButtonArray]];
//            
//            [self.view addSubview:downMenuButton];
        }
            
            break;
        case 1002:
            [self.navigationController pushViewController:[SCQiXiuViewController new] animated:1];
            break;
        default:
            break;
    }

}

- (UILabel *)createHomeButtonView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 200.f)];
    
    label.text = @"Tap";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height / 2.f;
    label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    label.clipsToBounds = YES;
    
    return label;
}

- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (NSString *title in @[@"汽配精品", @"配件", @"多种品牌", @"单种品牌"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0.f, 0.f, 200.f, 200.f);
        button.layer.cornerRadius = button.frame.size.height / 2.f;
        button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        button.clipsToBounds = YES;
        button.tag = i++;
        
        [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}

- (void)test:(UIButton *)sender {
    NSLog(@"Button tapped, tag: %ld", (long)sender.tag);
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:1];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.qipeishang.hidden = NO;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (_isTip) {
        _isTip = NO;
        LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:@"请真实选择企业类型，一旦选择将无法更改。有任何问题，请联系我们的客服，我们将竭诚为您服务" cancelBtnTitle:nil otherBtnTitle:@"我已了解" clickIndexBlock:^(NSInteger clickIndex,NSString * textInput) {
            //        NSLog(@"点击index====%ld",clickIndex);
            switch (clickIndex) {
                case 0:
                    //                    [self  editClick];
                    break;
                    
                case 1:
                    //                    [self.navigationController pushViewController:[SCWorkerListViewController new] animated:1];
                    break;
                    
                default:
                    break;
            }
        }];
        alert.animationStyle=LXASAnimationTopShake;
        [alert showLXAlertView];
    }
    
    
    
    

}

@end
