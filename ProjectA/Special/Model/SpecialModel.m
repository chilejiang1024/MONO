//
//  SpicalModel.m
//  ProjectA
//
//  Created by JiangChile on 16/2/29.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialModel.h"

@implementation SpecialModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.tops = [SpecialListModel getSpecialListModelArrayWithArray:dic[@"tops"]];
        self.category_list = [SpecialCategoryListModel getSpecialCategoryListModelArrayWithArray:dic[@"category_list"]];
    }
    return self;
}


+ (SpecialModel *)getSpecialModelWithDic:(NSDictionary *)dic {
    return [[SpecialModel alloc] initWithDic:dic];
}


@end
