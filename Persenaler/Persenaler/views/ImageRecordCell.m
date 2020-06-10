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
    
//    title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 30)];
//    title.textColor = [UIColor blackColor];
//    title.textAlignment = NSTextAlignmentLeft;
//    title.font = [UIFont systemFontOfSize:14];
//    [self.contentView addSubview:title];
    
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [self.contentView addSubview:imgView];
    
    descLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, self.frame.size.height-20, 200, 20)];
    descLbl.textColor = [UIColor lightGrayColor];
    descLbl.textAlignment = NSTextAlignmentLeft;
    descLbl.font = [UIFont systemFontOfSize:12];
    
//    _commBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 200-10-10-50, self.frame.size.height-20-5, 50, 20)];
//    [_commBtn setTitle:@"com" forState:UIControlStateNormal];
//    [_commBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    //[commBtn addTarget:self action:@selector(clickCommAction) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_commBtn];
    
//    _fullsizeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.frame.size.width-24-10, 24, 24)];
//    [_fullsizeBtn setImage:[UIImage imageNamed:@"fullsize"] forState:UIControlStateNormal];
//    [_fullsizeBtn setBackgroundColor:[UIColor whiteColor]];
//    [self.contentView addSubview:_fullsizeBtn];
    
//    UIImageView *tagImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
//    [tagImgView setImage:[UIImage imageNamed:@"takephoto"]];
//    tagImgView.contentMode = UIViewContentModeCenter;
//    [self.contentView addSubview:tagImgView];
    
    [self.contentView addSubview:descLbl];
}

-(void)updateRecord:(DbKeyValue*)value{
    
    //title.text = value.value;
    NSString* filePath = [self getImagePath:value.value];
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

- (NSString*)getImagePath:(NSString *)name {

    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);

    NSString *docPath = [path objectAtIndex:0];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *finalPath = [docPath stringByAppendingPathComponent:name];

    [fileManager createDirectoryAtPath:[finalPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];//stringByDeletingLastPathComponent是关键
    return finalPath;

}

@end
