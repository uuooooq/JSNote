//
//  TextDetailCell.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/10.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "TextDetailCell.h"
#import "ZDWUtility.h"
#define FontSize 18

@implementation TextDetailCell{
    
    UILabel *title;
    UILabel *descLbl;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self customizeView];
    }
    return self;
}

-(void)updateRecord:(DbKeyValue*)value{
    
    //title.text = value.value;
    [title removeFromSuperview];
    title = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10)];
    title.textColor = [UIColor blackColor];
    title.numberOfLines = 0;
    title.font = [UIFont boldSystemFontOfSize:FontSize];
    title.attributedText = [ZDWUtility getLabelAttributeString:value.value withFontSize:[UIFont boldSystemFontOfSize:16]];//[ZDWUtility getLabelAttributeString:value.value];
    //title.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:title];
    
    [descLbl removeFromSuperview];
    descLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, self.frame.size.height-20, 200, 20)];
    descLbl.textColor = [UIColor lightGrayColor];
    descLbl.textAlignment = NSTextAlignmentLeft;
    descLbl.font = [UIFont systemFontOfSize:12];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.createTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //最结尾的Z表示的是时区，零时区表示+0000，东八区表示+0800
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // 使用formatter转换后的date字符串变成了当前时区的时间
    NSString *dateStr = [formatter stringFromDate:date];
    descLbl.text = dateStr;
    [self.contentView addSubview:descLbl];
}

+(CGSize)caculateCurrentSize:(NSString*)value{
    
    CGFloat higth = [ZDWUtility getLabelHight:value withWidth:ZDWSCREEN_WIDTH-20 withFontSize:[UIFont boldSystemFontOfSize:FontSize]];
    return CGSizeMake(ZDWSCREEN_WIDTH-20, higth+40);
}

@end
