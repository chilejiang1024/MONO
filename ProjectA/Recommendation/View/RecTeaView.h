//
//  RecTeaView.h
//  ProjectA
//
//  Created by JiangChile on 16/3/5.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"

@interface RecTeaView : BaseView

typedef void(^DismissVCBlock)();
/** Dismiss VC block */
@property (nonatomic, copy) DismissVCBlock dismissVCBlock;

- (void)setArrayTeaModel:(NSMutableArray *)arrayTeaModel;

@end
