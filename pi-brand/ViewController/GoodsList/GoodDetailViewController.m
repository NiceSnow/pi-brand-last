//
//  GoodDetailViewController.m
//  pi-brand
//
//  Created by shengtian on 2017/8/11.
//  Copyright © 2017年 shengtian. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "advertisementTableViewCell.h"
#import "GoodsListView.h"

#define tableViewW screenWidth*5/7

@interface GoodDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    CGFloat width;
    CGFloat height;
}
@property(nonatomic,strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* AdArray;
@property (nonatomic, strong) GoodsListView* ListView;
@end

@implementation GoodDetailViewController

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    self.ListView.dataArray = _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [[HTTPRequest instance]PostRequestWithURL:@"http://www.pi-brand.cn/index.php/home/api/advert_list" Parameter:nil succeed:^(NSURLSessionDataTask *task, id responseObject) {
        BOOL succeed = [[responseObject objectForKey:@"status"]boolValue];
        if (succeed) {
            NSArray* data = [responseObject objectForKey:@"data"];
            width = [[responseObject objectForKey:@"width"] floatValue];
            height = [[responseObject objectForKey:@"height"] floatValue];
            _AdArray = data;
            [self.tableView reloadData];
        }
    } failed:^(NSURLSessionDataTask *task, NSError *error) {
        
    } netWork:^(BOOL netWork) {
        
    }];
    [self.view addSubview:self.ListView];
    [self.ListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.top.bottom.offset(0);
    }];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _AdArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return height/width*tableViewW;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    advertisementTableViewCell* cell = [advertisementTableViewCell createCellWithTableView:tableView];
    cell.imageString = [_AdArray[indexPath.row]objectForKey:@"img"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(screenWidth - tableViewW, 0, tableViewW, screenHeight) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 5;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

-(GoodsListView *)ListView{
    if (!_ListView) {
        _ListView = [GoodsListView new];
    }
    return _ListView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
