//
//  UserView.h
//  ProjectA
//
//  Created by JiangChile on 16/3/7.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"

@class SpecialUpdateModel, UserFavListModel;

@interface UserView : BaseView

typedef void(^RefreshDataBlock)();
/** RefreshDataBlock */
@property (nonatomic, copy) RefreshDataBlock refreshDataBlock;

typedef void(^GoToWebViewBlock)(NSString *);
/** GoToWebViewBlock(NSString) */
@property (nonatomic, copy) GoToWebViewBlock goToWebViewBlock;

typedef void(^GoToUserSettingViewBlock)();
/** GoToUserSettingViewBlock */
@property (nonatomic, copy) GoToUserSettingViewBlock goToUserSettingViewBlock;


- (void)setSpecialUpdateModel:(SpecialUpdateModel *)specialUpdateModel;

- (void)setFavListModel:(UserFavListModel *)favListModel;

@end
