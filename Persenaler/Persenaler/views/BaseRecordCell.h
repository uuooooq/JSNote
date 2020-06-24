//
//  BaseRecordCell.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/24.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbKeyValue.h"
#import "ZDWUtility.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseRecordCell : UICollectionViewCell{
    
}

@property(nonatomic,strong) UIButton * selectionBtn;

-(void)updateRecord:(DbKeyValue*)value;

+(CGSize)caculateCurrentSize:(NSString*)value;

-(void)showSelectBtn;
-(void)dismissSelectBtn;

@end

NS_ASSUME_NONNULL_END
