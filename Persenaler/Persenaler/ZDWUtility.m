//
//  ZDWUtility.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/4/20.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "ZDWUtility.h"

@implementation ZDWUtility

+(NSString*)convertStringFromDic:(NSDictionary*)dic{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if (! jsonData) {
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+ (NSString*)getImagePath:(NSString *)name {

    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);

    NSString *docPath = [path objectAtIndex:0];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *finalPath = [docPath stringByAppendingPathComponent:name];

    [fileManager createDirectoryAtPath:[finalPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];//stringByDeletingLastPathComponent是关键
    return finalPath;

}

+(CGFloat)getLabelHight:(NSString*)currentStr withWidth:(CGFloat)currentWidth{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:currentStr];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;//调整行间距 这个跟计算高度的行间距一定要对应
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [currentStr length])];
    
    UIFont *systemFont = [UIFont systemFontOfSize:13.0f];
    
    [attributedString addAttribute:NSFontAttributeName value:systemFont range:NSMakeRange(0, [currentStr length])];
    
    
    CGSize size = CGSizeMake(currentWidth,2000);
    
    CGSize lastSize= [attributedString boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine) context:nil].size;
    
    return lastSize.height;

}

+(NSMutableAttributedString*)getLabelAttributeString:(NSString*)currentStr{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:currentStr];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;//调整行间距 这个跟计算高度的行间距一定要对应
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [currentStr length])];
    
    UIFont *systemFont = [UIFont systemFontOfSize:13.0f];
    
    [attributedString addAttribute:NSFontAttributeName value:systemFont range:NSMakeRange(0, [currentStr length])];
    
    return attributedString;
}

@end
