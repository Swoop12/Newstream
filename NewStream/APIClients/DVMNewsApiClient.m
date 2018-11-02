//
//  DVMNewsApiClient.m
//  NewStream
//
//  Created by DevMountain on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

#import "DVMNewsApiClient.h"
#import <UIKit/UIKit.h>

@implementation DVMNewsApiClient

+(NSString *)baseUrlString{
    return @"https://newsapi.org/v2/top-headlines";
}

+ (void)fetchTopHeadlinesWithBlock:(void (^)(NSArray<DVMNews *> * _Nullable))block
{
    //1) Construct Our URL
    NSURL *baseurl = [[NSURL alloc] initWithString: [DVMNewsApiClient baseUrlString]];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:baseurl resolvingAgainstBaseURL:true];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:@"us"];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"apiKey" value: DVMNewsApiClient.apiKey];
    [components setQueryItems: [[NSArray alloc] initWithObjects:countryQuery, apiKeyQuery, nil]];
    NSURL *finalUrl = [components URL];
    
    NSLog(@"%@", [finalUrl absoluteString]);
    
    //2) Perform DataTask, Seralize Objects, Resume

    [[[NSURLSession sharedSession] dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error){
            NSLog(@"Error in %s, %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
            block(nil);
            return;
        }
        
        NSLog(@"%@", response);
        
        if (!data){
            NSLog(@"NO DATA AVailable");
            block(nil);
            return;
        }
        
        NSDictionary *jsonDictioanry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray<NSDictionary *> *articleDictionaries = jsonDictioanry[@"articles"];
        
        NSMutableArray *articles = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in articleDictionaries){
            DVMNews *news = [[DVMNews alloc] initWithDictionary:dictionary];
            if(news){
                [articles addObject:news];
            }
        }
        block(articles);
    }] resume];
}

+ (void)fetchImageForUrl:(NSString *)imageUrlString withBlock:(void (^)(UIImage * _Nullable))block
{
    //1) Construct the URL
    NSURL *url = [[NSURL alloc] initWithString:imageUrlString];
    NSLog(@"%@", url);
    
    //2) Data Task, resume
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error){
            NSLog(@"Error in %s, %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
            block(nil);
            return;
        }
        NSLog(@"%@", response);
        
        if (!data){
            NSLog(@"NO DATA AVAILABLE");
            block(nil);
            return;
        }
        
        UIImage *photo = [[UIImage alloc] initWithData:data];
        block(photo);
    }] resume];
}

//Static func to pull API key out of plist
+(NSString *)apiKey
{
    static NSString *apiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *apiKeysURL = [[NSBundle mainBundle] URLForResource:@"ApiKeys" withExtension:@"plist"];
        if (!apiKeysURL){
            NSLog(@"ERROR! APIKEY NOT FOUND");
            return;
        }
        NSDictionary *apiKeys = [[NSDictionary alloc] initWithContentsOfURL:apiKeysURL];
        apiKey = apiKeys[@"NewsApiKey"];
    });
    return apiKey;
}

@end
