//
//  SpecialDetailView.h
//  ProjectA
//
//  Created by JiangChile on 16/3/3.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"
#import "SpecialListModel.h"
#import "SpecialDetailModel.h"

@interface SpecialDetailView : BaseView

typedef void(^ClickContentCellBlock)(NSString *);
/** ClickContentCellBlock */
@property (nonatomic, copy) ClickContentCellBlock clickContentCellBlock;

typedef void(^ClickCPCellBlock)(CpModel *);
/** ClickCPCellBlock */
@property (nonatomic, copy) ClickCPCellBlock clickCPCellBlock;

typedef void(^ClickSubscriberCellBlock)();
/** ClickSubscriberCellBlock */
@property (nonatomic, copy) ClickSubscriberCellBlock clickSubscriberCellBlock;

typedef void(^BackBlock)();
/** BackBlock */
@property (nonatomic, copy) BackBlock backBlock;


@property (nonatomic, retain) SpecialListModel *specialModel;

@property (nonatomic, retain) SpecialDetailModel *detailModel;

- (void)setSpecialModel:(SpecialListModel *)specialModel;

- (void)setDetailModel:(SpecialDetailModel *)detailModel;


@end
