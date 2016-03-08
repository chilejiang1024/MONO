//
//  WaterfallModel.m
//  ProjectA
//
//  Created by JiangChile on 16/2/24.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "WaterfallModel.h"

@implementation WaterfallModel

+ (NSArray *)getWaterfallArrayWithArray:(NSArray *)array {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        WaterfallModel *model = [[WaterfallModel alloc] initWithDic:dic];
        model.item = [[ItemModel alloc] initWithDic:dic[@"item"]];
        [result addObject:model];
    }
    return result;
}

@end

@implementation ItemModel
    
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        self.thumb = [[ThumbModel alloc] initWithDic:dic[@"thumb"]];
        self.content = [[ContentModel alloc] initWithDic:dic[@"content"]];
        self.cp = [[CpModel alloc] initWithDic:dic[@"cp"]];
        self.special = [[WaterFallSpecialModel alloc] initWithDic:dic[@"special"]];
    }
    return self;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = [value integerValue];
    }
}

@end


@implementation ThumbModel

@end


@implementation ContentModel

@end


@implementation CpModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = [value integerValue];
    } else if ([key isEqualToString:@"description"]) {
        _Description = value;
    }
}

@end


@implementation WaterFallSpecialModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = [value integerValue];
    }
}

@end


