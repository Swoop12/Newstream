//
//  News.h
//  NewStream
//
//  Created by DevMountain on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMNews : NSObject

@property(nonatomic, copy, readonly) NSString *title;
@property(nonatomic, copy, readonly, nullable) NSString *author;
@property(nonatomic, copy, readonly) NSString *source;
@property(nonatomic, copy, readonly, nullable) NSString *imageUrl;
@property(nonatomic, copy, readonly, nullable) NSString *content;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
