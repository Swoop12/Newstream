//
//  News.m
//  NewStream
//
//  Created by DevMountain on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

#import "DVMNews.h"

@implementation DVMNews

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    //1) get all the values I need out of the dictionary
    NSString *title = dictionary[@"title"];
    NSString *author = dictionary[@"author"];
    NSString *imageUrl = dictionary[@"urlToImage"];
    NSString *source = dictionary[@"source"][@"name"];
    NSString *content = dictionary[@"content"];
    
    if (![title isKindOfClass:[NSString class]] ||
        ![author isKindOfClass:[NSString class]] ||
        ![imageUrl isKindOfClass:[NSString class]] ||
        ![content isKindOfClass:[NSString class]] ||
        ![source isKindOfClass:[NSString class]]){
        return nil;
    }
    
    //2) Actually initalize self and set properties
    self = [super init];
    if (self){
        _title = title;
        _author = author;
        _imageUrl = imageUrl;
        _source = source;
        _content = content;
    }
    return self;
}

@end
