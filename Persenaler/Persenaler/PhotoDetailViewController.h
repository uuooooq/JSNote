//
//  PhotoDetailViewController.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/7/2.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbKeyValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoDetailViewController : UIViewController

@property(nonatomic,strong) DbKeyValue *imgKeyValue;

@end

NS_ASSUME_NONNULL_END
