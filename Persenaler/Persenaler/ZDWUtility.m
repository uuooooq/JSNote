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

+(CGFloat)getLabelHight:(NSString*)currentStr withWidth:(CGFloat)currentWidth withFontSize:(UIFont*)foneSize{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:currentStr];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;//调整行间距 这个跟计算高度的行间距一定要对应
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [currentStr length])];
    
    UIFont *systemFont = foneSize;
    
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

+(NSMutableAttributedString*)getLabelAttributeString:(NSString*)currentStr withFontSize:(UIFont*)foneSize{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:currentStr];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;//调整行间距 这个跟计算高度的行间距一定要对应
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [currentStr length])];
    
    UIFont *systemFont = foneSize;
    
    [attributedString addAttribute:NSFontAttributeName value:systemFont range:NSMakeRange(0, [currentStr length])];
    
    return attributedString;
}

+ (void)copyBigFileFromPath:(NSString*)fromPath{
    //准备：把大的文件的放在/Documents/source.pdf
    //需求：大的source.pdf的内容分批地拷贝到target.pdf
    //1.获取两个文件的路径
    NSString *tagetFileName = [fromPath lastPathComponent];
    NSString *sourcePath = fromPath;//[self.documentsPath stringByAppendingPathComponent:@"source.pdf"];
    NSString *targetPath = [self getImagePath:tagetFileName];//[self.documentsPath stringByAppendingPathComponent:@"target2.pdf"];
    
    NSLog(@"source : %@ \n target: %@",sourcePath,targetPath);
    //2.创建空的target.pdf文件
    [[NSFileManager defaultManager] createFileAtPath:targetPath contents:nil attributes:nil];
    //3.创建两个NSFileHandle对象
    NSFileHandle *sourceHandle = [NSFileHandle fileHandleForReadingAtPath:sourcePath];
    NSFileHandle *targetHandle = [NSFileHandle fileHandleForWritingAtPath:targetPath];
    //4.while循环分批拷贝
    //设定每次从源文件读取5000bytes
    int dataSizePerTimes = 5000;
    //    //源文件的总大小(方式一)
    //    NSDictionary *sourceFileDic = [[NSFileManager defaultManager] attributesOfItemAtPath:sourcePath error:nil];
    //    NSLog(@"源文件pdf的属性字典:%@", sourceFileDic);
    //    //单位：bytes
    //    NSNumber *fileSize = [sourceFileDic objectForKey:NSFileSize];
    //    int fileTotalSize = [fileSize intValue];
    /*源文件的总大小(方式二)
     坑：如下的方法会把源文件handle对象直接指向最后
     */
    unsigned long long fileTotalSize = [sourceHandle seekToEndOfFile];
    //把挪动到最后的文件指针挪到最前面(相对于文件的开头的偏移量offset)
    [sourceHandle seekToFileOffset:0];
    //已经读取源文件的总大小
    int readFileSize = 0;
    
    //while循环
    while (1) {
        //计算剩余没有读取的数据的大小
        unsigned long long leftSize = fileTotalSize - readFileSize;
        //情况一：剩余不足5000bytes
        if (leftSize < dataSizePerTimes) {
            //直接读取剩下的所有数据
            NSData *leftData = [sourceHandle readDataToEndOfFile];
            //写入目标文件
            [targetHandle writeData:leftData];
            //跳出循环
            break;
        } else {
            //情况二:每次读取5000bytes
            NSData *data = [sourceHandle readDataOfLength:dataSizePerTimes];
            //写入目标文件
            [targetHandle writeData:data];
            //更新已经读取的数据大小
            readFileSize += dataSizePerTimes;
        }
    }
    
    //收尾工作(关闭指向)
    [sourceHandle closeFile];
    [targetHandle closeFile];
}

+(int)getCurrentTime{
    
    NSDate *datenow = [NSDate date];
    return [datenow timeIntervalSince1970];
}

+(UIColor *) getColor:(NSString *)hexColor
{
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
     
     if ([cString length] < 6) {
         return [UIColor whiteColor];
     }
     
     if ([cString hasPrefix:@"#"]) {
         cString = [cString substringFromIndex:1];
     }
     
     if ([cString length] != 6) {
         return [UIColor whiteColor];
     }
     
     NSRange range;
     range.location = 0;
     range.length = 2;
     NSString *rString = [cString substringWithRange:range];
     
     range.location = 2;
     NSString *gString = [cString substringWithRange:range];
     
     range.location = 4;
     NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r/255.0f)
                           green:((float) g/255.0f)
                            blue:((float) b/255.0f)
                           alpha:1.0];
}

@end
