//
//  FullsizeImageView.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/28.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FullsizeImageView : UIView

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIButton *closeBtn;
-(void)showImage:(NSString*)imgName;

@end

NS_ASSUME_NONNULL_END
