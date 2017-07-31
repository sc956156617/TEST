//
//  CZTableViewCell.h
//  题1
//
//  Created by iOS001 on 15/12/12.
//  Copyright © 2015年 iOS001. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void (^passBlack)(id name ,id sender);

@class FDCellModel;
@protocol passModelVewdeldegate <NSObject>
-(void)passModel:(FDCellModel *)model with:(id)sender;
@end

@interface FDTableViewCell : UITableViewCell

@property(nonatomic,assign) BOOL  isHiddenMark;

@property(nonatomic,assign) passBlack  block;

@property(nonatomic,weak) id<passModelVewdeldegate>  deldegate;
//模型属性
@property (nonatomic,strong) FDCellModel *model;
@property (nonatomic,strong) NSString *biLv;

@end
