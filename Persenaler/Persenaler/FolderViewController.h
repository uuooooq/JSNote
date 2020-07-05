//
//  FolderViewController.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/27.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FolderViewController : BaseListViewController

@property(nonatomic,strong) DbKeyValue *fromKeyValue;
@property(nonatomic,strong) DbKeyValue *moveKeyValue;

@end

NS_ASSUME_NONNULL_END
