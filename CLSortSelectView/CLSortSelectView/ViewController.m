//
//  ViewController.m
//  CLSortSelectView
//
//  Created by Darren on 16/3/6.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "ViewController.h"
#import "CLMainSelectedView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    CLMainSelectedView *mainView = [CLMainSelectedView show];
    mainView.backgroundColor = [UIColor greenColor];
    mainView.leftMenuSubViewHeight = 50;
    mainView.middleMenuSubViewHeight = 50;
    mainView.rightMenuSubViewHeight = 50;
    mainView.leftMenuArrray = @[@"热门",@"经典"];
    mainView.middleMenuArray = @[@"定位",@"热门",@"上海",@"北京"];
    mainView.rightMenuArray = @[@"价格由低到高",@"价格由高到低",@"销量",@"好评"];
    mainView.frame = CGRectMake(0, 20, self.view.frame.size.width, 50);
    [self.view addSubview:mainView];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *const ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"123";
    return cell;
}

@end
