//
//  ItemDetailViewController.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/18.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "BaseListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemDetailViewController : BaseListViewController

@property(nonatomic,strong) DbKeyValue *fromKeyValue;

@end

NS_ASSUME_NONNULL_END
