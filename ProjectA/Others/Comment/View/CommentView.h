//
//  CommentView.h
//  ProjectA
//
//  Created by JiangChile on 16/3/10.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

// 本view是为了comment专门jianli
// 只是在显示comment时才使用
// 因此创建在Base class 中


#import "BaseView.h"

@interface CommentView : BaseView

- (instancetype)initWithFrame:(CGRect)frame URL:(NSString *)url;

@end
