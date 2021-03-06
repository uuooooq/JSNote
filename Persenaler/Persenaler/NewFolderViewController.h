//
//  NewFolderViewController.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/22.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewFolderViewController : UIViewController

@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) DataSource *dataSource;
@property(nonatomic,strong) DbKeyValue *fromKeyValue;
//@property(nonatomic,assign) BOOL isSubItem;

@end

NS_ASSUME_NONNULL_END
