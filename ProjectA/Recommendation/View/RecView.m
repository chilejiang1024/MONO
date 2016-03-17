//
//  RecView.m
//  ProjectA
//
//  Created by JiangChile on 16/2/24.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "RecView.h"

#import "RecModel.h"

#import "RecTextTableViewCell.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"


@interface RecView () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

/** waterfall 数组 */
@property (nonatomic, retain) NSMutableArray *arrayRecModels;

/** 首部轮播图3张 */
@property (nonatomic, retain) NSMutableArray *arrayImages;

/** 轮播图的图片数组 */
@property (nonatomic, retain) NSMutableArray *arrayImage;

/** 轮播图下背景和页码 */
@property (nonatomic, retain) UILabel *labelPage;
@property (nonatomic, retain) UILabel *labelPageText;

/** time label */
@property (nonatomic, retain) UILabel *labelTime;

/** 往期 */
@property (nonatomic, retain) UIButton *buttonPast;

/** scroll view */
@property (nonatomic, retain) UIScrollView *tableHeader;

/** timer */
@property (nonatomic, retain) NSTimer *timer;


@end

@implementation RecView

- (UILabel *)labelPage {
    if (!_labelPage) {
        _labelPage = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 75, 250, 30, 30)];
        _labelPage.backgroundColor = MONO_COLOR;
        _labelPage.layer.cornerRadius = 5;
        _labelPage.clipsToBounds = YES;
        _labelPage.transform = CGAffineTransformMakeRotation(M_PI_4);
        _labelPageText = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 75, 250, 30, 30)];
        _labelPageText.textAlignment = NSTextAlignmentCenter;
        _labelPageText.text = @"1/3";
    }
    return _labelPage;
}

- (UILabel *)labelTime {
    if (!_labelTime) {
        _labelTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        _labelTime.backgroundColor = [UIColor blackColor];
        _labelTime.textColor = [UIColor whiteColor];
        _labelTime.text = [[self.arrayRecModels.firstObject next] w_datetime];
        _labelTime.textAlignment = NSTextAlignmentCenter;
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

- (NSMutableArray *)arrayImage {
    if (!_arrayImage) {
        _arrayImage = [NSMutableArray array];
    }
    return _arrayImage;
}

- (void)dealloc {
    self.timer = nil;
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

#pragma mark - 创建 table view
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
    
    self.tableHeader = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 300)];
    self.tableHeader.pagingEnabled = YES;
    self.tableHeader.backgroundColor = [UIColor blackColor];
    self.tableHeader.contentSize = CGSizeMake(WIDTH * 3, 300);
    self.tableHeader.delegate = self;
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, 300)];
        WaterfallModel *model = self.arrayImages[i];
        imageView.alpha = 0.8;
        imageView.tag = 10000 + i;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.item.share_image]];
        
        [self.tableHeader addSubview:imageView];
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.item.share_image]]];
        [self.arrayImage addObject:image];
        
    }
    // 设置初始值
    self.tableHeader.contentOffset = CGPointMake(WIDTH, 0);
    
    // add tap gesture recognizer to header view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickScrollView:)];
    [self.tableHeader addGestureRecognizer:tap];
    
    self.tableView.tableHeaderView = self.tableHeader;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.refreshBlcok(1);
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.refreshBlcok(self.arrayRecModels.count + 1);
    }];
    
    [self.tableView addSubview:self.labelPage];
    [self.tableView addSubview:self.labelPageText];
    [self addSubview:self.tableView];
    
    [self createTimer];
    
}

