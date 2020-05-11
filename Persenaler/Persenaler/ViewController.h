//
//  ViewController.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/23.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UISearchController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    
}

@property(nonatomic,strong) UICollectionView *shuKucollectionView;


@end

