//
//  BottomPoppingView.m
//  SnailPopupControllerDemo
//
//  Created by zhanghao on 2016/12/27.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "BottomPoppingView.h"
#import "UIColor+SCExtension.h"
#import "UIScreen+Extend.h"
#import "NSDate+SCExtension.h"
#import "BottomPoppingLabel.h"
#import "UIView+Extension.h"

@interface BottomPoppingView () <UIScrollViewDelegate> {
    CGFloat _gap, _space;
}
@property (nonatomic, strong) UILabel  *dateLabel;
@property (nonatomic, strong) UILabel  *weekLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *closeIcon;
@property (nonatomic, strong) UIScrollView *scrollContainer;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *pageViews;

@end

@implementation BottomPoppingView

- (instancetype)init {
    
//    self.backgroundColor = [UIColor lightTextColor];
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame withItemCount:(NSInteger)count{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor lightTextColor];

        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fullViewClicked:)]];
        
//        _dateLabel = [UILabel new];
//        _dateLabel.font = [UIFont fontWithName:@"Heiti SC" size:42];
//        _dateLabel.textColor = [UIColor r:21 g:21 b:21];
//        _dateLabel.textColor = [UIColor blackColor];
//        [self addSubview:_dateLabel];
        
//        _weekLabel = [UILabel new];
//        _weekLabel.numberOfLines = 0;
//        _weekLabel.font = [UIFont fontWithName:@"Heiti SC" size:12];
//        _weekLabel.textColor = [UIColor r:56 g:56 b:56];
//        [self addSubview:_weekLabel];
        
        
        //#define ROWS COUNT／ROW_COUNT > 4 ？ 4 : COUNT／ROW_COUNT     // 每页显示2行
        //#define PAGES   COUNT／ROW_COUNT > 4 ? 2 : 1 // 共2页
//        _COUNT = 10;
        
        
        NSLog(@"%ld===",count/16);
        _COUNT = count;
        NSLog(@"%d===%ld",4%16,_COUNT/(ROW_COUNT*4));

        _ROWS =  (count/ROW_COUNT >=4 ) ? 4 : (count/ROW_COUNT+1);
        _PAGES =  count/(ROW_COUNT*4) == 1 ? 1 : (count/(ROW_COUNT*4) > 1 ? 2 : 1);

        _closeButton = [UIButton new];
        _closeButton.backgroundColor = [UIColor whiteColor];
        _closeButton.userInteractionEnabled = NO;
        [_closeButton addTarget:self action:@selector(closeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeButton];
        
        _closeIcon = [UIButton new];
        _closeIcon.backgroundColor = [UIColor cyanColor];
        _closeIcon.userInteractionEnabled = NO;
        _closeIcon.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_closeIcon setImage:[UIImage imageNamed:@"sina_关闭"] forState:UIControlStateNormal];
        [self addSubview:_closeIcon];
        
        [self setContent];
        [self commonInitialization];
    }
    return self;
}

- (void)setContent {
    NSDate *date = [NSDate date];
    _dateLabel.text = [NSString stringWithFormat:@"%.2ld", (long)date.day];
    _dateLabel.size = [_dateLabel sizeThatFits:CGSizeMake(40, 40)];
    _dateLabel.origin = CGPointMake(15, 65);
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@", date.dayFromWeekday, [date stringWithFormat:@"MM/yyyy"]];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    [paragraphStyle setLineSpacing:5];
    _weekLabel.attributedText = string;
    _weekLabel.size = [_weekLabel sizeThatFits:CGSizeMake(100, 40)];
    _weekLabel.x = _dateLabel.maxX + 10;
    _weekLabel.centerY = _dateLabel.centerY;

    _closeButton.size = CGSizeMake([UIScreen width], 44);
    _closeButton.maxY = [UIScreen height]-30;
    _closeIcon.size = CGSizeMake(30, 30);
    _closeIcon.center = _closeButton.center;
}




