//
//  WKProcessPool+FCShare.h
//  iOS-OC
//
//  Created by 石富才 on 2020/11/1.
//  Copyright © 2020 石富才. All rights reserved.
//

/**
 进程池：当多个 WKWebView 共享本地资源(如：cookie)时需要使用同一个 WKProcessPool
 */


#import <WebKit/WebKit.h>

@interface WKProcessPool (FCShare)

+ (instancetype)shareInstance;

@end
