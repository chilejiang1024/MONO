//
//  SignInMethodView.h
//  ProjectA
//
//  Created by JiangChile on 16/3/5.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"

@interface SignInMethodView : BaseView

typedef void(^BackBlock)();
/** Back block */
@property (nonatomic, copy) BackBlock backBlock;

typedef void(^GoToSignInVCBlock)();
/** GoToQQSignInBlock */
@property (nonatomic, copy) GoToSignInVCBlock goToSignInVCBlock;

@end
