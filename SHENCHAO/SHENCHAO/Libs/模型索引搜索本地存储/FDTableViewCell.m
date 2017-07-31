//
//  CZTableViewCell.m
//  题1
//
//  Created by iOS001 on 15/12/12.
//  Copyright © 2015年 iOS001. All rights reserved.
//

#import "FDTableViewCell.h"
#import "FDCellModel.h"

@interface FDTableViewCell ()

@property(nonatomic,strong)UIImageView *label;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UIButton *tishiLab;

@end

@implementation FDTableViewCell

-(UILabel *)messageLabel{
    
    if (_messageLabel==nil) {
        
        _messageLabel=[[UILabel alloc]init];
        _messageLabel.font=[UIFont systemFontOfSize:16];
        _messageLabel.frame=CGRectMake(10, 10, kScreenW-200, 30);
        _messageLabel.textColor = SCGrayColor;
    }
    
    return _messageLabel;
}

-(UIButton *)tishiLab{
    
    if (_tishiLab==nil) {
        _tishiLab=[[UIButton alloc]init];
        _tishiLab.frame=CGRectMake(100, 30, 200, 30);
        [_tishiLab setImage:[UIImage imageNamed:@"tishii"] forState:UIControlStateNormal];
        [_tishiLab addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
//        if (self.isHiddenMark==YES ) {
            _tishiLab.hidden = YES;
//        }
    }
    return _tishiLab;
}

-(void)btnclick:(id )sender{

//    self.block(self.model, sender);
    if ([self.deldegate respondsToSelector:@selector(passModel:with:)]) {
        [self.deldegate  passModel:self.model with:sender];
    }
}
-(UIImageView *)label{
    
    if (_label==nil) {
        
        _label=[[UIImageView alloc]init];
        CGFloat cellWidth=30;
        CGFloat cellHeight=30;
        _label.frame=CGRectMake(kScreenW-80,  (self.frame.size.height-cellHeight)*0.5, cellWidth, cellHeight);
        _label.layer.cornerRadius=5;
        _label.layer.masksToBounds=YES;

    }
    return _label;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    self.selectionStyle=UITableViewCellSelectionStyleGray;
    
    return self;
}

-(void)setModel:(FDCellModel *)model{
    _model = model;
    //图标
    [self.contentView addSubview:self.label];
    //主标题
    [self.contentView addSubview:self.messageLabel];
    
    [self.contentView addSubview:self.tishiLab];
    
    //判断状态设置label.text的颜色
    if (_model.isClick) {
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.label.image=[UIImage imageNamed:@"anniu_xuanzhong"];
    }else{
        self.textLabel.textColor = [UIColor blackColor];
        self.label.image=[UIImage imageNamed:@"anniu_weixuanzhong"];
    }
    self.messageLabel.text=_model.name;
}

-(void)layoutSubviews{
    CGFloat cellWidth=20;
    CGFloat cellHeight=20;
    _messageLabel.frame=CGRectMake(50, 10, kScreenW-100, 30);
//    _huiLvLab.frame=CGRectMake(100, 30, 200, 30);
    _label.frame=CGRectMake(10,  (self.frame.size.height-cellHeight)*0.5, cellWidth, cellHeight);
    
    _tishiLab.frame =CGRectMake(kScreenW-50,  (self.frame.size.height-cellHeight)*0.5, cellWidth, cellHeight);
    [super layoutSubviews];
}
@end
