//
//  UserSettingView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/8.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "UserSettingView.h"

#import "SettingTableViewCell.h"

#import "SpecialUpdateModel.h"

#import "UIImageView+WebCache.h"

@interface UserSettingView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) float height;

/** array menu */
@property (nonatomic, retain) NSMutableArray *arrayMenu;

/** array menu icon */
@property (nonatomic, retain) NSMutableArray *arrayMenuIcon;

@end


@implementation UserSettingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (NSMutableArray *)arrayMenu {
    if (!_arrayMenu) {
        _arrayMenu = [@[@"每日提醒", @"省流量模式", @"使用系统字体", @"阅读历史", @"MONO动画", @"清除缓存", @"和我们聊聊", @"退出登录"] mutableCopy];
    }
    return _arrayMenu;
}

- (NSMutableArray *)arrayMenuIcon {
    if (!_arrayMenuIcon) {
        _arrayMenuIcon = [@[@"icon-bell.png", @"icon-wutu.png", @"icon-ziti.png", @"icon-lishi.png", @"icon-juhua.png", @"icon-qingchu.png", @"icon-liaoliao.png", @"icon-tanhao.png"] mutableCopy];
    }
    return _arrayMenuIcon;
}


#pragma mark - create view & table view

- (void)createView {
    UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.8f;
    [self addSubview:bgView];
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 100, HEIGHT - 200)];
    mainView.center = self.center;
    mainView.backgroundColor = MONO_COLOR_DARK;
    [self addSubview:mainView];
    
    CGRect frame = mainView.frame;
    self.height = frame.size.height;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(WIDTH / 2 - 10, HEIGHT - 80, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"icon-x.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    
    
    [self createTableView];
    
    
    
}


- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 100, HEIGHT - 200) style:UITableViewStyleGrouped];
    tableView.center = self.center;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    [self addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.height / 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.height / 9;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 100, self.height / 9)];
    topView.backgroundColor = MONO_COLOR_DEEPDARK;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    UIImageView *imageViewAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 32, 32)];
    imageViewAvatar.layer.cornerRadius = 16;
    imageViewAvatar.clipsToBounds = YES;
    [imageViewAvatar sd_setImageWithURL:[NSURL URLWithString:[user objectForKey:@"avatar_url"]]];
    [topView addSubview:imageViewAvatar];
    
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(65, 12, 200, 30)];
    labelName.text = [user objectForKey:@"username"];
    labelName.textColor = [UIColor whiteColor];
    [topView addSubview:labelName];
    
    return topView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.labelMenuText.text = self.arrayMenu[indexPath.row];
    cell.imageViewMenu.image = [UIImage imageNamed:self.arrayMenuIcon[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", self.arrayMenu[indexPath.row]);
}

#pragma mark - button selector

- (void)back:(UIButton *)sender {
    self.backBlock();
}


@end
