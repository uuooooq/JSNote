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
    
//    _commBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 30 -10, 60 -20-5, 30, 20)];
//    [_commBtn setTitle:@"comm" forState:UIControlStateNormal];
//    //[commBtn addTarget:self action:@selector(clickCommAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_commBtn];
    
}


-(void)updateRecord:(DbKeyValue*)value{
    
    title.text = value.value;
}

@end
