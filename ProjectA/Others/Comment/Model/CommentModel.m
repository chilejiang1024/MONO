//
//  CommentModel.m
//  ProjectA
//
//  Created by JiangChile on 16/3/10.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super initWithDic:dic]) {
        self.user = [[CommentUser alloc] initWithDic:dic[@"user"]];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"key"]) {
        _Id = value;
    }
}

+ (NSMutableArray *)getCommentModelArrayWithArray:(NSMutableArray *)array {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [result addObject:[[CommentModel alloc] initWithDic:dic]];
    }
    return result;
}

@end



@implementation CommentUser

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super initWithDic:dic]) {
        self.coordinate = [[CommentCoordinate alloc] initWithDic:dic[@"coordinate"]];
    }
    return self;
}

@end


@implementation CommentCoordinate

@end


