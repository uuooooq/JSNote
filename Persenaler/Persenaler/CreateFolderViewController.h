//
//  CreateFolderViewController.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/7/2.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateFolderViewController : UIViewController
@property(nonatomic,strong) DataSource *dataSource;
@property(nonatomic,strong) DbKeyValue *fromKeyValue;

@end

NS_ASSUME_NONNULL_END
