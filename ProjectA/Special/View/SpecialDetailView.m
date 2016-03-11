//
//  SpecialDetailView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/3.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

/**
 * 本.m文件需要重构
 * 反正我是不写了
 * 真TMD服了
 * 写代码之前不画功能模块图???
 * ╮(╯▽╰)╭  怪我喽~
 */

#import "SpecialDetailView.h"
#import "UIImageView+WebCache.h"
#import "RecTextTableViewCell.h"
#import "SpecialDetailTableViewCell.h"

@interface SpecialDetailView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UIImageView *imageViewThumb;

@property (nonatomic, retain) UIImageView *imageViewLogo;

@property (nonatomic, retain) UILabel *labelTitle;

@property (nonatomic, retain) UILabel *labelDesc;

@property (nonatomic, retain) UIButton *buttonSubscribe;

// 真TMD服了
@property (nonatomic, retain) UIButton *button1;

// 真TMD服了
@property (nonatomic, retain) UIButton *button2;

// 真TMD服了
@property (nonatomic, retain) UIButton *button3;

@property (nonatomic, retain) UITableView *tableView;

// 1 2 3
@property (nonatomic, assign) NSInteger showFlag;

@end

typedef enum : NSUInteger {
    ShowContent,
    ShowCP,
    ShowSubscribe,
} ButtonShowFlag;

@implementation SpecialDetailView

#pragma mark - init & setter & getter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (NSInteger)showFlag {
    if (!_showFlag) {
        _showFlag = ShowContent;
    }
    return _showFlag;
}

- (void)setSpecialModel:(SpecialListModel *)specialModel {
    _specialModel = specialModel;
    [self.tableView reloadData];

}

- (void)setDetailModel:(SpecialDetailModel *)detailModel {
    _detailModel = detailModel;
    [self.tableView reloadData];
    
}

#pragma mark - create view

- (void)createView {
    [self createTableView];
    self.showBackButton = YES;
}


#pragma mark - button selectors

- (void)clickButton1:(UIButton *)sender {
    if (self.showFlag != ShowContent) {
        self.showFlag = ShowContent;
        [self.tableView reloadData];
    }
}

- (void)clickButton2:(UIButton *)sender {
    if (self.showFlag != ShowCP) {
        self.showFlag = ShowCP;
        [self.tableView reloadData];
    }
}

- (void)clickButton3:(UIButton *)sender {
    if (self.showFlag != ShowSubscribe) {
        self.showFlag = ShowSubscribe;
        [self.tableView reloadData];
    }
}

- (void)clickBackButton:(UIButton *)sender {
    self.backBlock();
}

