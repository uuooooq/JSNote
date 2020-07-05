//
//  FolderRecordCell.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/22.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDWUtility.h"
#import "DbKeyValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface FolderRecordCell : UICollectionViewCell

-(void)updateRecord:(DbKeyValue*)value;

@end

NS_ASSUME_NONNULL_END
