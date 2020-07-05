//
//  AudioDetailCell.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/7.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbKeyValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioDetailCell : UICollectionViewCell

@property(nonatomic,strong)UILabel *titleLbl;
@property(nonatomic,strong)UIButton * playBtn;
@property(nonatomic,strong)UIProgressView *progress;


-(void)updateRecord:(DbKeyValue*)value;


@end

NS_ASSUME_NONNULL_END