#pragma mark - table view

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[RecTextTableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    [self.tableView registerClass:[SpecialDetailTableViewCell class] forCellReuseIdentifier:@"tableViewCell_1"];
    [self addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 360;
}

- (UIView *)createHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 360)];
    headerView.backgroundColor = [UIColor blackColor];
    
    self.imageViewThumb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 300)];
    self.imageViewThumb.alpha = ALPHA;
    [headerView addSubview:self.imageViewThumb];
    
    self.imageViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH / 2 - 50, 40, 100, 100)];
    [headerView addSubview:self.imageViewLogo];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, WIDTH - 40, 50)];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.font = [UIFont systemFontOfSize:20.f];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:self.labelTitle];
    
    self.labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, WIDTH - 40, 60)];
    self.labelDesc.textColor = [UIColor whiteColor];
    self.labelDesc.textAlignment = NSTextAlignmentCenter;
    self.labelDesc.numberOfLines = 0;
    self.labelDesc.font = [UIFont systemFontOfSize:15.f];
    [headerView addSubview:self.labelDesc];
    
    self.buttonSubscribe = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonSubscribe.frame = CGRectMake(WIDTH / 2 - 60, 250, 120, 30);
    self.buttonSubscribe.backgroundColor = [UIColor yellowColor];
    [self.buttonSubscribe setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.buttonSubscribe.layer.cornerRadius = 15;
    [self.buttonSubscribe setTitle:@"订阅" forState:UIControlStateNormal];
    
    [headerView addSubview:self.buttonSubscribe];
    
    // 300 height
    self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button1.frame = CGRectMake(WIDTH / 3 * 0, 300, WIDTH / 3, 60);
    [self.button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // reloaddata 重新生成headerview 所以⬇️
    self.button1.selected = self.showFlag == ShowContent;
    [self.button1 setBackgroundImage:[UIImage imageNamed:@"back-button-normal.jpg"] forState:UIControlStateNormal];
    [self.button1 setBackgroundImage:[UIImage imageNamed:@"back-button-selected.jpg"] forState:UIControlStateSelected];
    [self.button1 addTarget:self action:@selector(clickButton1:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.button1];
    
    self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button2.frame = CGRectMake(WIDTH / 3 * 1, 300, WIDTH / 3, 60);
    [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button2.selected = self.showFlag == ShowCP;
    [self.button2 setBackgroundImage:[UIImage imageNamed:@"back-button-normal.jpg"] forState:UIControlStateNormal];
    [self.button2 setBackgroundImage:[UIImage imageNamed:@"back-button-selected.jpg"] forState:UIControlStateSelected];
    [self.button2 addTarget:self action:@selector(clickButton2:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.button2];
    
    self.button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button3.frame = CGRectMake(WIDTH / 3 * 2, 300, WIDTH / 3, 60);
    [self.button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button3.selected = self.showFlag == ShowSubscribe;
    [self.button3 setBackgroundImage:[UIImage imageNamed:@"back-button-normal.jpg"] forState:UIControlStateNormal];
    [self.button3 setBackgroundImage:[UIImage imageNamed:@"back-button-selected.jpg"] forState:UIControlStateSelected];
    [self.button3 addTarget:self action:@selector(clickButton3:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.button3];
    
    [self.button1 setTitle:[NSString stringWithFormat:@"%ld篇内容", _specialModel.content_num] forState:UIControlStateNormal];
    [self.button2 setTitle:[NSString stringWithFormat:@"%ld造物主", _detailModel.cp_list.count] forState:UIControlStateNormal];
    [self.button3 setTitle:[NSString stringWithFormat:@"%ld订阅", _specialModel.subscriber_num] forState:UIControlStateNormal];
    
    [self.imageViewThumb sd_setImageWithURL:[NSURL URLWithString:_specialModel.thumb.raw]];
    [self.imageViewLogo sd_setImageWithURL:[NSURL URLWithString:_specialModel.logo_url.raw]];
    self.labelDesc.text = _specialModel.content.desc;
    self.labelTitle.text = _specialModel.title;
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createHeaderView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.showFlag == ShowContent) {
        CGFloat height = 0;
        WaterfallModel *waterfallModel = [[WaterfallModel alloc] init];
        waterfallModel.item = self.detailModel.item_list[indexPath.row];
        CGFloat h = 15 * waterfallModel.item.content.desc.length / 22;
        height = 40 + waterfallModel.item.thumb.height / (waterfallModel.item.thumb.width / (WIDTH - 20)) + 30 + (h < 50 ? h : 50) + 30 + 50;
        return height;
    } else if (self.showFlag == ShowCP) {
        return 100;
    } else {
        return 100;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.showFlag == ShowContent) {
        return self.detailModel.item_list.count;
    } else if (self.showFlag == ShowCP) {
        return self.detailModel.cp_list.count;
    } else {
        return self.detailModel.recent_subscribers.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.showFlag == ShowContent) {
        RecTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
        WaterfallModel *model = [[WaterfallModel alloc] init];
        model.item = self.detailModel.item_list[indexPath.row];
        cell.waterfallModel = model;
        return cell;
    } else if (self.showFlag == ShowCP) {
        SpecialDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell_1"];
        cell.cpModel = self.detailModel.cp_list[indexPath.row];
        return cell;
    } else {
        SpecialDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell_1"];
        cell.recSubModel = self.detailModel.recent_subscribers[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.showFlag == ShowContent) {
        NSLog(@"special detail : click content cell.");
        self.clickContentCellBlock([self.detailModel.item_list[indexPath.row] item_url]);
    } else if (self.showFlag == ShowCP) {
        NSLog(@"special detail : click cp cell.");
        self.clickCPCellBlock(self.detailModel.cp_list[indexPath.row]);
    } else {
        NSLog(@"special detail : click subscriber cell.");
        self.clickSubscriberCellBlock();
    }
}


@end
