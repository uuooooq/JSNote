//
//  ImageRecordCell.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/4/20.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbKeyValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageRecordCell : UICollectionViewCell

-(void)updateRecord:(DbKeyValue*)value;
@property(nonatomic,strong) UIButton * commBtn;

@end

NS_ASSUME_NONNULL_END
