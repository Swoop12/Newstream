//
//  DVMNewsApiClient.h
//  NewStream
//
//  Created by DevMountain on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVMNews.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVMNewsApiClient : NSObject

+(void)fetchTopHeadlinesWithBlock:(void (^)(NSArray<DVMNews *> * _Nullable articles))block;

+(void)fetchImageForUrl:(NSString *)imageUrlString withBlock: (void (^)(UIImage * _Nullable photo))block;

+(void)fetchAllNewsWithKeyword:(NSString *)keyword andCompletion:(void (^)(NSArray<DVMNews *> * _Nullable articles))completion;

@end

NS_ASSUME_NONNULL_END
