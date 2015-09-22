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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForCellAtIndexPath:indexPath];
}

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
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
}

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
    NSDictionary *data1 = @{@"icon":@"home_icon_1",@"name":@"ABC",@"content":@"ABCABCABCABCABC"};
    NSDictionary *data2 = @{@"icon":@"home_icon_2",@"name":@"XXX",@"content":@"XXXVXXXXXXXXXXXX"};
    NSDictionary *data3 = @{@"icon":@"home_icon_3",@"name":@"BBBAAA",@"content":@"BBBAAABBBAAABBBAAA"};
    
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
        make.edges.equalTo(self.view);
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
