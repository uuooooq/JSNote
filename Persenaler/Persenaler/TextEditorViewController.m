//
//  TextEditorViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/27.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "TextEditorViewController.h"

@interface TextEditorViewController ()

@end

@implementation TextEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Large";
    
    //self.alwaysShowToolbar = YES;
    
    // HTML Content to set in the editor
    self.title = @"Selective";
    
    // HTML Content to set in the editor
    NSString *html = @"<p>Example showing just a few toolbar buttons.</p>";
    
    // Choose which toolbar items to show
    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarBold, ZSSRichTextEditorToolbarH1, ZSSRichTextEditorToolbarParagraph];
    
    // Set the HTML contents of the editor
    [self setHTML:html];
    
}

@end
