//
//  CreatorDetailViewController.h
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseViewController.h"
#import "WaterfallModel.h"

@interface CreatorDetailViewController : BaseViewController

/** cp Model */
@property (nonatomic, retain) CpModel *cpModel;


- (void)setCpModel:(CpModel *)cpModel;

@end