#pragma mark - 重写 scroll view 协议方法
// scroll view
// ---------------------------------------------

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![scrollView isEqual:self.tableView]) {
        if (scrollView.contentOffset.x == WIDTH) {
            return;
        }
        static NSUInteger indexMidImage = 0;
        // 计算中间显示图片的index
        indexMidImage += (scrollView.contentOffset.x / WIDTH > 1) ? 1 : -1;
        
        if (indexMidImage == -1) {
            indexMidImage = self.arrayImage.count - 1;
        } else if (indexMidImage == self.arrayImage.count) {
            indexMidImage = 0;
        }
        self.labelPageText.text = [NSString stringWithFormat:@"%ld/3", indexMidImage + 1];
        
        // 改变imageview 的image
        UIImageView *imageView = scrollView.subviews[1];
        imageView.image = self.arrayImage[indexMidImage];
        
        // 恢复至原始content off set
        scrollView.contentOffset = CGPointMake(WIDTH, 0);
        
        if (indexMidImage == 0) {
            imageView = scrollView.subviews[0];
            imageView.image = self.arrayImage.lastObject;
            imageView = scrollView.subviews[2];
            imageView.image = self.arrayImage.firstObject;
        } else if (indexMidImage == self.arrayImage.count - 1) {
            imageView = scrollView.subviews[0];
            imageView.image = self.arrayImage.firstObject;
            imageView = scrollView.subviews[2];
            imageView.image = self.arrayImage.lastObject;
        } else {
            imageView = scrollView.subviews[0];
            imageView.image = self.arrayImage[indexMidImage - 1];
            imageView = scrollView.subviews[2];
            imageView.image = self.arrayImage[indexMidImage + 1];
        }
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (![scrollView isEqual:self.tableView]) {
        // scroll view
        CGFloat angle = M_PI * scrollView.contentOffset.x / WIDTH + M_PI_4;
        self.labelPage.transform = CGAffineTransformMakeRotation(angle);
    } else {
        // 依据tableview滑动偏移量y，计算顶部labelTime的alpha
        CGFloat y = scrollView.contentOffset.y;
        self.labelTime.alpha = y / 300 / 2 > 0.75 ? 0.75 : y / 300 / 2;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.tableHeader]) {
        [self.timer invalidate];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    });
}

#pragma mark - table view 协议方法
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
    // 自适应 高度 -----
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
    if (indexPath.section + 1 == self.arrayRecModels.count) {
        _labelTime.text = [[self.arrayRecModels[indexPath.section] next] w_datetime];
    }
    RecTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.waterfallModel = [self.arrayRecModels[indexPath.section] waterfall][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WaterfallModel *model = [self.arrayRecModels[indexPath.section] waterfall][indexPath.row];
    NSString *url = model.item.item_url;
    NSLog(@"%@", url);
    self.clickBlock(url);
}

#pragma mark - selector
// ---------------------------------------------

- (void)clickButtonPast:(UIButton *)sender {
    self.goToTeaVCBlock();
}

- (void)clickScrollView:(UITapGestureRecognizer *)tap {
    NSInteger page = [self.labelPageText.text substringToIndex:1].integerValue;
    WaterfallModel *model = self.arrayImages[page - 1];
    self.clickBlock(model.item.item_url);
}

#pragma mark - auto轮播图的实现
// ---------------------------------------------

- (void)createTimer {
    self.timer = [NSTimer timerWithTimeInterval:2.f target:self selector:@selector(timerSelector:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerSelector:(NSTimer *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        [self.tableHeader setContentOffset:CGPointMake(WIDTH * 2, 0)];
    }];
    
    static NSUInteger index = 0;
    // 计算中间显示图片的index
    // index += 1;
    index = [self.labelPageText.text integerValue];
    
    if (index == self.arrayImage.count) {
        index = 0;
    }
    
    self.labelPageText.text = [NSString stringWithFormat:@"%ld/3", index + 1];
    
    // 改变imageview 的image
    UIImageView *imageView = self.tableHeader.subviews[1];
    imageView.image = self.arrayImage[index];
    
    // 恢复至原始content off set
    self.tableHeader.contentOffset = CGPointMake(WIDTH, 0);
    
    imageView = self.tableHeader.subviews[0];
    imageView.image = self.arrayImage.firstObject;
    imageView = self.tableHeader.subviews[2];
    imageView.image = self.arrayImage.lastObject;
}





@end
