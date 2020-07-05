//
//  FolderRecordCell.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/22.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "FolderRecordCell.h"

@interface  FolderRecordCell(){
    
    UILabel *title;
    UILabel *descLbl;
    UIView *markView;
    UIImageView *iconView;
    
}

@end

@implementation FolderRecordCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customizeView];
    }
    return self;
}

-(void)customizeView{
    
    markView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, self.frame.size.height)];
    markView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:markView];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, self.frame.size.width-25-40, 20)];
    title.textColor = [UIColor blackColor];
    title.numberOfLines = 1;
    title.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:title];
    
    descLbl = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height-20, 200, 20)];
    descLbl.textColor = [UIColor lightGrayColor];
    descLbl.textAlignment = NSTextAlignmentLeft;
    descLbl.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:descLbl];
    
    iconView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-38, (self.frame.size.height-24)/2, 24, 24)];
    iconView.image = [UIImage imageNamed:@"rightArrow"];
    [self.contentView addSubview:iconView];

}

-(void)updateRecord:(DbKeyValue*)value{
    
    title.text = value.value;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.createTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //最结尾的Z表示的是时区，零时区表示+0000，东八区表示+0800
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // 使用formatter转换后的date字符串变成了当前时区的时间
    NSString *dateStr = [formatter stringFromDate:date];
    descLbl.text = dateStr;
    
}

@end
