//
//  RecModel.m
//  ProjectA
//
//  Created by JiangChile on 16/2/24.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "RecModel.h"

@implementation RecModel

+ (NSArray *)getRecModelArrayWithDic:(NSDictionary *)dic {
    RecModel *model = [[RecModel alloc] initWithDic:dic];
    model.waterfall = [[WaterfallModel getWaterfallArrayWithArray:dic[@"waterfall"]] mutableCopy];
    model.next = [[NextModel alloc] initWithDic:dic[@"next"]];
    NSArray *array = @[model];
    return array;
}

@end
