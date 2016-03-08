//
//  SignInViewController.h
//  ProjectA
//
//  Created by JiangChile on 16/3/5.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseViewController.h"

@interface SignInViewController : BaseViewController

typedef void(^SignInSuccessBlock)();
/** SignInSuccessBlock */
@property (nonatomic, copy) SignInSuccessBlock signInSuccessBlock;

@end
