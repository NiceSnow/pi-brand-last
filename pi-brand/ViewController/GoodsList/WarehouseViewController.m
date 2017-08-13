//
//  WarehouseViewController.m
//  pi-brand
//
//  Created by shengtian on 2017/8/11.
//  Copyright © 2017年 shengtian. All rights reserved.
//

#import "WarehouseViewController.h"
#import "GoodDetailViewController.h"

@interface WarehouseViewController ()
@property(nonatomic,strong) UITableView* tableView;
@property (nonatomic, strong) UIView* footerView;

@property (nonatomic, strong) UIView* headerView;
@end

@implementation WarehouseViewController

-(void)btnPress:(UIButton*)btn{
    [HUDView showHUD:self];
    [[HTTPRequest instance]PostRequestWithURL:@"http://www.pi-brand.cn/index.php/home/api/CityGoodsList" Parameter:@{@"c_id":_c_id,
                                    @"s_id":[_dataArray[btn.tag] objectForKey:@"id"]
                                    } succeed:^(NSURLSessionDataTask *task, id responseObject) {
        BOOL succeed = [[responseObject objectForKey:@"status"]boolValue];
        if (succeed) {
            NSArray* dataArray = [responseObject objectForKey:@"data"];
            GoodDetailViewController* VC = [[GoodDetailViewController alloc]init];
            VC.dataArray = dataArray;
            [HUDView hiddenHUD];
            [self.navigationController pushViewController:VC animated:NO];
        }
    } failed:^(NSURLSessionDataTask *task, NSError *error) {
        
    } netWork:^(BOOL netWork) {
        
    }];
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
}

-(void)setC_id:(NSString *)c_id{
    _c_id = c_id;
}

-(void)leftPress{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"筛选";
    UIButton* leftBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    leftBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn2 setImage:[UIImage imageNamed:@"back"] forState:normal];
    [leftBtn2 addTarget:self action:@selector(leftPress) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn2];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 35)];
        UILabel* label = [UILabel new];
        label.text = @"分类";
        label.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        label.font = [UIFont systemFontOfSize:16];
        [_headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(8);
            make.left.offset(25);
            make.bottom.offset(8);
        }];
    }
    return _headerView;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 5;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.footerView;
        
        
    }
    return _tableView;
}

-(UIView *)footerView{
    NSInteger count = 0;
    CGFloat Width_Space = 15;
    CGFloat width = (screenWidth - Width_Space*4)/3;
        _footerView = [UIView new];
        _footerView.backgroundColor = [UIColor whiteColor];
        CGFloat height = width*39/118;
        for (int i = 0; i<_dataArray.count; i++) {
            NSInteger index = i % 3;
            NSInteger page = i / 3;
            CGFloat flt = i/3.0;
            count = ceilf(flt);
            UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(index * width + (index + 1)*Width_Space, page * height + ((page + 1) * Width_Space) , width, height)];
            btn.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
            NSString* title = [[_dataArray objectAtIndex:i]objectForKey:@"shelves_name"];
            [btn setTitle:title forState:normal];
            [btn setTitleColor:[[UIColor blackColor]colorWithAlphaComponent:0.7] forState:normal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [_footerView addSubview:btn];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        }
    _footerView.frame = CGRectMake(0, 0, screenWidth, (height+Width_Space)*count + Width_Space);
    return _footerView;
}

@end
