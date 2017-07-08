//
//  CL_WebView_VC.m
//  HyJoinCar
//
//  Created by ggx on 2016/12/9.
//  Copyright © 2016年 乐途拼车. All rights reserved.
//

#import "CL_WebView_VC.h"

@interface CL_WebView_VC ()<UIWebViewDelegate>
{
    __weak IBOutlet UIWebView *_webView;
    
}
@end

@implementation CL_WebView_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItemTitle = self.navigationTitle;
    
    
    
    [_webView loadRequest:[NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0f]];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //[LoadingView showLoading];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
   // [LoadingView stopLoading];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
   
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
