//
//  WebViewController.m
//  HARMAY_PI_BRAND
//
//  Created by Madodg on 2017/7/26.
//  Copyright © 2017年 Madodg. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong) UIWebView* webView;
@end

@implementation WebViewController

-(void)setLeftCount:(NSInteger)leftCount{
    UIButton* leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [leftBtn setImage:[UIImage imageNamed:@"icon_nav"] forState:normal];
    [leftBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIButton* leftBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    leftBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn2 setImage:[UIImage imageNamed:@"back"] forState:normal];
    [leftBtn2 addTarget:self action:@selector(leftPress) forControlEvents:UIControlEventTouchUpInside];
    
    if (leftCount == 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    }else{
        self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:leftBtn],[[UIBarButtonItem alloc]initWithCustomView:leftBtn2]];
    }
}

-(void)leftPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)search:(UIButton*)btn{

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择跳转的三方" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"内置浏览器", @"淘宝",@"天猫", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
            [[UIApplication sharedApplication]openURL:[_MYURL safeUrlString]];
        }
            break;
        case 1:
        {
            [[UIApplication sharedApplication]openURL:[[NSString stringWithFormat:@"taobao://%@",_MYURL] safeUrlString]];
        }
            break;
        case 2:
        {
            [[UIApplication sharedApplication]openURL:[[NSString stringWithFormat:@"tmall://%@",_MYURL] safeUrlString]];
        }
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
//        [[UIApplication sharedApplication] openURL:_MYURL];
    }else{
        
    }
}

-(void)setMYURL:(id)MYURL{
    _MYURL = MYURL;
    [HUDView showHUD:self];
    if ([MYURL isKindOfClass:[NSURL class]]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:MYURL]];
    }else{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:MYURL]]];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [HUDView hiddenHUD];
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIButton* leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [leftBtn setImage:[UIImage imageNamed:@"icon_nav"] forState:normal];
    [leftBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton* rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [rightBtn setImage:[UIImage imageNamed:@"diandian"] forState:normal];
    [rightBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    // Do any additional setup after loading the view.
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
