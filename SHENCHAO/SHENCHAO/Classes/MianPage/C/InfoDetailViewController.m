//
//  InfoDetailViewController.m
//  SHENCHAO
//
//  Created by cb on 2017/7/6.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "InfoDetailViewController.h"

@interface InfoDetailViewController ()

@end

@implementation InfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    id s1 = Style().fnt(AdapationLabelFont(15)).fixWH(kScreenW,40).borderRadius(5).border(1, @"lightGray").color(@"white").bgColor(@"black").centerAlignment;
//    
//    
//    id b1 = Button.str(@"收藏").styles(s1).onClick(^{
//    //点击操作
//    });
//    
//    id b2 = Button.str(@"电话咨询").styles(s1).onClick(^{
//        //点击操作
//    });
//    id b3 = Button.str(@"与他交谈").styles(s1).onClick(^{
//        //点击操作
//    });
//    id v1 = View.styles(s1).xywh(0,kScreenH-40,kScreenW,40).addTo(self.view);
//
//    View
//    HorStack( b1, b2, b3).gap(10).embedIn(self.view, 0, 0, 0);
//    VerStack( b1, b2, b3).gap(10).embedIn(self.view, 1000, 0, 20);   //zongxian
//    Button.styles(@[b1, b2,b3]).xywh(0,kScreenH-40,kScreenW,40).addTo(self.view);

    
    ImageView.img(@"1").bgColor(@"black").border(1, @"lightGray").borderRadius(5).embedIn(self.view,kScreenH-40-64,0,0,0);  //嵌入
    
//    id hello = Label.str(@"HELLO").fnt(@20).wh(80, 80).centerAlignment;
//    id mac = Label.str(@"MAC").fnt(@20).wh(80, 80).centerAlignment;
//    
//    //In order to use makeCons, the view must be in the view hierarchy.
//    EffectView.darkBlur.fixWH(80, 80).addTo(self.view).makeCons(^{
//        make.right.equal.superview.centerX.constants(0);
//        make.bottom.equal.superview.centerY.constants(0);
//    }).addVibrancyChild(hello).tg(101);
//    
//    EffectView.extraLightBlur.fixWidth(80).fixHeight(80).addTo(self.view).makeCons(^{
//        make.left.bottom.equal.view(self.view).center.constants(0, 0);
//    });
//    
//    EffectView.lightBlur.addTo(self.view).makeCons(^{
//        make.size.equal.constants(80, 80).And.center.equal.constants(40, 40);
//    }).addVibrancyChild(mac);
//    
//    id subImg = Img(@"macbook").subImg(95, 110, 80, 80).blur(10);
//    ImageView.img(subImg).addTo(self.view).makeCons(^{
//        make.centerX.top.equal.view([self.view viewWithTag:101]).centerX.bottom.constants(0);
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
