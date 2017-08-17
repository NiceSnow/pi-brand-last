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
#import "SearchViewController.h"
#import "ADVICEView.h"

#define tableViewW (screenWidth )

@interface GoodDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,adviceDelegate>{
    CGFloat width;
    CGFloat height;
    UILabel* _rightBtn;
}
@property(nonatomic,strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* AdArray;
@property (nonatomic, strong) GoodsListView* ListView;
@property(nonatomic,assign) CGPoint startLocation;
@property(nonatomic,assign) CGPoint stopLocation;
@property(nonatomic,strong) UIButton* backBtn;
@property(nonatomic,strong) ADVICEView* ADView;
@end

@implementation GoodDetailViewController

-(void)returnIndex:(NSInteger)index;{
    NSString* string = [NSString stringWithFormat:@"%ld/%ld",index+1,_AdArray.count];
    NSArray* arr = [string componentsSeparatedByString:@"/"];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:UICOLOR_RGB_Alpha(0x959595, 1)
     
                          range:NSMakeRange(0, 1)];
    _rightBtn.attributedText = AttributedStr;
}

-(void)setC_id:(NSString *)c_id{
    _c_id = c_id;
}
-(void)setS_id:(NSString *)s_id{
    _s_id = s_id;
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    self.ListView.dataArray = _dataArray;
    [UIView transitionWithView:self.ListView duration:tableViewDuring options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.ListView.alpha = 1;
    } completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [HUDView showHUD:self];
    [[HTTPRequest instance]PostRequestWithURL:@"http://www.pi-brand.cn/index.php/home/api/advert_list" Parameter:@{@"c_id":_c_id,@"s_id":_s_id} succeed:^(NSURLSessionDataTask *task, id responseObject) {
        BOOL succeed = [[responseObject objectForKey:@"status"]boolValue];
        if (succeed) {
            NSArray* data = [responseObject objectForKey:@"data"];
            width = [[responseObject objectForKey:@"width"] floatValue];
            height = [[responseObject objectForKey:@"height"] floatValue];
            _AdArray = data;
            if (data.count>0) {
                self.ADView.dataArray = data;
                self.ADView.delegate = self;
                self.title = _AdArray[0][@"name"];
                [self.view addSubview:self.ADView];
                NSString* string = [NSString stringWithFormat:@"1/%ld",_AdArray.count];
                NSArray* arr = [string componentsSeparatedByString:@"/"];
                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:string];
                [AttributedStr addAttribute:NSForegroundColorAttributeName
                 
                                      value:UICOLOR_RGB_Alpha(0x959595, 1)
                 
                                      range:NSMakeRange(0, 1)];
                _rightBtn.attributedText = AttributedStr;
            }
            [HUDView hiddenHUD];
//            tianjia scrollView;
//            [self.tableView reloadData];
        }
    } failed:^(NSURLSessionDataTask *task, NSError *error) {
        
    } netWork:^(BOOL netWork) {
        
    }];
//    [self.view addSubview:self.ListView];
    
    UIPanGestureRecognizer * recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
    
//    UIButton* leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
//    [leftBtn setImage:[UIImage imageNamed:@"icon_nav"] forState:normal];
//    [leftBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIButton* leftBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    leftBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn2 setImage:[UIImage imageNamed:@"back"] forState:normal];
    [leftBtn2 addTarget:self action:@selector(leftPress) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn2];
//  @[[[UIBarButtonItem alloc]initWithCustomView:leftBtn],[[UIBarButtonItem alloc]initWithCustomView:leftBtn2]];
    
    
//    UIButton* rightBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
//    rightBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [rightBtn2 setImage:[UIImage imageNamed:@"icon_product"] forState:normal];
//    [rightBtn2 addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    UILabel* rightBtn = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, 35)];
    rightBtn.font = [UIFont systemFontOfSize:16];
    rightBtn.textColor = [UIColor blackColor];
    rightBtn.textAlignment = NSTextAlignmentCenter;
//    rightBtn.backgroundColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    _rightBtn = rightBtn;
//  @[[[UIBarButtonItem alloc]initWithCustomView:rightBtn],[[UIBarButtonItem alloc]initWithCustomView:rightBtn2]];
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.backBtn];
//    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.view);
//        make.right.offset(0);
//    }];
}

-(void)search{
    [self.navigationController pushViewController:[[SearchViewController alloc]init] animated:NO];
}

-(void)leftPress{
    [UIView transitionWithView:self.ListView duration:tableViewDuring options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.ListView.alpha = 0;
//        self.tableView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

- (void)handleSwipeFrom:(UIPanGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        _startLocation = [recognizer locationInView:self.view];
        
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        _stopLocation = [recognizer locationInView:self.view];
        CGFloat dx = _stopLocation.x - _startLocation.x;
        if(dx>85) {
            DebugLog(@"left");
            self.ListView.hiddenView = NO;
            self.backBtn.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.ListView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
            } completion:^(BOOL finished) {
//                self.tableView.alpha = 0;
            }];
//            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        if(dx<-85) {
            DebugLog(@"right");
            self.ListView.hiddenView = YES;
            self.backBtn.hidden = YES;
            [UIView animateWithDuration:0.3 animations:^{
                self.ListView.frame = CGRectMake(-tableViewW, 0, screenWidth, screenHeight);
            }];
//            self.tableView.alpha = 1;
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
        
    }
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, tableViewW, screenHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor blackColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 5;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.alpha = 0;
        _tableView.separatorStyle = 0;
        _tableView.bounces = NO;
        _tableView.pagingEnabled = YES;
    }
    return _tableView;
}
//-(BOOL)prefersStatusBarHidden
//
//{
//    
//    return YES;// 返回YES表示隐藏，返回NO表示显示
//    
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
//    CGFloat offset = scrollView.contentOffset.y/screenHeight;
//    NSInteger cell = ceilf(offset);
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:cell inSection:0]  atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(GoodsListView *)ListView{
    if (!_ListView) {
        _ListView = [[GoodsListView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        _ListView.alpha = 0;
    }
    return _ListView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton new];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"backShow"] forState:normal];
    }
    return _backBtn;
}

-(ADVICEView *)ADView{
    if (!_ADView) {
        _ADView = [[ADVICEView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight -64)];
    }
    return _ADView;
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
