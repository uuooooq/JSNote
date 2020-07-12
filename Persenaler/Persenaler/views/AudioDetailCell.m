//
//  AudioDetailCell.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/7.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "AudioDetailCell.h"

@implementation AudioDetailCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customizeView];
    }
    return self;
}

-(void)customizeView{
    
    UIImageView *audioIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 32, 32)];
    [audioIcon setImage:[UIImage imageNamed:@"audioicon"]];
    [self.contentView addSubview:audioIcon];
    
    _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(52, 14, self.frame.size.width-52-10, 24)];
    _titleLbl.textColor = [UIColor blackColor];
    _titleLbl.numberOfLines = 1;
    [self.contentView addSubview:_titleLbl];
    
    _playBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.frame.size.height-50, 40, 40)];
    [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self.contentView addSubview:_playBtn];
    
    _progress = [[UIProgressView alloc] initWithFrame:CGRectMake(60, self.frame.size.height-38, self.frame.size.width-60-20, 10)];
    [_progress setTrackTintColor:[UIColor whiteColor]];
    [self.contentView addSubview:_progress];
    
    self.backgroundColor = [UIColor colorWithRed:180/255. green:180/255. blue:180/255. alpha:1];

}

-(void)updateRecord:(DbKeyValue*)value{
    
//    NSError *error = nil;
//    
//    NSDictionary *extCategory = [NSJSONSerialization JSONObjectWithData:[value.extCategory dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
//    
    NSString *tmpString = value.value;
    
//    if (!error && [extCategory objectForKey:@"audiotime"]) {
//        NSNumber *audioTime = [extCategory objectForKey:@"audiotime"];
//
//        tmpString = [tmpString stringByAppendingFormat:@"  时长 %lu:%02ld",audioTime.longValue/60,audioTime.longValue%60];
//    }
    
    self.titleLbl.text = tmpString;
}

@end
