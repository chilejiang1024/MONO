//
//  BaseView.h
//  ProjectA
//
//  Created by JiangChile on 16/2/25.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

@property (nonatomic, assign) BOOL showBackButton;

/** button click method */
- (void)clickBackButton:(UIButton *)sender;

@end
