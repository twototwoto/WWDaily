//
//  WWButtonTableViewController.m
//  WWDaily
//
//  Created by wangyongwang on 2018/7/31.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import "WWButtonTableViewController.h"
#import "WWButtonDetailViewController.h"

static NSString* const kButtonTableViewCellReuseIDString = @"kButtonTableViewCellReuseIDString";

@interface WWButtonTableViewController ()

/**TableView数据数组*/
@property (nonatomic,copy) NSArray *titleArray;

@end

@implementation WWButtonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self setupUI];
}

- (void)prepareData{
    self.titleArray = @[@"UIButton基础使用",@"UIButton ContentMode",@"UIButton 多个状态点击",@"UIButton 动画",@"UIButton 扩大点击区域",@"UIButton 图片文字排列",@"UIButton image缓存",@"UIButton 自己实现"];
    /**
     * 文章名字可以叫做 玩转 UIButton UIButton常见问题
     * Button 基础使用联系生活 此处写上点击事件的调用先后顺序
     * Button ContentMode 联系图片的设计 选取 样式选取声音控制 状态控制 联系咖啡机
     * Button 多个状态点击 联系 电梯按钮
     * Button 动画
     * Button扩大点击区域 联系设计美感
     
     * Button 图片文字排列 联系设计美感
     * Buttom image 缓存联系省流量
     * Button 自己实现 实现定制
     */
    
    
//待补充    * Button 控制 不接受事件点击 直接事件向下传递hitTest之类的 又是否可以半边接受事件点击 半边不接受事件的点击 通过的其superView控制方式
    /**场景有
     * 设置button的设置图片的contentMode的问题
     * 控制UIButton的图片和文字的间距问题 比如说上下 左右排列问题
     * button的设置点击的多个状态的时候的问题 也可以写一些放置重复点击的问题
     * 关于button的点击位置的区域 扩大点击区域
     * 给按钮添加动画 变大 缩小 或者是旋转的动画 亦或是 添加一个图片 之后做旋转的动画
     * 控制button的image的问题 缓存相关问题
     * 关于自己实现一个UIButton的问题
     */
}

- (void)setupUI{
    self.title = @"WWButton";
    self.view.backgroundColor = [UIColor grayColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kButtonTableViewCellReuseIDString];
}

#pragma mark - Action
#pragma mark - push 到指定控制器
- (void)pushToViewControllerWithIndexPath:(NSIndexPath *)indexPath{
    WWButtonDetailViewController *buttonDetailVC = [WWButtonDetailViewController new];
    buttonDetailVC.buttonType = indexPath.row;
    [self.navigationController pushViewController:buttonDetailVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushToViewControllerWithIndexPath:indexPath];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kButtonTableViewCellReuseIDString forIndexPath:indexPath];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:32.f];
    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.f green:(arc4random() % 256)/255.f blue:(arc4random() % 256)/255.f alpha:1.f];
    
    return cell;
}


@end
