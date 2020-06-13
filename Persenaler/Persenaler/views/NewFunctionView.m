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
    
    self.addTxtBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 7, 32, 32)];
    //[self.addTxtBtn setTitle:@"文本" forState:UIControlStateNormal];
    [self.addTxtBtn setImage:[UIImage imageNamed:@"taketext"] forState:UIControlStateNormal];
    [self.addTxtBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.addTxtBtn];
    
    self.addImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+60, 7, 32, 32)];
    //[self.addImgBtn setTitle:@"图片" forState:UIControlStateNormal];
    [self.addImgBtn setImage:[UIImage imageNamed:@"takephoto"] forState:UIControlStateNormal];
    [self.addImgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.addImgBtn];
    
}


-(void)updateViewFunctionState:(ViewState)viewState{
    
    switch (viewState) {
        case VS_HomeList:
        {
            self.searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width -60, 7, 32, 32)];
            //[self.addVideoBtn setTitle:@"视频" forState:UIControlStateNormal];
            [self.searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
            [self.searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:self.searchBtn];
        }
            break;
        case VS_ItemDetail_Img:
        {
            self.tagBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+60+60, 7, 32, 32)];
            //[self.addVideoBtn setTitle:@"视频" forState:UIControlStateNormal];
            [self.tagBtn setImage:[UIImage imageNamed:@"tag"] forState:UIControlStateNormal];
            [self.tagBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:self.tagBtn];

            self.saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+60+60+60, 7, 32, 32)];
            //[self.addAudioBtn setTitle:@"音频" forState:UIControlStateNormal];
            [self.saveBtn setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
            [self.saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:self.saveBtn];
        }
            break;
        case VS_ItemDetail_Text:
        {
            self.copyyBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+60+60, 7, 32, 32)];
            //[self.editBtn setTitle:@"视频" forState:UIControlStateNormal];
            [self.copyyBtn setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
            //[self.editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:self.copyyBtn];

//            self.copyyBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+60+60+60, 7, 32, 32)];
//            //[self.copyyBtn setTitle:@"音频" forState:UIControlStateNormal];
//            [self.copyyBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
//            //[self.copyyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [self addSubview:self.copyyBtn];
            
        }
            break;
        default:
            break;
    }
    
}

@end
