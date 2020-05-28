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
    UILabel *descLbl;
    
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
    //title.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:title];
    
    [descLbl removeFromSuperview];
    descLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-200-10, self.frame.size.height-20, 200, 20)];
    descLbl.textColor = [UIColor lightGrayColor];
    descLbl.textAlignment = NSTextAlignmentRight;
    descLbl.font = [UIFont systemFontOfSize:12];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.createTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //最结尾的Z表示的是时区，零时区表示+0000，东八区表示+0800
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 使用formatter转换后的date字符串变成了当前时区的时间
    NSString *dateStr = [formatter stringFromDate:date];
    descLbl.text = dateStr;
    [self.contentView addSubview:descLbl];
}

+(CGSize)caculateCurrentSize:(NSString*)value{
    
    CGFloat higth = [ZDWUtility getLabelHight:value withWidth:ZDWSCREEN_WIDTH-20];
    return CGSizeMake(ZDWSCREEN_WIDTH-10, higth+40);
}

//+(NSMutableAttributedString*)getLabelAttributeString:(NSString*)value{
//    
//}

@end
