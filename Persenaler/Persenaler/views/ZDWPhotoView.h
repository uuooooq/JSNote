//
//  ZDWPhotoView.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/27.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZDWPhotoViewDelegate <NSObject>

-(void)photoViewTapAction;

@end

@interface ZDWPhotoView : UIScrollView

@property(nonatomic,strong) UIImage *image;
@property(nonatomic,weak,nullable) id<ZDWPhotoViewDelegate> photoDelegate;


@end

NS_ASSUME_NONNULL_END
