//
//  RecModel.h
//  ProjectA
//
//  Created by JiangChile on 16/2/24.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseModel.h"
#import "WaterfallModel.h"
#import "NextModel.h"

@interface RecModel : BaseModel

@property (nonatomic, retain) NSMutableArray *waterfall;

@property (nonatomic, retain) NextModel *next;

+ (NSArray *)getRecModelArrayWithDic:(NSDictionary *)dic;

@end
