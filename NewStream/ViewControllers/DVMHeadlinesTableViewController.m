//
//  DVMHeadlinesTableViewController.m
//  NewStream
//
//  Created by DevMountain on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

#import "DVMHeadlinesTableViewController.h"
#import "NewStream-Swift.h"

@interface DVMHeadlinesTableViewController ()



@end

@implementation DVMHeadlinesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [DVMNewsApiClient fetchTopHeadlinesWithBlock:^(NSArray<DVMNews *> * _Nullable articles) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.articles = articles;
//            [[self tableView] reloadData];
//        });
//    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeadlineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headlineCell" forIndexPath:indexPath];
    DVMNews *news = self.articles[indexPath.row];
    cell.news = news;
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual: @"toDetailVC"]){
        NewDetailViewController *destinationVC = [segue destinationViewController];
        NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
        DVMNews *news = self.articles[indexPath.row];
        HeadlineTableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
        UIImage *photo = [[selectedCell newsImageView] image];
        destinationVC.photo = photo;
        destinationVC.news = news;
    }
}

@end
