//
//  WKProcessPool+FCShare.m
//  iOS-OC
//
//  Created by 石富才 on 2020/11/1.
//  Copyright © 2020 石富才. All rights reserved.
//

#import "WKProcessPool+FCShare.h"


@implementation WKProcessPool (FCShare)

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static WKProcessPool *processPool;
    dispatch_once(&onceToken, ^{
        processPool = WKProcessPool.new;
    });
    return processPool;
}

@end
