//
//  AudioRecordCell.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/3.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "AudioRecordCell.h"

@implementation AudioRecordCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self customizeView];
    }
    return self;
}

-(void)customizeView{
    
//    title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width-20, self.frame.size.width-10)];
//    title.textColor = [UIColor blackColor];
//    title.numberOfLines = 0;
//    title.attributedText = [ZDWUtility getLabelAttributeString:];
//    [self.contentView addSubview:title];
    
//    _commBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 30 -10, 60 -20-5, 30, 20)];
//    [_commBtn setTitle:@"comm" forState:UIControlStateNormal];
//    //[commBtn addTarget:self action:@selector(clickCommAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_commBtn];

}

@end
