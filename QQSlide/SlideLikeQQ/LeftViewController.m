//
//  LeftViewController.m
//  SlideLikeQQ
//
//  Created by UncleChar on 15/12/22.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "LeftViewController.h"
#import "FundamentalViewController.h"
#import "OtherViewController.h"
#import "HomeViewController.h"
#import "MainTabBarController.h"
#import "MyAppEngine.h"
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray  *titleListArray;

@property (nonatomic, strong) UIImageView  *avatarImageView;
@property (nonatomic, strong) NSLayoutConstraint *heightLayoutConstraintOfListTableView;
@property (nonatomic, strong) FundamentalViewController  *rootViewController;
@end

@implementation LeftViewController

//- (void)viewWillAppear:(BOOL)animated {
//
//    [super viewWillAppear:YES];
//    if (_listTableView) {
//        
//        [_listTableView reloadData];
//    }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor  = [UIColor redColor];
    
    _titleListArray = @[@"开通会员", @"QQ钱包", @"网上营业厅", @"个性装扮", @"我的收藏", @"我的相册", @"我的文件"];
    
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height / 2 - 154,200, _titleListArray.count * 44.0) style:UITableViewStylePlain];
    _listTableView.dataSource = self;
    _listTableView.delegate = self;
    [self.view addSubview:_listTableView];
//    _listTableView.tableFooterView
    _heightLayoutConstraintOfListTableView.constant = kScreenHeight < 500 ? kScreenHeight * (568 -221)/568 : 347;
    self.view.frame = CGRectMake(0, 0, 320 * 0.78, kScreenHeight);

    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _titleListArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentify = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _titleListArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    _rootViewController = [MyAppEngine sharedInstance].rootViewController;
    _rootViewController.homeViewController.titleOfController = _titleListArray[indexPath.row];
    [_rootViewController.homeViewController jumpToOtherController];
    
    _rootViewController.mainTabBarController.tabBar.hidden = YES;
    _rootViewController.mainTabBarController.selectedIndex = 0;
    [_rootViewController homeControllerAppear];
    
    
    
    

}




























/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
