//
//  DVMTwoTopicViewController.m
//  NewStream
//
//  Created by DevMountain on 11/2/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

#import "DVMTwoTopicViewController.h"
#import "DVMNewsApiClient.h"
#import "DVMHeadlinesTableViewController.h"

@interface DVMTwoTopicViewController ()

@property (weak, nonatomic) IBOutlet UITextField *topic1TextField;
@property (weak, nonatomic) IBOutlet UITextField *topicTwoTextField;

@property (nonatomic, readwrite) NSMutableArray<DVMNews *> *combinedArticles;

@end

@implementation DVMTwoTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)fetchBothSubjects
{
    self.combinedArticles = [NSMutableArray new];
    
    DVMHeadlinesTableViewController *newInstanceOfHeadlinesTableViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle] instantiateViewControllerWithIdentifier:@"newsTableViewController"];
    
    //Build the room
    dispatch_group_t group = dispatch_group_create();
    
    //Put one thing in the room
    dispatch_group_enter(group);
    
    [DVMNewsApiClient fetchAllNewsWithKeyword:self.topicTwoTextField.text andCompletion:^(NSArray<DVMNews *> * _Nullable articles) {
        
        [self.combinedArticles addObjectsFromArray:articles];
        
        //Take one thing out of the room
        dispatch_group_leave(group);
    }];
    
    //Put another one thing in the room
    dispatch_group_enter(group);
    
    [DVMNewsApiClient fetchAllNewsWithKeyword:self.topic1TextField.text andCompletion:^(NSArray<DVMNews *> * _Nullable articles) {
        [self.combinedArticles addObjectsFromArray:articles];
        
        newInstanceOfHeadlinesTableViewController.articles = self.combinedArticles;
        
        //take one thing out of the room
        dispatch_group_leave(group);
    }];
    [[self navigationController] pushViewController:newInstanceOfHeadlinesTableViewController animated:true];
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//
//    });
    [newInstanceOfHeadlinesTableViewController.tableView.refreshControl beginRefreshing];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [[newInstanceOfHeadlinesTableViewController tableView] reloadData];
        [newInstanceOfHeadlinesTableViewController.tableView.refreshControl endRefreshing];
    });
}

- (IBAction)searchTheNewsButtonTapped:(UIButton *)sender {
    if ([self.topic1TextField.text isEqual: @""] || [self.topicTwoTextField.text isEqual:@""]){
        return;
    }
    [self fetchBothSubjects];
}


@end
