//
//  UserSettingView.h
//  ProjectA
//
//  Created by JiangChile on 16/3/8.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"

@interface UserSettingView : BaseView

typedef void(^BackBlock)();
/** BackBlock */
@property (nonatomic, copy) BackBlock backBlock;



@end
