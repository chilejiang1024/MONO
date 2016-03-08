//
//  RecView.h
//  ProjectA
//
//  Created by JiangChile on 16/2/24.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface RecView : BaseView

/** 刷新block */
typedef void (^RefreshBlcok)(NSUInteger);
@property (nonatomic, copy) RefreshBlcok refreshBlcok;

/** 点击跳转block */
typedef void (^ClickBlock)(NSString *);
@property (nonatomic, copy) ClickBlock clickBlock;

typedef void(^GoToTeaVCBlock)();
/** go to tea view */
@property (nonatomic, copy) GoToTeaVCBlock goToTeaVCBlock;

/** table view */
@property (nonatomic, retain) UITableView *tableView;

- (instancetype)initWithFrame:(CGRect)frame Images:(NSMutableArray *)images Waterfalls:(NSMutableArray *)waterfalls;

@end
