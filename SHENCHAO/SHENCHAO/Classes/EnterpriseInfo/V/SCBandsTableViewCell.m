//
//  SCBandsTableViewCell.m
//  汽车配件
//
//  Created by cb on 2017/4/27.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCBandsTableViewCell.h"
@interface SCBandsTableViewCell ()

@property(nonatomic,strong)UIImageView *label;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UILabel *huiLvLab;

@end
@implementation SCBandsTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle=UITableViewCellSelectionStyleGray;
    return self;
}

-(void)setModel:(BandsModel *)model{
    _model = model;
    
    //图标
    [self.contentView addSubview:self.label];
    //主标题
    [self.contentView addSubview:self.messageLabel];
    //    [self.contentView addSubview:self.huiLvLab];
    
    //判断状态设置label.text的颜色
    if (_model.isSelsect) {
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
    _messageLabel.frame=CGRectMake(10, 10, kScreenW-100, 30);
    //    _huiLvLab.frame=CGRectMake(100, 30, 200, 30);
    _label.frame=CGRectMake(kScreenW-50,  (self.frame.size.height-cellHeight)*0.5, cellWidth, cellHeight);
    
    
    [super layoutSubviews];
}

-(UILabel *)messageLabel{
    
    if (_messageLabel==nil) {
        
        _messageLabel=[[UILabel alloc]init];
        _messageLabel.font=[UIFont systemFontOfSize:16];
        _messageLabel.frame=CGRectMake(10, 10, kScreenW-200, 30);
        _messageLabel.textColor = SCGrayColor;
    }
    
    return _messageLabel;
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
@end
