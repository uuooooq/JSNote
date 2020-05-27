//
//  BaseRecordCell.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/24.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "BaseRecordCell.h"
#import "ZDWUtility.h"



@interface  BaseRecordCell(){
    
    UILabel *title;
    
    
}

@end

@implementation BaseRecordCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self customizeView];
    }
    return self;
}

-(void)customizeView{
    
//    title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width-20, self.frame.size.width-10)];
//    title.textColor = [UIColor blackColor];
//    title.numberOfLines = 0;
//    title.attributedText = [ZDWUtility getLabelAttributeString:];
//    [self.contentView addSubview:title];
    
//    _commBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 30 -10, 60 -20-5, 30, 20)];
//    [_commBtn setTitle:@"comm" forState:UIControlStateNormal];
//    //[commBtn addTarget:self action:@selector(clickCommAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_commBtn];
    
}


-(void)updateRecord:(DbKeyValue*)value{
    
    //title.text = value.value;
    [title removeFromSuperview];
    title = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10)];
    title.textColor = [UIColor blackColor];
    title.numberOfLines = 0;
    title.attributedText = [ZDWUtility getLabelAttributeString:value.value];
    title.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:title];
}

+(CGSize)caculateCurrentSize:(NSString*)value{
    
    CGFloat higth = [ZDWUtility getLabelHight:value withWidth:ZDWSCREEN_WIDTH-20];
    return CGSizeMake(ZDWSCREEN_WIDTH-10, higth+10);
}

//+(NSMutableAttributedString*)getLabelAttributeString:(NSString*)value{
//    
//}

@end
