//
//  UserView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/7.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialUpdateModel.h"
#import "UserFavListModel.h"

#import "UserView.h"

#import "FavContentTableViewCell.h"

#import "UIButton+WebCache.h"
#import "MJRefresh.h"


@interface UserView () <UITableViewDataSource, UITableViewDelegate>

/** user */
@property (nonatomic, retain) NSUserDefaults *user;

/** special update model */
@property (nonatomic, retain) SpecialUpdateModel *specialUpdateModel;

/** fav list */
@property (nonatomic, retain) UserFavListModel *favListModel;

/** table view */
@property (nonatomic, retain) UITableView *tableView;

@end


@implementation UserView

#pragma mark - init & getter & setter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (NSUserDefaults *)user {
    if (!_user) {
        _user = [NSUserDefaults standardUserDefaults];
    }
    return _user;
}

- (void)setSpecialUpdateModel:(SpecialUpdateModel *)specialUpdateModel {
    _specialUpdateModel = specialUpdateModel;
}

- (void)setFavListModel:(UserFavListModel *)favListModel {
    _favListModel = favListModel;
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - create view

- (void)createView {
    [self createTableView];
}

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableHeaderView = [self createTableHeaderView];
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.refreshDataBlock();
    }];
    [tableView registerClass:[FavContentTableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    self.tableView = tableView;
    [self addSubview:self.tableView];
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favListModel.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", [self.favListModel.items[indexPath.row] item_url]);
    self.goToWebViewBlock([self.favListModel.items[indexPath.row] item_url]);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 50)];
    NSString *str = [NSString stringWithFormat:@"我订阅的%ld个专题", self.specialUpdateModel.user_subscribe_num];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName : MONO_COLOR_CYAN} range:NSMakeRange(4, 1)];
    [label setAttributedText:attStr];
    label.font = [UIFont systemFontOfSize:20.f];
    [view addSubview:label];
    
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    cell.model = self.favListModel.items[indexPath.row];
    return cell;
}

- (UIView *)createTableHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:headerView.frame];
    bgImageView.image = [UIImage imageNamed:@"bg.png"];
    [headerView addSubview:bgImageView];
    
    UIButton *buttonAvatar = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonAvatar.frame = CGRectMake(WIDTH / 2 - 40, 50, 80, 80);
    buttonAvatar.layer.cornerRadius = 40;
    buttonAvatar.clipsToBounds = YES;
    [buttonAvatar sd_setBackgroundImageWithURL:[NSURL URLWithString:[self.user objectForKey:@"avatar_url"]] forState:UIControlStateNormal];
    [headerView addSubview:buttonAvatar];
    
    UIButton *buttonSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSetting.frame = CGRectMake(WIDTH - 80, 70, 40, 40);
    buttonSetting.backgroundColor = [UIColor blackColor];
    buttonSetting.layer.cornerRadius = 20.f;
    buttonSetting.alpha = 0.2;
    [buttonSetting addTarget:self action:@selector(clickButtonSetting:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:buttonSetting];
    
    UIButton *buttonSettingTop = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSettingTop.frame = CGRectMake(0, 0, 20, 20);
    buttonSettingTop.center = buttonSetting.center;
    [buttonSettingTop setImage:[UIImage imageNamed:@"icon-setting.png"] forState:UIControlStateNormal];
    [buttonSettingTop addTarget:self action:@selector(clickButtonSetting:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:buttonSettingTop];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 40, 140, 80, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [self.user objectForKey:@"username"];
    [headerView addSubview:label];
    
    return headerView;
}

#pragma mark - button selector

- (void)clickButtonSetting:(UIButton *)sender {
    NSLog(@"go to user setting view.");
    self.goToUserSettingViewBlock();
}


@end
