//
//  SignInView.h
//  ProjectA
//
//  Created by JiangChile on 16/3/5.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"

@interface SignInView : BaseView

typedef void(^SignInBlock)();
/** Sign in block */
@property (nonatomic, copy) SignInBlock signInBlock;


@end
