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
    
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, self.frame.size.width - 20*2, self.frame.size.height - 10*2)];
    imgView.contentMode = UIViewContentModeCenter;
    imgView.clipsToBounds = YES;
    [self addSubview:imgView];
    
    
}

-(void)updateRecord:(DbKeyValue*)value{
    
    //title.text = value.value;
    NSString* filePath = [self getImagePath:value.value];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    imgView.image = image;
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
