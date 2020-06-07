//
//  AudioOperateView.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/7.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "AudioOperateView.h"

@implementation AudioOperateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    _playBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
    //[_playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self addSubview:self.playBtn];
}

@end
