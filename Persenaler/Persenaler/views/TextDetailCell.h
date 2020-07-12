//
//  TextDetailCell.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/10.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbKeyValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface TextDetailCell : UICollectionViewCell

-(void)updateRecord:(DbKeyValue*)value;

+(CGSize)caculateCurrentSize:(NSString*)value;

@end

NS_ASSUME_NONNULL_END
