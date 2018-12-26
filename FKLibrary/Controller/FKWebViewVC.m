//
//  FKWebViewVC.m
//  FKLibraryExample
//
//  Created by frank on 2018/9/6.
//  Copyright © 2018年 zmosa. All rights reserved.
//

#import "FKWebViewVC.h"
#import <AFNetworking.h>

@interface FKWebViewVC ()

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation FKWebViewVC

+ (instancetype)webVCWithPath:(NSURL *)path title:(NSString *)title
{
    FKWebViewVC *webVC = [[FKWebViewVC alloc] init];
    webVC.path = path;
    webVC.title = title;
    return webVC;
}

+ (instancetype)webVCWithPath:(NSURL *)path title:(NSString *)title param:(NSDictionary *)param
{
    FKWebViewVC *webVC = [self webVCWithPath:path title:title];
    webVC.param = param;
    return webVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, fkScreenW, self.view.frame.size.height)];
    webView.scalesPageToFit = false;
    [self.view addSubview:webView];
    webView.backgroundColor = [UIColor whiteColor];
    self.webView = webView;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.path];
    [self.webView loadRequest:request];
    
}


@end
