//
//  SpecialSearchView.h
//  ProjectA
//
//  Created by JiangChile on 16/2/29.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"

@interface SpecialSearchView : BaseView

typedef void(^ShowResultWebViewBlock)(NSString *);
/** ShowResultWebViewBlock */
@property (nonatomic, copy) ShowResultWebViewBlock showResultWebViewBlock;

- (void)setArraySearchResult:(NSMutableArray *)arraySearchResult;

@end
