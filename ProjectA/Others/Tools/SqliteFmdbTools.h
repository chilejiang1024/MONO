//
//  SqliteFmdbTools.h
//  ProjectA
//
//  Created by JiangChile on 16/3/11.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserSignInModel.h"


@interface SqliteFmdbTools : NSObject

+ (NSArray *)selectAllUsers;

+ (void)insertIntoTableUserWithUserModel:(UserSignInModel *)model;

@end
