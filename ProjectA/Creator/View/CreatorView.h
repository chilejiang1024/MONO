//
//  CreatorView.h
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"

@class CpModel;

@interface CreatorView : BaseView

typedef void(^GoToDetailVC)(CpModel *);

/** <#comment#> */
@property (nonatomic, copy) GoToDetailVC goToDetailVC;

- (void)setArrayCPModel:(NSMutableArray *)arrayCPModel;

@end
