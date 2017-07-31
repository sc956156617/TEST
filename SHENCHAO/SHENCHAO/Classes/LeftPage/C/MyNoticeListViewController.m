//
//  MyNoticeListViewController.m
//  SHENCHAO
//
//  Created by cb on 2017/6/26.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "MyNoticeListViewController.h"
#import "MainTableViewCellX.h"
#import "MainModel.h"
#import "SDAutoLayout.h"

@interface MyNoticeListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSArray *_timeArr;
    NSArray *_contentArr;
    NSArray *_titleArr;
    NSArray *_picArr;
}

@end

@implementation MyNoticeListViewController





#pragma mark - TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"mainCell";
    MainTableViewCellX *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MainTableViewCellX alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = _dataArr[indexPath.row];
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height=[_tableView cellHeightForIndexPath:indexPath model:_dataArr[indexPath.row] keyPath:@"model" cellClass:[MainTableViewCellX class] contentViewWidth:kScreenW];
    
    return height;
}


- (CGFloat)cellContentViewWith{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    //    // 适配ios7横屏
    //    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] == 10) {
    //        width = [UIScreen mainScreen].bounds.size.height;
    //    }
    return width;
}
-(void)createTableView{
    
    _timeArr = @[ @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",
                  @"10-21 12:00",];
    
    _titleArr = @[ @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",
                   @"清凉一夏 套餐半价",];
    _contentArr = @[@"什么叫见过大世面？——会讲究",
                    @"感情上没有绝对的公平，友情亲情爱情都是这样的，你特别爱一个人，那个人却没有回报你同等的感情，也有人很爱你，但是你也回报不了同等的感情，这都很正常。感情不像白菜，可以称斤两。",
                    @"以为说放下就能放下吗，那种从疯狂想念到坦然释怀的感觉，一定是要经过时间慢慢沉淀的，毕竟那个人陪着你走了那么久，也没有人可以替你感同身受。",
                    @"要经常这样告诉自己：不要轻易暴露内心的脆弱，学会承受应该担当的一切。不要轻易述说生活的狼狈，学会面对杂乱无序的现实。不要轻易虚度每一天的光阴，因为那都是你余生中的第一天。不要轻易向世界妥协，它让你哭，你要在坚持中让自己笑。只要我们能承担，不逃避，会珍惜，心坚强，人生就不会太苍白。",
                    @"任何一个人离开你都并非突然作的决定 人心是慢慢变冷 树叶是渐渐变黄 故事是缓缓写到结局 而爱 是因为失望太多 才变成不爱 ​​​​ ",
                    @"已经过了喜欢炫耀和喧闹的年龄了，遇到喜欢的事情就努力的去做，不再期待周围人的回应和鼓励，也不再在乎他人的褒贬和说辞。不会因为兴奋而四处叫嚣了，也不会因为低沉而祈求他人的理解和宽慰了。好的，坏的都学会了不去渲染，不去吆喝。懂得了要用诙谐的方式，过正经的人生。",
                    @"删去成行的字，最后打了个＂嗯＂发给你。没关系，不是所有的情绪都要告诉你。比如我的不开心，比如我好想念你。",
                    @"我和我的猫都很想你 哈哈哈骗你的啦 其实我没有猫 也没有你。",
                    @"其实谁都不想发脾气，赌气不过是为了看看对方会为自己退让多少空间。我们都有这样一个习惯，闹矛盾时喜欢说话带刺，喜欢不理不睬。懂得你的人会为你放下架子，不懂你的人，维持了僵局，失望的只有你自己。 ​​​​ ",
                    @"很心酸吧，那么喜欢的人却无法拥有 。",
                    @"人生就是一列开往坟墓的列车，路途上会有很多站，很难有人可以自始至终陪着走完。当陪你的人要下车时，即使不舍也该心存感激，然后挥手道别。—— 宫崎骏 ​​​​ ",
                    @"愿所有不畏寂寞的等待都不会被辜负。",
                    @"不懂时，别乱说。懂得时，别多说。心乱时，慢慢说。没话时，就别说。 ",
                    @"不喜欢的东西就扔掉，讨厌的人就拉黑，不开心的时候就睡一觉，看腻了的照片就删掉，遇见喜欢的人就表白，饿了就去吃最喜欢吃的美食，人生那么短暂哪有时间让你去犹豫 ",
                    @"别把无聊当孤独，别把矫情当文艺，别把倔犟当坚强。",
                    @"请不要让自己活得像个小丑，以最终是一场笑话的代价，去讨好不在乎自己的人。 ​​​​ ",
                    @"受不了被喜欢的人冷落时，就用作来引起注意，一副“你再不对我好点，咱俩就完了”的态度，用一段关系的存活去威胁对方。你以为对方会高能预警，然后小心呵护，结果只有不耐烦和厌恶。不喜欢你的人，作死了也没用，你要死了对方只希望你死远点！再说你那么作，你咋不上天呢！  ",
                    @"不能总是流血就喊痛，怕黑就开灯，想念就联系，疲惫就放空，被孤立就讨好，脆弱就想家，不要被现在而蒙蔽双眼，终究是要长大，最漆黑的那段路终要自己走完。。。"];
    
    
    
    _picArr = @[@"",
                @"pic2.jpeg",
                @"pic3.jpeg",
                @"",
                @"pic5.jpeg",
                @"pic6.jpeg",
                @"",
                @"pic8.jpeg",
                @"pic9.jpeg",
                @"",
                @"pic​​11.jpeg",
                @"pic12.jpeg",
                @"",
                @"pic14.jpeg",
                @"pic15.jpeg",
                @"pic16.jpeg",
                @"pic17.jpeg",
                @"pic18.jpeg"];
    
    
    _dataArr = [NSMutableArray array];
    for (int i = 0; i < _titleArr.count; i++) {
        
        MainModel *model = [MainModel new];
        model.time = _timeArr[i];
        model.title = _titleArr[i];
        model.content = _contentArr[i];
        model.image = _picArr[i];
        
        [_dataArr addObject:model];
    }
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH  - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"通知中心";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu"] highImage:[UIImage imageNamed:@"menu"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self createTableView];
    
}

- (void)back
{
    [self dismissViewControllerAnimated:1 completion:nil];
}

@end
