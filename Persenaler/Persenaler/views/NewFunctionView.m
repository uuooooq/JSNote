//
//  NewFunctionView.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/29.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "NewFunctionView.h"
#import <SVGKit/SVGKit.h>

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
//    [self.addTxtBtn setImage:[UIImage imageNamed:@"taketext"] forState:UIControlStateNormal];
//    [self.addTxtBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    SVGKImage *svgimageKeyboard = [SVGKImage imageNamed:@"basic_keyboard"];
    svgimageKeyboard.size = CGSizeMake(32, 32);
    [self.addTxtBtn setImage:svgimageKeyboard.UIImage forState:UIControlStateNormal];
    [self addSubview:self.addTxtBtn];
    
    self.addImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+60, 7, 32, 32)];
    //[self.addImgBtn setTitle:@"图片" forState:UIControlStateNormal];
//    [self.addImgBtn setImage:[UIImage imageNamed:@"takephoto"] forState:UIControlStateNormal];
//    [self.addImgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    SVGKImage *svgimagePhoto = [SVGKImage imageNamed:@"basic_photo"];
    svgimagePhoto.size = CGSizeMake(32, 32);
    [self.addImgBtn setImage:svgimagePhoto.UIImage forState:UIControlStateNormal];
    [self addSubview:self.addImgBtn];
    
}


-(void)updateViewFunctionState:(ViewState)viewState{
    
    switch (viewState) {
        case VS_HomeList:
        {
            self.folderBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+60+60, 7, 32, 32)];
            //[self.addVideoBtn setTitle:@"视频" forState:UIControlStateNormal];
//            [self.folderBtn setImage:[UIImage imageNamed:@"folder"] forState:UIControlStateNormal];
//            [self.folderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            SVGKImage *svgimageFolder = [SVGKImage imageNamed:@"basic_folder"];
            svgimageFolder.size = CGSizeMake(32, 32);
            [self.folderBtn setImage:svgimageFolder.UIImage forState:UIControlStateNormal];
            [self addSubview:self.folderBtn];
            
            self.searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width -60, 7, 32, 32)];
            //[self.addVideoBtn setTitle:@"视频" forState:UIControlStateNormal];
            //[self.searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
            ///UIImage *tmpImage = [UIImage systemImageNamed:@"magnifyingglass" withConfiguration:];
            //tmpImage = [tmpImage imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
            //tmpImage = [tmpImage imageWithTintColor:[UIColor blackColor]];
            //[tmpImage];
            //[tmpImage ]
            //[self.searchBtn setImage:tmpImage forState:(UIControlStateNormal)];
            //[self.searchBtn setTintColor:[UIColor blackColor]];
            SVGKImage *svgimage = [SVGKImage imageNamed:@"basic_magnifier"];
            svgimage.size = CGSizeMake(28, 28);
            [self.searchBtn setImage:svgimage.UIImage forState:UIControlStateNormal];
            //[self.searchBtn.imageView setImage:[UIImage systemImageNamed:@"magnifyingglass"]];
            
            //[self.searchBtn.imageView setTintColor:[UIColor blackColor]];
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
            self.folderBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+60+60, 7, 32, 32)];
            //[self.addVideoBtn setTitle:@"视频" forState:UIControlStateNormal];
//            [self.folderBtn setImage:[UIImage imageNamed:@"folder"] forState:UIControlStateNormal];
//            [self.folderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            SVGKImage *svgimageFolder = [SVGKImage imageNamed:@"basic_folder"];
            svgimageFolder.size = CGSizeMake(32, 32);
            [self.folderBtn setImage:svgimageFolder.UIImage forState:UIControlStateNormal];
            [self addSubview:self.folderBtn];
            
        }
            break;
        default:
            break;
    }
    
}

@end
