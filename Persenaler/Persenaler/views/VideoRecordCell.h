//
//  VideoRecordCell.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/3.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbKeyValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoRecordCell : UICollectionViewCell

-(void)updateRecord:(DbKeyValue*)value;
@property(nonatomic,strong) UIButton * commBtn;
@property(nonatomic,strong) UIButton * fullsizeBtn;

@end

NS_ASSUME_NONNULL_END
