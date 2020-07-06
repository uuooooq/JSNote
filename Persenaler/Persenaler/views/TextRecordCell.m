//
//  TextRecordCell.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/24.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "TextRecordCell.h"
@interface  TextRecordCell(){
    
    UILabel *title;
    UILabel *descLbl;
    UIView * markView;
    
}

@end

@implementation TextRecordCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self customizeView];
    }
    return self;
}

-(void)customizeView{


}


-(void)updateRecord:(DbKeyValue*)value{
    
    //title.text = value.value;
    [title removeFromSuperview];
    title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width-10-10, self.frame.size.height-22)];
    title.textColor = [UIColor blackColor];
    title.numberOfLines = 3;
    //title.attributedText = [ZDWUtility getLabelAttributeString:value.value];
    //title.backgroundColor = [UIColor grayColor];
    title.lineBreakMode = NSLineBreakByTruncatingTail;
    title.font = [UIFont systemFontOfSize:13.0f];
    
    title.text = value.value;
    [self.contentView addSubview:title];
    
    [descLbl removeFromSuperview];
    descLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height-20, 200, 20)];
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
    
    
    [markView removeFromSuperview];
    markView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.frame.size.height)];
    markView.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:markView];
    
    [self.contentView addSubview:descLbl];
}

+(CGSize)caculateCurrentSize:(NSString*)value{
    
//    CGFloat higth = [ZDWUtility getLabelHight:value withWidth:ZDWSCREEN_WIDTH-20];
//    if (higth > 100) {
//        higth = 100;
//    }
    return CGSizeMake(ZDWSCREEN_WIDTH, 70);
}


@end
