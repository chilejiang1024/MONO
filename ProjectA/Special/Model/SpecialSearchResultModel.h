//
//  SpecialSearchResultModel.h
//  ProjectA
//
//  Created by JiangChile on 16/3/3.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseModel.h"
#import "WaterfallModel.h"
#import "SpecialListModel.h"

@interface SpecialSearchResultModel : BaseModel

@property (nonatomic, retain) NSMutableArray *item;

@property (nonatomic, retain) NSMutableArray *special;

+ (SpecialSearchResultModel *)getModelWithDic:(NSDictionary *)dic;

@end
