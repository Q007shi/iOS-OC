//
//  ViewController.m
//  iOS-OC
//
//  Created by 石富才 on 2020/11/1.
//  Copyright © 2020 石富才. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
//
#import "WKProcessPool+FCShare.h"

@interface ViewController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>

/** <#aaa#> */
@property(nonatomic,strong)WKWebView *webView;

/** 配置 webView */
@property(nonatomic,strong)WKWebViewConfiguration *configuration;

/** 偏好设置 */
@property(nonatomic,strong)WKPreferences *preference;
/** 关联 JS 与 OC 的交互 */
@property(nonatomic,strong)WKUserContentController *userContentController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //为 WKWebView 的 scrollView 设置代理：
    //在 -viewWillAppear: 方法中设置 self.webView.scrollView.delegate = self;
    //在 -viewWillDisappear: 和 -dealloc 方法中设置 self.webView.scrollView.delegate = nil;
    
    [self.view addSubview:self.webView];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1:8848/JS/BaseJS/JS.html"]]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"html.html" ofType:nil];
    NSString *htmlString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //加载本地html文件
    [_webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.webView evaluateJavaScript:@"changeInputValue(AAA)" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
    }];
}

#pragma mark - WKScriptMessageHandler JS 与 OC 交互的回掉方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"JS 的方法名：%@",message.name);
    NSLog(@"JS 传出的参数：%@",message.body);
    //jsToOC
}
//移除注册的 JS
- (void)_removeScriptMessage{
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"jsToOC"];
}

//MARK: WKNavigationDelegate
 // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *requestUrlStr = navigationAction.request.URL.absoluteString;
    
    if ([requestUrlStr hasPrefix:@"tb://"]) {
        //
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction preferences:(WKWebpagePreferences *)preferences decisionHandler:(void (^)(WKNavigationActionPolicy, WKWebpagePreferences *))decisionHandler API_AVAILABLE(macos(10.15), ios(13.0)){
//
//}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
}
//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}
//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
}
//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macos(10.11), ios(9.0)){
    
}

//MARK: WKUIDelegate 主要处理JS脚本，确认框，警告框等


//MARK: getter 方法
- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:self.configuration];
        //处理跳转、加载操作
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
    }
    return _webView;
}
- (WKWebViewConfiguration *)configuration{
    if (!_configuration) {
        _configuration = WKWebViewConfiguration.new;
        //同一进程池，不通 WKWebView 之间可以共享本地资源(cookie)。
        _configuration.processPool = WKProcessPool.shareInstance;
        //偏好设置
        _configuration.preferences = self.preference;
        //JS 调 OC
        _configuration.userContentController = self.userContentController;
        //是否支持记忆读取
        _configuration.suppressesIncrementalRendering = YES;
        
    }
    return _configuration;
}
- (WKPreferences *)preference{
    if (!_preference) {
        _preference = WKPreferences.new;
        //最小字体大小。当 javaScriptEnable 为 NO 时，有明显效果。
        _preference.minimumFontSize = 15;
        //是否支持 JavaScript
        _preference.javaScriptEnabled = YES;
        //未经用户同意 JS 是否可以打开窗口
        _preference.javaScriptCanOpenWindowsAutomatically = YES;
        if (@available(iOS 13.0,*)) {
            //是否提示该网站为钓鱼网站或非法网站(仅在中国可用)
            _preference.fraudulentWebsiteWarningEnabled = YES;
        }
    }
    return _preference;
}
- (WKUserContentController *)userContentController{
    if (!_userContentController) {
        _userContentController = WKUserContentController.new;
        
        //在 JS 中注入一个方法名为 jsToOC 的 JS 方法(用完记得移除)
        [_userContentController addScriptMessageHandler:self name:@"jsToOC"];
        
        //在 JS 中注入一个方法名为 jsToOCParams 的 JS 方法(用完记得移除)
        //WKUserScriptInjectionTimeAtDocumentStart document 元素生成，其它内容未 load 之前
        //WKUserScriptInjectionTimeAtDocumentEnd 所有内容 load 之后注入
        WKUserScript *userScript = [[WKUserScript alloc]initWithSource:@"window.onload = function(){var inputs = document.getElementsByTagName('input');for(var index in inputs){if (inputs[index].name == 'user_name'){inputs[index].value = '石富才';}else if(inputs[index].name == 'user_photo'){inputs[index].value = '17607163782';}}}" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
        [_userContentController addUserScript:userScript];
        
        /**
         读取本地 JS 代码
         NSString *jspath = [[NSBundle mainBundle]pathForResource:@"ZBPlus-iOS.txt" ofType:nil];
         NSString *str = [NSString stringWithContentsOfFile:jspath encoding:NSUTF8StringEncoding error:nil];
         */
    }
    return _userContentController;
}


/**
 WKProgessPool 用于配制进程池，与网页视图的资源共享有关。
 
 
 */

@end
