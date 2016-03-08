//
//  SpecialCategoryListModel.m
//  ProjectA
//
//  Created by JiangChile on 16/2/29.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialCategoryListModel.h"
#import "SpecialListModel.h"

@implementation SpecialCategoryListModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        self.specialList = [SpecialListModel getSpecialListModelArrayWithArray:dic[@"special_list"]];
    }
    return self;
}

+ (NSMutableArray *)getSpecialCategoryListModelArrayWithArray:(NSArray *)array {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        SpecialCategoryListModel *model = [[SpecialCategoryListModel alloc] initWithDic:dic];
        [result addObject:model];
    }
    return  result;
}

@end
