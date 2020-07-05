//
//  VideoRecordCell.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/3.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "VideoRecordCell.h"
#import "ZDWUtility.h"

@implementation VideoRecordCell{
    
    UIImageView *imgView;
    UILabel *descLbl;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customizeView];
    }
    return self;
}

-(void)customizeView{
    
    
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [self.contentView addSubview:imgView];
    
    descLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, self.frame.size.height-20, 200, 20)];
    descLbl.textColor = [UIColor lightGrayColor];
    descLbl.textAlignment = NSTextAlignmentLeft;
    descLbl.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:descLbl];
}

-(void)updateRecord:(DbKeyValue*)value{
    
    //title.text = value.value;
    NSString* filePath = [ZDWUtility getImagePath:value.value];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    imgView.image = image;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.createTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //最结尾的Z表示的是时区，零时区表示+0000，东八区表示+0800
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // 使用formatter转换后的date字符串变成了当前时区的时间
    NSString *dateStr = [formatter stringFromDate:date];
    descLbl.text = dateStr;
}

@end
