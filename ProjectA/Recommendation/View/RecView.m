//
//  RecView.m
//  ProjectA
//
//  Created by JiangChile on 16/2/24.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "RecView.h"
#import "UIImageView+WebCache.h"
#import "RecModel.h"
#import "RecTextTableViewCell.h"
#import "MJRefresh.h"

@interface RecView () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

/** waterfall 数组 */
@property (nonatomic, retain) NSMutableArray *arrayRecModels;

/** 首部轮播图3张 */
@property (nonatomic, retain) NSMutableArray *arrayImages;

/** 轮播图下背景和页码 */
@property (nonatomic, retain) UILabel *labelPage;
@property (nonatomic, retain) UILabel *labelPageText;

/** time label */
@property (nonatomic, retain) UILabel *labelTime;

/** 往期 */
@property (nonatomic, retain) UIButton *buttonPast;

@end

@implementation RecView

- (UILabel *)labelPage {
    if (!_labelPage) {
        _labelPage = [[UILabel alloc] initWithFrame:CGRectMake(300, 250, 30, 30)];
        _labelPage.backgroundColor = MONO_COLOR;
        _labelPage.layer.cornerRadius = 5;
        _labelPage.clipsToBounds = YES;
        _labelPage.transform = CGAffineTransformMakeRotation(M_PI_4);
        _labelPageText = [[UILabel alloc] initWithFrame:CGRectMake(300, 250, 30, 30)];
        _labelPageText.textAlignment = NSTextAlignmentCenter;
        _labelPageText.text = @"1/3";
    }
    return _labelPage;
}

- (UILabel *)labelTime {
    if (!_labelTime) {
        _labelTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        _labelTime.backgroundColor = [UIColor blackColor];
        _labelTime.alpha = 0.f;
    }
    return _labelTime;
}

- (UIButton *)buttonPast {
    if (!_buttonPast) {
        _buttonPast = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonPast.frame = CGRectMake(WIDTH - 60, 30, 40, 40);
        _buttonPast.layer.shadowOffset = CGSizeMake(0, 0);
        _buttonPast.layer.shadowColor = [UIColor whiteColor].CGColor;
        _buttonPast.layer.shadowOpacity = 1;
        [_buttonPast setImage:[UIImage imageNamed:@"icon-zhinanzhen.png"] forState:UIControlStateNormal];
        [_buttonPast addTarget:self action:@selector(clickButtonPast:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonPast;
}

- (instancetype)initWithFrame:(CGRect)frame Images:(NSMutableArray *)images Waterfalls:(NSMutableArray *)waterfalls{
    self = [super initWithFrame:frame];
    if (self) {
        self.arrayRecModels = waterfalls;
        self.arrayImages = images;
        [self createView];
    }
    return self;
}

// table view
// ---------------------------------------------

- (void)createView {
    [self createTableView];
    [self addSubview:self.labelTime];
    [self addSubview:self.buttonPast];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // 取消cell之间的线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[RecTextTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIScrollView *tableHeader = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 300)];
    tableHeader.pagingEnabled = YES;
    tableHeader.contentSize = CGSizeMake(WIDTH * 3, 300);
    tableHeader.delegate = self;
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, 300)];
        WaterfallModel *model = self.arrayImages[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.item.share_image]];
        [tableHeader addSubview:imageView];
    }
    self.tableView.tableHeaderView = tableHeader;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.refreshBlcok(1);
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.refreshBlcok(self.arrayRecModels.count + 1);
    }];
    
    [self.tableView addSubview:self.labelPage];
    [self.tableView addSubview:self.labelPageText];
    [self addSubview:self.tableView];
}

// scroll view
// ---------------------------------------------

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![scrollView isEqual:self.tableView]) {
        int page = scrollView.contentOffset.x / WIDTH + 1;
        self.labelPageText.text = [NSString stringWithFormat:@"%d/3", page];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isEqual:self.tableView]) {
        CGFloat angle = M_PI * scrollView.contentOffset.x / WIDTH + M_PI_4;
        self.labelPage.transform = CGAffineTransformMakeRotation(angle);
    } else {
        // 依据tableview滑动偏移量y，计算顶部labelTime的alpha
        CGFloat y = scrollView.contentOffset.y;
        self.labelTime.alpha = y / 300 / 2 > 0.75 ? 0.75 : y / 300 / 2;
    }
    
}

// table view 协议方法
// ---------------------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    WaterfallModel *model = [self.arrayRecModels[section] waterfall].firstObject;
    if ([model.item.cp.screen_name isEqualToString:@"MONO日签"]) {
        return 500;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 500)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    label.text = @"sign in today\n每日签到";
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:15.f];
    [view addSubview:label];
    
    UIImageView *imageHeader = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, WIDTH - 20, 400)];
    imageHeader.backgroundColor = [UIColor yellowColor];
    WaterfallModel *model = [self.arrayRecModels[section] waterfall].firstObject;
    [imageHeader sd_setImageWithURL:[NSURL URLWithString:model.item.thumb.raw]];
    [view addSubview:imageHeader];
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 450, WIDTH, 50)];
    UIButton *buttonShare = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonShare.frame = CGRectMake(20, 15, 20, 20);
    [buttonShare setImage:[UIImage imageNamed:@"icon-share.png"] forState:UIControlStateNormal];
    [buttonView addSubview:buttonShare];
    
    UIButton *buttonCollect = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCollect.frame = CGRectMake(70, 15, 20, 20);
    [buttonCollect setImage:[UIImage imageNamed:@"icon-collect.png"] forState:UIControlStateNormal];
    [buttonView addSubview:buttonCollect];
    
    UIButton *buttonComment = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonComment.frame = CGRectMake(120, 15, 20, 20);
    [buttonComment setImage:[UIImage imageNamed:@"icon-comment.png"] forState:UIControlStateNormal];
    [buttonView addSubview:buttonComment];
    
    [view addSubview:buttonView];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 自适应 我去 高度 ----- 
    CGFloat height = 0;
    WaterfallModel *waterfallModel = [self.arrayRecModels[indexPath.section] waterfall][indexPath.row];
    CGFloat h = 15 * waterfallModel.item.content.desc.length / 22;
    height = 40 + waterfallModel.item.thumb.height / (waterfallModel.item.thumb.width / (WIDTH - 20)) + 30 + (h < 50 ? h : 50) + 30 + 50;
    WaterfallModel *model = [self.arrayRecModels[indexPath.section] waterfall].firstObject;
    if ([model.item.cp.screen_name isEqualToString:@"MONO日签"] && indexPath.row == 0) {
        height = 0;
    }
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayRecModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.arrayRecModels[section] waterfall] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.waterfallModel = [self.arrayRecModels[indexPath.section] waterfall][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WaterfallModel *model = [self.arrayRecModels[indexPath.section] waterfall][indexPath.row];
    NSString *url = model.item.item_url;
    NSLog(@"%@", url);
    self.clickBlock(url);
}

// ---------------------------------------------

- (void)clickButtonPast:(UIButton *)sender {
    self.goToTeaVCBlock();
}


// ---------------------------------------------









@end
