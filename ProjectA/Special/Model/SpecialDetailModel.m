//
//  SpecialDetailModel.m
//  ProjectA
//
//  Created by JiangChile on 16/3/3.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialDetailModel.h"

@implementation SpecialDetailModel


- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super initWithDic:dic]) {
        self.item_list = [NSMutableArray array];
        self.cp_list = [NSMutableArray array];
        
        for (NSDictionary *dicTemp in dic[@"item_list"]) {
            [self.item_list addObject:[[ItemModel alloc] initWithDic:dicTemp]];
        }
        
        self.recent_subscribers = [RecentSubscriberModel getRecSubModelArrayWithArray:dic[@"recent_subscribers"]];
        
        for (NSDictionary *dicTemp in dic[@"cp_list"]) {
            [self.cp_list addObject:[[CpModel alloc] initWithDic:dicTemp]];
        }
    }
    return self;
}

+ (SpecialDetailModel *)getSpecialDetailModelWithDic:(NSDictionary *)dic {
    return [[SpecialDetailModel alloc] initWithDic:dic];
}

@end

@implementation RecentSubscriberModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super initWithDic:dic]) {
        self.coordinate = [[CoordinateModel alloc] initWithDic:dic[@"coordinate"]];
    }
    return self;
}

+ (NSMutableArray *)getRecSubModelArrayWithArray:(NSArray *)array {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [result addObject:[[RecentSubscriberModel alloc] initWithDic:dic]];
    }
    return result;
}

@end


@implementation CoordinateModel



@end