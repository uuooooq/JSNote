//
//  InputViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/15.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "InputViewController.h"
#import "ZDWUtility.h"
#import <IQKeyboardManager/IQKeyboardManager.h>


@interface InputViewController (){
    
    UIButton *saveBtn;
}

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [DataSource sharedDataSource];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 200)];
    //_textView.backgroundColor = [UIColor lightGrayColor];
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _textView.layer.cornerRadius = 5;
    
    [self.view addSubview:_textView];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //manager.toolbarDoneBarButtonItemText = @"保存";
    [_textView addDoneOnKeyboardWithTarget:self action:@selector(saveAction)];
    //manager.toolbarDoneBarButtonItemImage = [UIImage imageNamed:@"save"];
    [_textView.keyboardToolbar.doneBarButton setTitle:@"保存"];
    //[_textView setToolbarPlaceholder:@"请输入"];
    //[_textView addDoneOnKeyboardWithTarget:self action:@selector(saveAction)];
    //manager.toolbarDoneBarButtonItemText = @"保存";
    
//    IQBarButtonItem *item = [[IQBarButtonItem alloc] initWithTitle:@"保存s" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
//    [_textView.keyboardToolbar setDoneBarButton:item];
//    _textView.toolbarPlaceholder = @"保存";
//    saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width- 60-10, 200+20, 60, 30)];
//    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
//    saveBtn.backgroundColor = [UIColor lightGrayColor];
//    [saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:saveBtn];/Users/zhudongwei/Downloads/IQKeyboardManager-master/Podfile
}

-(void)saveAction{
    
    if ([self.textView.text length] < 1) {
        return;
    }
    
    //NSMutableDictionary *extCategoryDic = [NSMutableDictionary dictionary];
    //[extCategoryDic setObject:TXT forKey:@"type"];
    DbKeyValue * keyValue = [DbKeyValue new];
    keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
    keyValue.value = self.textView.text;
    keyValue.createTime =[DbKeyValue getCurrentTime];
    keyValue.type = VT_SUB_TEXT;
    //keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
    [self.dataSource addRecord:keyValue];
    
    if (self.fromKeyValue) {
//        NSMutableDictionary *groupCategoryDic = [NSMutableDictionary dictionary];
        
//        DbKeyValueGroup *keyValueGroup = [DbKeyValueGroup new];
//        keyValueGroup.createTime = [DbKeyValueGroup getCurrentTime];
//        keyValueGroup.rootID = self.fromKeyValue.kvid;
//        keyValueGroup.rootValue = self.fromKeyValue.value;
//        keyValueGroup.extCategory = [ZDWUtility convertStringFromDic:groupCategoryDic];
//        DbKeyValue *subItem = [self.dataSource getKeyValue:keyValue.key];
//        keyValueGroup.subID = subItem.kvid;
//        keyValueGroup.subValue = subItem.value;
//        keyValueGroup.rootType = self.fromKeyValue.type;
//        keyValueGroup.subType = keyValue.type;
        DbKeyValue *subItem = [self.dataSource getKeyValue:keyValue.key];
        SubRecord *subRecord = [SubRecord new];
        subRecord.rootKey = self.fromKeyValue.key;
        subRecord.subKey = subItem.key;
        subRecord.createTime = subItem.createTime;
        
        [self.dataSource addSubRecord:subRecord];
    }
    

    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
