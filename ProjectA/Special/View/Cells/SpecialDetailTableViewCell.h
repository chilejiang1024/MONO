//
//  SpecialDetailTableViewCell.h
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SpecialDetailModel.h"

@interface SpecialDetailTableViewCell : BaseTableViewCell

@property (nonatomic, retain) CpModel *cpModel;

@property (nonatomic, retain) RecentSubscriberModel *recSubModel;

@end
