
//
//  OneBandsTableViewCell.m
//  汽车配件
//
//  Created by cb on 2017/5/5.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "OneBandsTableViewCell.h"
@interface OneBandsTableViewCell(){

    BandsModel *mode1;
    BandsModel *mode2;
    BandsModel *mode3;
    BandsModel *mode4;

}
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@property (nonatomic,strong) UIButton *btn3;
@property (nonatomic,strong) UIButton *btn4;

@end
@implementation OneBandsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle=UITableViewCellSelectionStyleGray;
    self.layer.masksToBounds =YES;
    self.clipsToBounds =YES;
    [self  addSubview:self.messageLabel];
    [self addSubview:self.btn1];
    [self addSubview:self.btn2];
    [self addSubview:self.btn3];
    [self addSubview:self.btn4];
    return self;
}


-(void)setModel:(BandsFrameModel *)modelX{
    
    _model = modelX;

     self.messageLabel.text= modelX.mainModel.name;
    //展开视图
    for (int i=0; i<4; i++) {

        if (i<modelX.childModels.count) {
           
            switch (i) {
                case 0:{
                    mode1 =modelX.childModels[0];
                    [_btn1  setTitle:mode1.name forState:UIControlStateNormal];
                }
                    break;
                case 1:{
                    mode2 =modelX.childModels[1];
                    [_btn2  setTitle:mode2.name forState:UIControlStateNormal];
                }
                    break;
                case 2:{
                    mode3 =modelX.childModels[2];
                    [_btn3  setTitle:mode3.name forState:UIControlStateNormal];
                }
                    break;
                case 3:{
                    mode4 =modelX.childModels[3];
                    [_btn4  setTitle:mode4.name forState:UIControlStateNormal];
                }
                    break;
                    
                default:
                    break;
            }
        }
}
  
    
    [_btn1 addTarget:self action:@selector(btnClivk:) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btnClivk:) forControlEvents:UIControlEventTouchUpInside];
    [_btn3 addTarget:self action:@selector(btnClivk:) forControlEvents:UIControlEventTouchUpInside];
    [_btn4 addTarget:self action:@selector(btnClivk:) forControlEvents:UIControlEventTouchUpInside];

    
}
-(void)btnClivk:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(OneBandsClick:)]) {
        if (btn == _btn1) {
            [self.delegate  OneBandsClick: [NSString stringWithFormat:@"%@",mode1.ID]];
        }else if (btn == _btn2){
            [self.delegate  OneBandsClick: [NSString stringWithFormat:@"%@",mode2.ID]];
        }else if (btn == _btn3){
            [self.delegate  OneBandsClick: [NSString stringWithFormat:@"%@",mode3.ID]];
        }else{
            [self.delegate  OneBandsClick: [NSString stringWithFormat:@"%@",mode4.ID]];
        }
    }
}
-(UIButton *)btn1{
    if (!_btn1) {
       _btn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 30*1, kScreenW, 30)];
        _btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn1 setTitleColor:SCLightGrayColor forState:UIControlStateNormal];
        _btn1.centerX = self.centerX;
    }
    return _btn1;
}
-(UIButton *)btn2{
    if (!_btn2) {
        _btn2=[[UIButton alloc]initWithFrame:CGRectMake(0, 30*2, kScreenW, 30)];
        _btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn2 setTitleColor:SCLightGrayColor forState:UIControlStateNormal];
        _btn2.centerX = self.centerX;

    }
    return _btn2;
}
-(UIButton *)btn3{
    if (!_btn3) {
        _btn3=[[UIButton alloc]initWithFrame:CGRectMake(0, 30*3, kScreenW, 30)];
        _btn3.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn3 setTitleColor:SCLightGrayColor forState:UIControlStateNormal];
        _btn3.centerX = self.centerX;

    }
    return _btn3;
}
-(UIButton *)btn4{
    if (!_btn4) {
        _btn4=[[UIButton alloc]initWithFrame:CGRectMake(0, 30*4, kScreenW, 30)];
        _btn4.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btn4.centerX = self.centerX;
        [_btn4 setTitleColor:SCLightGrayColor forState:UIControlStateNormal];
    }
    return _btn4;
}
-(UILabel *)messageLabel{
    
    if (_messageLabel==nil) {
        _messageLabel=[[UILabel alloc]init];
        _messageLabel.font=[UIFont systemFontOfSize:16];
        _messageLabel.frame=CGRectMake(10, 0, 200, 30);
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.textColor = SCGrayColor;
    }
    
    return _messageLabel;
}
@end
