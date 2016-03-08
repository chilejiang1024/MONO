//
//  SignInWithQQView.h
//  ProjectA
//
//  Created by JiangChile on 16/3/7.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"

@interface SignInWithQQView : BaseView

typedef void(^SignInBlock)();
/** SignInBlock */
@property (nonatomic, copy) SignInBlock signInBlock;

@property (nonatomic, retain) UIActivityIndicatorView *indicatorView;


@end
