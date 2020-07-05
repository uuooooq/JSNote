//
//  AddPhotoTextViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/30.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "AddPhotoTextViewController.h"
#import <STPopup/STPopup.h>

@interface AddPhotoTextViewController ()

@end

@implementation AddPhotoTextViewController
{
    UILabel *_label;
    UIImageView *_imageView;
    UIView *_separatorView;
    UITextField *_textField;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"添加图片标记";
        self.contentSizeInPopup = CGSizeMake(300, 400);
        self.landscapeContentSizeInPopup = CGSizeMake(400, 200);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(imageBtnDidTap)];
    
    NSString* filePath = [ZDWUtility getImagePath:self.editKeyValue.value];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    //imgView.image = image;
    
    _imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.view addSubview:_imageView];
    
    _separatorView = [UIView new];
    _separatorView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self.view addSubview:_separatorView];
    
    _textField = [UITextField new];
    NSDictionary *dic = [self.editKeyValue getDicProperty];
    NSString *markstr = [dic objectForKey:@"markstr"];
    if ([markstr length]>0) {
        _textField.text = markstr;
    }
    else{
        _textField.placeholder = @"添加描述，方便搜索到此图片";
    }
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_textField];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _textField.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
    _separatorView.frame = CGRectMake(0, _textField.frame.origin.y - 0.5, self.view.frame.size.width, 0.5);
    _imageView.frame = CGRectMake(20, 10, self.view.frame.size.width - 40, self.view.frame.size.height - 20 - _textField.frame.size.height);
}

- (void)imageBtnDidTap
{
    
    if ([_textField.text length] < 1) {
        return;
    }
    
    NSDictionary *dic = [self.editKeyValue getDicProperty];
    
    if (dic) {
        [dic setValue:_textField.text forKey:@"markstr"];
        self.editKeyValue.property = [ZDWUtility convertStringFromDic:dic];
    }else{
        NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
        [propertyDic setValue:@"" forKey:@"markcolor"];
        [propertyDic setValue:_textField.text forKey:@"markstr"];
        self.editKeyValue.property = [ZDWUtility convertStringFromDic:propertyDic];
    }
    self.editKeyValue.search = [NSString stringWithFormat:@"%@%@",self.editKeyValue.value,_textField.text];
    [[DataSource sharedDataSource] updateKeyValue:self.editKeyValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
    [self.popupController dismiss];
}
@end
