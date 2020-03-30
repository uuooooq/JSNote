//
//  BaseRecordCell.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/24.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "BaseRecordCell.h"

@interface  BaseRecordCell(){
    
    UILabel *title;
    
}

@end

@implementation BaseRecordCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customizeView];
    }
    return self;
}

-(void)customizeView{
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 30)];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:title];
    
    
}

-(void)updateRecord:(DbKeyValue*)value{
    
    title.text = value.value;
}

@end
