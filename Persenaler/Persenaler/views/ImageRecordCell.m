//
//  ImageRecordCell.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/4/20.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "ImageRecordCell.h"
#import "ZDWUtility.h"


@interface  ImageRecordCell(){
    
    UIImageView *imgView;
    UILabel *descLbl;
    UIView * markView;
}

@end

@implementation ImageRecordCell

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
    
    descLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, self.frame.size.height-20, self.frame.size.width-40, 20)];
    descLbl.textColor = [UIColor lightGrayColor];
    descLbl.textAlignment = NSTextAlignmentLeft;
    descLbl.font = [UIFont systemFontOfSize:12];
    
    
    [self.contentView addSubview:descLbl];
    
    [markView removeFromSuperview];
    markView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 5, self.frame.size.height)];
    markView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:markView];
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
    
    NSDictionary * propertyDic = [value getDicProperty];
    if (propertyDic) {
        NSString * markstr = [propertyDic objectForKey:@"markstr"];
        if ([markstr length] > 0) {
            dateStr = [NSString stringWithFormat:@"%@ %@",dateStr,markstr];
        }
    }
    
    descLbl.text = dateStr;
}

//- (NSString*)getImagePath:(NSString *)name {
//
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
//
//    NSString *docPath = [path objectAtIndex:0];
//
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//
//    NSString *finalPath = [docPath stringByAppendingPathComponent:name];
//
//    [fileManager createDirectoryAtPath:[finalPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];//stringByDeletingLastPathComponent是关键
//    return finalPath;
//
//}

@end
