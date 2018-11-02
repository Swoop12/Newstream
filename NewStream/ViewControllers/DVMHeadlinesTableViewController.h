//
//  DVMHeadlinesTableViewController.h
//  NewStream
//
//  Created by DevMountain on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVMNewsApiClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVMHeadlinesTableViewController : UITableViewController

@property(nonatomic, readwrite) NSArray<DVMNews *> *articles;

@end

NS_ASSUME_NONNULL_END
