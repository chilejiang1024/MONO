//
//  SqliteFmdbTools.m
//  ProjectA
//
//  Created by JiangChile on 16/3/11.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SqliteFmdbTools.h"

#import "FMDB.h"

static FMDatabase *db;

@implementation SqliteFmdbTools

+ (void)initialize {
    NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    dbPath = [dbPath stringByAppendingPathComponent:@"user.sqlite"];
    NSLog(@"database path : %@", dbPath);
    db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSString *sql = @"CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY, username TEXT, userid TEXT, idolduser INTEGER, avatarurl TEXT, accesstoken TEXT, time TEXT);";
        if ([db executeUpdate:sql]) {
            NSLog(@"Create DB success.");
        }
    } else {
        NSLog(@"Create DB failure.");
    }
}

+ (NSArray *)selectAllUsers {
    NSMutableArray *users = [NSMutableArray array];
    FMResultSet *result = [db executeQuery:@"SELECT * FROM user"];
    while (result.next) {
        NSLog(@"username : %@, login time : %@.", [result stringForColumn:@"username"], [result stringForColumn:@"time"]);
    }
    return users;
}

+ (void)insertIntoTableUserWithUserModel:(UserSignInModel *)model {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [formatter stringFromDate:[NSDate date]];
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO user(username, userid, idolduser, avatarurl, accesstoken, time) VALUES('%@', '%@', '%d', '%@', '%@', '%@')", model.name, model.user_id, model.id_old_user, model.avatar_url, model.access_token, time];
    [db executeUpdate:insertSql];
}



@end
