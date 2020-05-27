//
//  BaseRecordCell.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/24.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbKeyValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseRecordCell : UICollectionViewCell{
    
}

@property(nonatomic,strong) UIButton * commBtn;

-(void)updateRecord:(DbKeyValue*)value;

+(CGSize)caculateCurrentSize:(NSString*)value;

@end

NS_ASSUME_NONNULL_END
