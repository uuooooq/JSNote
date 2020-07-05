//
//  AudioRecordCell.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/3.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbKeyValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioRecordCell : UICollectionViewCell{
    
}
@property(nonatomic,strong)UILabel *titleLbl;
-(void)updateRecord:(DbKeyValue*)value;
@end

NS_ASSUME_NONNULL_END
