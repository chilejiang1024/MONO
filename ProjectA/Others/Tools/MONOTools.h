//
//  MONOTools.h
//  ProjectA
//
//  Created by JiangChile on 16/3/9.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MONOTools : NSObject

+ (instancetype)shareTools;

- (void)shareToOtherPlatformWithURL:(NSString *)url;

- (void)likeThisArticleWithURL:(NSString *)url;

- (void)unlikeThisArticleWithURL:(NSString *)url;

@end
