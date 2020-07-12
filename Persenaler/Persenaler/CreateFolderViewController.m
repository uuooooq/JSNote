//
//  CreateFolderViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/7/2.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "CreateFolderViewController.h"
#import <STPopup/STPopup.h>

@interface CreateFolderViewController ()

@end

@implementation CreateFolderViewController
{
    UILabel *_label;
    UIImageView *_imageView;
    UIView *_separatorView;
    UITextField *_textField;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"添加文件夹";
        self.contentSizeInPopup = CGSizeMake(300, 80);
        //self.landscapeContentSizeInPopup = CGSizeMake(400, 200);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [DataSource sharedDataSource];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"创建" style:UIBarButtonItemStylePlain target:self action:@selector(imageBtnDidTap)];
    
    _textField = [UITextField new];
    _textField.placeholder = @"请填写文件夹名称";
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_textField];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _textField.frame = CGRectMake(0, 22, self.view.frame.size.width, 44);
//    _separatorView.frame = CGRectMake(0, _textField.frame.origin.y - 0.5, self.view.frame.size.width, 0.5);
//    _imageView.frame = CGRectMake(20, 10, self.view.frame.size.width - 40, self.view.frame.size.height - 20 - _textField.frame.size.height);
}

- (void)imageBtnDidTap
{
    
//    if ([_textField.text length] < 1) {
//        return;
//    }
//    
//    NSDictionary *dic = [self.editKeyValue getDicProperty];
//    
//    if (dic) {
//        [dic setValue:_textField.text forKey:@"markstr"];
//        self.editKeyValue.property = [ZDWUtility convertStringFromDic:dic];
//    }else{
//        NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
//        [propertyDic setValue:@"" forKey:@"markcolor"];
//        [propertyDic setValue:_textField.text forKey:@"markstr"];
//        self.editKeyValue.property = [ZDWUtility convertStringFromDic:propertyDic];
//    }
//    self.editKeyValue.search = [NSString stringWithFormat:@"%@%@",self.editKeyValue.value,_textField.text];
//    [[DataSource sharedDataSource] updateKeyValue:self.editKeyValue];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
//
    
    if ([_textField.text length] < 1) {
        return;
    }
    
    if(self.fromKeyValue){
        
        DbKeyValue * keyValue = [DbKeyValue new];
        keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
        keyValue.value = _textField.text;
        keyValue.createTime =[DbKeyValue getCurrentTime];
        keyValue.type = VT_SUB_ROOT;
        NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
        [propertyDic setValue:@"" forKey:@"markcolor"];
        [propertyDic setValue:@"" forKey:@"markstr"];
        keyValue.property = [ZDWUtility convertStringFromDic:propertyDic];
        keyValue.search = keyValue.value;
        [self.dataSource addRecord:keyValue];
        
        DbKeyValue *subItem = [self.dataSource getKeyValue:keyValue.key];
        SubRecord *subRecord = [SubRecord new];
        subRecord.rootKey = self.fromKeyValue.key;
        subRecord.subKey = subItem.key;
        subRecord.createTime = subItem.createTime;
        
        [self.dataSource addSubRecord:subRecord];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
        
//        [self dismissViewControllerAnimated:YES completion:^{
//
//        }];
        [self.popupController dismiss];
        
    }
    else{
        DbKeyValue * keyValue = [DbKeyValue new];
        keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
        keyValue.value = _textField.text;
        keyValue.createTime =[DbKeyValue getCurrentTime];
        keyValue.type = VT_ROOT;
        //keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
        NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
        [propertyDic setValue:@"" forKey:@"markcolor"];
        [propertyDic setValue:@"" forKey:@"markstr"];
        keyValue.property = [ZDWUtility convertStringFromDic:propertyDic];
        keyValue.search = keyValue.value;
        [self.dataSource addRecord:keyValue];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
        
//        [self dismissViewControllerAnimated:YES completion:^{
//
//        }];
        [self.popupController dismiss];
    }
    
    
    
    
}

@end
