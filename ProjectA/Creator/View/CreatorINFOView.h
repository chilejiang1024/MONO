//
//  CreatorINFOView.h
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"
#import "WaterfallModel.h"

@interface CreatorINFOView : BaseView

typedef void(^DisappearViewBlock)();
/** disappear view */
@property (nonatomic, copy) DisappearViewBlock disappearViewBlock;

- (instancetype)initWithFrame:(CGRect)frame CpModel:(CpModel *)model;


@end