//布局设置
- (void)commonInitialization {
    _scrollContainer = [UIScrollView new];
    _scrollContainer.bounces = NO;
    _scrollContainer.pagingEnabled = YES;
    _scrollContainer.showsHorizontalScrollIndicator = NO;
    _scrollContainer.delaysContentTouches = YES;
    _scrollContainer.delegate = self;
    [self addSubview:_scrollContainer];
    
    _itemSize = CGSizeMake(60, 40);
    _gap = 15;
    _space = ([UIScreen width] - ROW_COUNT * _itemSize.width) / (ROW_COUNT + 1);
    
    _scrollContainer.size = CGSizeMake([UIScreen width], _itemSize.height * _ROWS + _gap  + 150);
    _scrollContainer.maxY = [UIScreen height] - _closeButton.height;
    _scrollContainer.contentSize = CGSizeMake(_PAGES * [UIScreen width], _scrollContainer.height);
    
    _pageViews = @[].mutableCopy;
    for (NSInteger i = 0; i < _PAGES; i++) {
        UIImageView *pageView = [UIImageView new];
        pageView.size = _scrollContainer.size;
        pageView.x = i * [UIScreen width];
        pageView.userInteractionEnabled = YES;
        [_scrollContainer addSubview:pageView];
        [_pageViews addObject:pageView];
    }
}

- (void)setModels:(NSArray<LableModel *> *)models {
    _items = @[].mutableCopy;
    [_pageViews enumerateObjectsUsingBlock:^(UIImageView * _Nonnull imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        for (NSInteger i = 0; i < _ROWS * ROW_COUNT; i++) {
            NSInteger l = i % ROW_COUNT;
            NSInteger v = i / ROW_COUNT;
            
            BottomPoppingLabel *item = [BottomPoppingLabel new];
            [imageView addSubview:item];
            [_items addObject:item];
            item.tag = i + idx * (_ROWS *ROW_COUNT);
            if (item.tag < models.count) {
                [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)]];
                item.model = [models objectAtIndex:item.tag];
//                item.iconView.userInteractionEnabled = NO;
                item.textLabel.font = [UIFont systemFontOfSize:14];
                item.textLabel.textColor = UIColorRGB(82, 82, 82);
                [item updateLayoutBySize:_itemSize finished:^(BottomPoppingLabel *item) {
                    item.x = _space + (_itemSize.width  + _space) * l;
                    item.y = (_itemSize.height + _gap) * v + _gap + 100;
                }];
            }
        }
    }];
    [self startAnimationsCompletion:NULL];
}

- (void)fullViewClicked:(UITapGestureRecognizer *)recognizer {
    __weak typeof(self) _self = self;
    [self endAnimationsCompletion:^(BottomPoppingView *fullView) {
        if (nil != self.didClickFullView) {
            _self.didClickFullView((BottomPoppingView *)recognizer.view);
        }
    }];
}

- (void)itemClicked:(UITapGestureRecognizer *)recognizer  {
    if (_ROWS * ROW_COUNT - 1 == recognizer.view.tag) {
        [_scrollContainer setContentOffset:CGPointMake([UIScreen width], 0) animated:YES];
    } else {
        if (nil != self.didClickItems) {
            self.didClickItems(self, recognizer.view.tag);
        }
    }
}

- (void)closeClicked:(UIButton *)sender {
    [_scrollContainer setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x /[UIScreen width] + 0.5;
    _closeButton.userInteractionEnabled = index > 0;
    [_closeIcon setImage:[UIImage imageNamed:(index ? @"sina_返回" : @"sina_关闭")] forState:UIControlStateNormal];
}

- (void)startAnimationsCompletion:(void (^ __nullable)(BOOL finished))completion {
    
    [UIView animateWithDuration:0.5 animations:^{
        _closeIcon.transform = CGAffineTransformMakeRotation(M_PI_4);
    } completion:NULL];
    
    [_items enumerateObjectsUsingBlock:^(BottomPoppingLabel *item, NSUInteger idx, BOOL * _Nonnull stop) {
        item.alpha = 0;
        item.transform = CGAffineTransformMakeTranslation(0, _ROWS * _itemSize.height);
        [UIView animateWithDuration:0.85
                              delay:idx * 0.035
             usingSpringWithDamping:0.6
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             item.alpha = 1;
                             item.transform = CGAffineTransformIdentity;
                         } completion:completion];
    }];
}

- (void)endAnimationsCompletion:(void (^)(BottomPoppingView *))completion {
    if (!_closeButton.userInteractionEnabled) {
        [UIView animateWithDuration:0.35 animations:^{
            _closeIcon.transform = CGAffineTransformIdentity;
        } completion:NULL];
    }
    
    [_items enumerateObjectsUsingBlock:^(BottomPoppingLabel * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        [UIView animateWithDuration:0.35
                              delay:0.025 * (_items.count - idx)
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             item.alpha = 0;
                             item.transform = CGAffineTransformMakeTranslation(0, _ROWS * _itemSize.height);
                         } completion:^(BOOL finished) {
                             if (finished) {
                                 if (idx == _items.count - 1) {
                                     completion(self);
                                 }
                             }
                         }];
    }];
}

@end
