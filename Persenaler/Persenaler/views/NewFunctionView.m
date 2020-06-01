//
//  NewFunctionView.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/29.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "NewFunctionView.h"

@implementation NewFunctionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.addTxtBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 40, 24)];
    [self.addTxtBtn setTitle:@"文本" forState:UIControlStateNormal];
    [self.addTxtBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.addTxtBtn];
    
    self.addImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+60, 10, 40, 24)];
    [self.addImgBtn setTitle:@"图片" forState:UIControlStateNormal];
    [self.addImgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.addImgBtn];
    
    self.addVideoBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+60+60, 5, 40, 24)];
    [self.addVideoBtn setTitle:@"选择" forState:UIControlStateNormal];
    [self.addVideoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.addVideoBtn];
    
//    self.addVideoBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+60+60, 5, 40, 24)];
//    [self.addVideoBtn setTitle:@"视频" forState:UIControlStateNormal];
//    [self.addVideoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self addSubview:self.addVideoBtn];
//
//    self.addAudioBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+60+60+60, 5, 40, 24)];
//    [self.addAudioBtn setTitle:@"音频" forState:UIControlStateNormal];
//    [self.addAudioBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self addSubview:self.addAudioBtn];
    
    
}

@end
