//
//  ViewController.m
//  RAYTableView
//
//  Created by 党磊 on 15/9/22.
//  Copyright (c) 2015年 党磊. All rights reserved.
//

#import "ViewController.h"
#import "RAYTableViewCell.h"
#import "Masonry.h"

static NSString * const RAYCellIndentifier = @"RAYCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *datas;

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    
//    [self.view addSubview:self.tableView];
    
    [self setupData];
    [self setupView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForCellAtIndexPath:indexPath];
}

/// - - - - - - - - - - - - 拿出一个cell用于计算，使用dispatch_once_t 保证只执行一次，方法
/// - - - - - - - - - - - - configureCell:atIndexPath:在数据源那块已经实现了，直接调用即可
- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    
    static RAYTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [self.tableView dequeueReusableCellWithIdentifier:RAYCellIndentifier];
    });
    [self configureCell:cell atIndexPath:indexPath];
    return [self calculateHeightForCell:cell];
}

- (CGFloat)calculateHeightForCell:(RAYTableViewCell *)cell {
    /// - - - - - - - - - - - - 让cell去布局子视图 setNeedsLayout  layoutIfNeeded
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    /// - - - - - - - - - - - - 调用 systemLayoutSizeFittingSize 让autolayout系统去计算大小，参数UILayoutFittingCompressedSize的意思是告诉autolayout系统使用尽可能小的尺寸以满足约束，返回的结果里 1.0f 是分割线的高度。
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
}
/// - - - - - - - - - - - - tableview就不会一次性调用完所有cell的高度，有些不在可见范围的cell是不需要一开始就知道高度的。当然estimatedHeightForRowAtIndexPath方法调用频率就会非常高，所以我们尽量返回一个比较接近实际结果的固定值以提高性能。
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112.0f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RAYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RAYCellIndentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(RAYTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row % 3;
    NSDictionary *data = self.datas[row];
    
    UIImage *image = [UIImage imageNamed:data[@"icon"]];
    [cell.customImageView setImage:image];
    
    [cell.title setText:data[@"name"]];
    
    [cell.subTitle setText:data[@"content"]];
}

#pragma mark - CustomDelegate
#pragma mark - Event Response
#pragma mark - Private Methods
- (void) setupData {
    NSDictionary *data1 = @{@"icon":@"home_icon_1",@"name":@"ABC",@"content":@"ABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABC"};
    NSDictionary *data2 = @{@"icon":@"home_icon_2",@"name":@"XXX",@"content":@"XXXVXXXXXXXXXXXXXXXVXXXXX"};
    NSDictionary *data3 = @{@"icon":@"home_icon_3",@"name":@"BBBAAA",@"content":@"BBBAAABBBAAABBBAAABBBAAABBBAAABBBAAABBBAAABBBAAAB"};
    
    self.datas = @[data1, data2, data3];
}

- (void) setupView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableView registerClass:[RAYTableViewCell class] forCellReuseIdentifier:RAYCellIndentifier];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);/// - ****************tableview 的大小等于self.view 的大小
    }];

}

#pragma mark - Public Methods
#pragma mark - Getters And Setters

//- (UITableView *)tableView {
//    if (_tableView == nil) {
//        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _tableView.backgroundColor = [UIColor redColor];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//    }
//    return _tableView;
//}

@end
