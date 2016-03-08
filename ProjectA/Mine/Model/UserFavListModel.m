//
//  UserFavListModel.m
//  ProjectA
//
//  Created by JiangChile on 16/3/7.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "UserFavListModel.h"

@implementation UserFavListModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super initWithDic:dic]) {
        self.items = [Items getItemsArrayWithArray:dic[@"items"]];
    }
    return self;
}

@end


@implementation Items

+ (NSMutableArray *)getItemsArrayWithArray:(NSMutableArray *)array {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        Items *item = [[Items alloc] initWithDic:dic];
        item.image_gallery = [[Image_Gallery alloc] initWithDic:dic[@"image_gallery"]];
        item.text = [[Text alloc] initWithDic:dic[@"text"]];
        item.user = [[User alloc] initWithDic:dic[@"user"]];
        item.image = [[Image alloc] initWithDic:dic[@"image"]];
        [result addObject:item];
        
    }
    return result;
}

@end


@implementation User



@end


@implementation Image_Gallery


@end


@implementation Images

@end


@implementation Image

@end


@implementation Text

@end


