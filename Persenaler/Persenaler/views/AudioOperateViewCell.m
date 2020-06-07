//
//  AudioOperateViewCell.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/7.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "AudioOperateViewCell.h"

@implementation AudioOperateViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)initViews{
    _playBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
    //[_playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.playBtn];
}

@end
