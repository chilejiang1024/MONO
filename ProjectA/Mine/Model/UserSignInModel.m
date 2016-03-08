//
//  UserSignInModel.m
//  ProjectA
//
//  Created by JiangChile on 16/3/5.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "UserSignInModel.h"

@implementation UserSignInModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super initWithDic:dic]) {
        self.coordinate = [[Coordinate alloc] initWithDic:dic[@"coordinate"]];
    }
    return self;
}

@end


@implementation Coordinate

@end


