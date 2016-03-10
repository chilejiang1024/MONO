//
//  MONOTools.m
//  ProjectA
//
//  Created by JiangChile on 16/3/9.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "MONOTools.h"

@interface MONOTools ()

@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;

@end

@implementation MONOTools

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (!_instance) {
        @synchronized(self) {
            if (!_instance) {
                _instance = [super allocWithZone:zone];
            }
        }
    }
    return _instance;
}

+ (instancetype)shareTools {
    if (_instance == nil) {
        @synchronized(self) {
            if (_instance == nil) {
                _instance = [[super alloc] init];
            }
        }
    }
    return _instance;
}

- (AFHTTPRequestOperationManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
        [_manager.requestSerializer setValue:@"d93c6170bcd711e4a1cd5254000ccdad" forHTTPHeaderField:@"HTTP-AUTHORIZATION"];
        [_manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"Content-Length"];
        [_manager.requestSerializer setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
        [_manager.requestSerializer setValue:@"$Version=1" forHTTPHeaderField:@"Cookie2"];
        [_manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        [_manager.requestSerializer setValue:@"mmmono.com" forHTTPHeaderField:@"HOST"];
        [_manager.requestSerializer setValue:@"api-client/2.0.0 com.mmmono.mono/2.0.6 Android/4.4.2 IUNI U810" forHTTPHeaderField:@"MONO-USER-AGENT"];
    }
    return _manager;
}


- (void)likeThisArticleWithURL:(NSString *)url {
    NSLog(@"post fav to %@", url);
    [self.manager POST:url parameters:nil success:^void(AFHTTPRequestOperation * operation, id object) {
        NSLog(@"%@", object);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

- (void)unlikeThisArticleWithURL:(NSString *)url {
    NSLog(@"delete fav to %@", url);
    [self.manager DELETE:url parameters:nil success:^void(AFHTTPRequestOperation * operation, id object) {
        NSLog(@"%@", object);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

- (void)shareToOtherPlatformWithURL:(NSString *)url {
    
}



@end
