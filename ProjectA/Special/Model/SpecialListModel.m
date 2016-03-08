//
//  SpecialTopModel.m
//  ProjectA
//
//  Created by JiangChile on 16/2/29.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialListModel.h"

@implementation SpecialListModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        self.logo_url = [[Special_Logo_Url alloc] initWithDic:dic[@"logo_url"]];
        self.thumb = [[Special_Thumb alloc] initWithDic:dic[@"thumb"]];
        self.content = [[Special_Content alloc] initWithDic:dic[@"content"]];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = [value integerValue];
    }
}

+ (NSMutableArray *)getSpecialListModelArrayWithArray:(NSArray *)array {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        SpecialListModel *model = [[SpecialListModel alloc] initWithDic:dic];
        [result addObject:model];
    }
    return result;
}

@end



@implementation Special_Logo_Url

@end



@implementation Special_Thumb

@end



@implementation Special_Content

@end


