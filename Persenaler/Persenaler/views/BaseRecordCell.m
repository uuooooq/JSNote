//
//  BaseRecordCell.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/24.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//




#import "BaseRecordCell.h"


@implementation BaseRecordCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

-(void)customizeView{

}


-(void)updateRecord:(DbKeyValue*)value{
    
}

-(void)showSelectBtn{
    
}
-(void)dismissSelectBtn{
    
}

+(CGSize)caculateCurrentSize:(NSString*)value{
    
    CGFloat higth = [ZDWUtility getLabelHight:value withWidth:ZDWSCREEN_WIDTH-20];
    
    if (higth > 100) {
        higth = 100;
    }
    return CGSizeMake(ZDWSCREEN_WIDTH-10, higth+40);
}


@end
