//
//  SpecialView.h
//  ProjectA
//
//  Created by JiangChile on 16/2/29.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"
#import "SpecialModel.h"



@interface SpecialView : BaseView


typedef void(^ShowSearchViewBlock)();
@property (nonatomic, copy) ShowSearchViewBlock showSearchViewBlock;

typedef void(^SearchBlock)(NSString *);
@property (nonatomic, copy) SearchBlock searchBlock;

typedef void(^GoToMoreViewBlock)(NSString *);
@property (nonatomic, copy) GoToMoreViewBlock goToMoreViewBlock;

typedef void(^GoToDetailViewBlock)(SpecialListModel *);
@property (nonatomic, copy) GoToDetailViewBlock goToDetailViewBlock;

/** 顶部search bar */
@property (nonatomic, retain) UISearchBar *searchBar;


- (void)setSpecialModel:(SpecialModel *)specialModel;



@end
