//
//  FullsizeImageView.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/28.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "FullsizeImageView.h"
#import "ZDWUtility.h"
@implementation FullsizeImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _imgView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imgView];
    
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.frame.size.height-10-24, 24, 24)];
    [_closeBtn setImage:[UIImage imageNamed:@"closeFullsize"] forState:UIControlStateNormal];
    [_closeBtn setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_closeBtn];
    
    self.backgroundColor = [UIColor blackColor];
}

-(void)showImage:(NSString*)imgName{
    
    NSString* filePath = [ZDWUtility getImagePath:imgName];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    _imgView.image = image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
