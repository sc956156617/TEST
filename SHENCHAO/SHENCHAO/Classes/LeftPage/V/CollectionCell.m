//
//  CollectionCell.m
//  SHENCHAO
//
//  Created by cb on 2017/6/29.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "CollectionCell.h"


#define kRotationRadian  90.0/360.0
#define kVelocity        100

@interface CollectionCell()

@property(assign, nonatomic) CGPoint currentPoint;
@property(assign, nonatomic) CGPoint previousPoint;
@property(strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property(assign, nonatomic) float offsetRate;

@end

@implementation CollectionCell{

    UILabel *_company;
    UILabel *_brand;
    UIButton *_talk;
}
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)updateWithApp:(CollectionModel *)app {
    self.Model = app;
    _company.str(app.company);
    _brand.str(app.brands);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (void)setupUI {
    _company = Label.fnt(@17).color(@"darkGray").xywh(0,10,300,20).fitSize;
    //Setting preferWidth here will improve performance.
    _brand = Label.fnt(@15).lines(2).preferWidth(Screen.width - 205);
    _talk = Button.fnt(@15).str(@"与他交谈").h(20).color(@"#0065F7").border(1, @"#0065F7").borderRadius(3).onClick(@"click:");
    //.gap() will add spacing between all items.
    //下，右。 NERSpring = 10
    VerStack(_company, _brand, _talk).gap(10).embedIn(self.contentView,10, 10, 0, 0);
}
-(void)click:(UIButton *)btn{
   self.IMclick(self.Model.IM);
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    [self addPanGestureRecognizer];

    return self;
}
#pragma mark 滑动删除

-(void)addPanGestureRecognizer{
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideToDeleteCell:)];
    _panGestureRecognizer.delegate = self;
    [self addGestureRecognizer:_panGestureRecognizer];
    
}
#pragma mark UIGestureRecognizerDelegate------------------------------------------------
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint velocityPoint = [gestureRecognizer velocityInView:self];
        if (fabs(velocityPoint.x) > kVelocity) {
            return YES;
        }else
            return NO;
    }else
        return NO;
    
}

-(void)slideToDeleteCell:(UIPanGestureRecognizer *)panGestureRecognizer{
    
    _previousPoint = [panGestureRecognizer locationInView:self.superview];
    
    static CGPoint originalCenter;
    UIGestureRecognizerState state = panGestureRecognizer.state;
    if (state == UIGestureRecognizerStateBegan) {
        
        originalCenter = self.center;
        [self.superview bringSubviewToFront:self];
    }else if (state == UIGestureRecognizerStateChanged){
        CGPoint diff = CGPointMake(_previousPoint.x - _currentPoint.x, _previousPoint.y - _currentPoint.y);
        [self handleOffset:diff];
    }else if (state == UIGestureRecognizerStateEnded){
        if (_offsetRate < 0.5) {
            [UIView animateWithDuration:0.2 animations:^{
                
                self.transform = CGAffineTransformIdentity;
                self.center = originalCenter;
                self.alpha = 1.0;
                
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                self.center = CGPointMake(self.center.x * 2, self.center.y);
                self.alpha = 0.0;
                
            } completion:^(BOOL finsh){
                if ([delegate respondsToSelector:@selector(slideToDeleteCell:)]) {
                    [delegate slideToDeleteCell:self];
                }
                
                
            }];
        }
    }
    _currentPoint = _previousPoint;
    
}

-(void)handleOffset:(CGPoint)offset{
    
    self.center = CGPointMake(self.center.x + offset.x, self.center.y);
    float distance = self.frame.size.width/2 - self.center.x;
    float distanceAbs = fabsf(distance);
    float distanceRate = (self.frame.size.width - distanceAbs) / self.frame.size.width;
    self.alpha = distanceRate;
    
    _offsetRate = 1 -distanceRate;
    
    if (distance >= 0) {
        self.transform = CGAffineTransformMakeRotation(-_offsetRate * kRotationRadian);
    }else
        self.transform = CGAffineTransformMakeRotation(_offsetRate * kRotationRadian);
    
}

@end
