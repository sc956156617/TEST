//
//  PooCodeView.h
//  Code
//
//  Created by crazypoo on 14-4-14.
//使用说明
//- (void)viewDidLoad {
//[super viewDidLoad];
//_pooCodeView = [[PooCodeView alloc] initWithFrame:CGRectMake(50, 100, 82, 32)];
//UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
//[_pooCodeView addGestureRecognizer:tap];
//[self.view addSubview:_pooCodeView];
//
//}

//-(void)tapClick:(UITapGestureRecognizer*)tap{
//    [_pooCodeView changeCode];
//    
//    NSLog(@"%@",_pooCodeView.changeString);
//}



#import <UIKit/UIKit.h>

@interface SCPooCodeView : UIView
@property (nonatomic, retain) NSArray *changeArray;
@property (nonatomic, retain) NSMutableString *changeString;
@property (nonatomic, retain) UILabel *codeLabel;

-(void)changeCode;
@end
