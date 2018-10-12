//
//  WWHomeTableViewController.m
//  WWDaily
//
//  Created by wangyongwang on 2018/7/30.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import "WWHomeTableViewController.h"
#import "WWButtonTableViewController.h"
#import "WWRecurisveViewController.h"
#import "WWUIWebViewController.h"

static NSString* const kHomeCellReuseIDString = @"kHomeCellReuseIDString";

@interface WWHomeTableViewController ()

/**TableView 数据数组*/
@property (nonatomic,copy) NSArray *titleArray;
@end

@implementation WWHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self setupUI];
    
    [self nullSafe];
}

- (void)nullSafe{
    
//    NSDictionary *dict = @{@"a":[NSNull null]};
//    [[dict mutableCopy][@"a"]boolValue];
////    [dict[@"a"]boolValue];
    
}

- (void)prepareData{
    self.titleArray = @[@"UIButton", @"递归与尾递归", @"UIWebView常用功能"];
    
}

- (void)setupUI {
    self.title = @"首页";
}

#pragma mark - Action ----------------------
#pragma mark - push 到指定控制器
- (void)pushToViewControllerWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WWButtonTableViewController *buttonTableVC = [WWButtonTableViewController new];
            [self.navigationController pushViewController:buttonTableVC animated:YES];
        } else if(indexPath.row == 1) {
            WWRecurisveViewController *recurisveVC = [WWRecurisveViewController new];
            [self.navigationController pushViewController:recurisveVC animated:NO];
        } else if(indexPath.row == 2) {
            WWUIWebViewController *webVC = [WWUIWebViewController new];
            [self.navigationController pushViewController:webVC animated:NO];
        }
    }
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeCellReuseIDString forIndexPath:indexPath];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:24.f];
    cell.textLabel.numberOfLines = 0;
    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.f green:(arc4random() % 256)/255.f blue:(arc4random() % 256)/255.f alpha:1.f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushToViewControllerWithIndexPath:indexPath];
}


@end
