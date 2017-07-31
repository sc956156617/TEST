//
//  BrandModel.m
//  QiPeiMagazine
//
//  Created by iOS Developer 3 on 16/7/11.
//  Copyright © 2016年 Laughing. All rights reserved.
//

#import "BrandModel.h"

@implementation BrandModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"brandId" : @"id"};
}

- (void)setThumbnail:(NSString *)thumbnail {

    if (_thumbnail != thumbnail) {
        _thumbnail = [thumbnail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

- (void)setDetailurl:(NSString *)detailurl {

    if (_detailurl != detailurl) {
        _detailurl = [detailurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

- (NSString *)keyword1 {
    
    if (!_keyword1) {
        _keyword1 = _keyword1 ? _keyword1 : @"";
    }
    return _keyword1;
}

- (NSString *)keyword2 {
    
    if (!_keyword2) {
        _keyword2 = _keyword2 ? _keyword2 : @"";
    }
    return _keyword2;
}

- (NSString *)keyword3 {
    
    if (!_keyword3) {
        _keyword3= _keyword3 ? _keyword3 : @"";
    }
    return _keyword3;
}

- (NSString *)keyword4 {
    
    if (!_keyword4) {
        _keyword4 = _keyword4 ? _keyword4 : @"";
    }
    return _keyword4;
}

- (NSString *)keyword5 {
    
    if (!_keyword5) {
        _keyword5 = _keyword5 ? _keyword5 : @"";
    }
    return _keyword5;
}


@end
