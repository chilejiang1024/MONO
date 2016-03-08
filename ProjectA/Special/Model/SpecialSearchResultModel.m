//
//  SpecialSearchResultModel.m
//  ProjectA
//
//  Created by JiangChile on 16/3/3.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialSearchResultModel.h"

@implementation SpecialSearchResultModel




+ (SpecialSearchResultModel *)getModelWithDic:(NSDictionary *)dic {
    SpecialSearchResultModel *model = [[SpecialSearchResultModel alloc] init];
    model.item = [NSMutableArray array];
    for (NSDictionary *dic2 in dic[@"item"]) {
        ItemModel *item = [[ItemModel alloc] initWithDic:dic2];
        [model.item addObject:item];
    }
    model.special = [SpecialListModel getSpecialListModelArrayWithArray:dic[@"special"]];
    return model;
}

@end
