//
//  CreatorDetailView.h
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"

@class CpModel;

@interface CreatorDetailView : BaseView

typedef void(^BackBlock)();
/** back block */
@property (nonatomic, copy) BackBlock backBlock;

/** goto web view */
typedef void(^GoToWebView)(NSString *);
@property (nonatomic, copy) GoToWebView goToWebView;

/** pop INFO view */
typedef void(^PopINFOViewBlock)(CpModel *);
@property (nonatomic, copy) PopINFOViewBlock popINFOVIewBlock;

- (void)setCpModel:(CpModel *)cpModel;

- (void)setArrayItems:(NSMutableArray *)arrayItems;

@end
