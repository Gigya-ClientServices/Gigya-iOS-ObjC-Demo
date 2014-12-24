//
//  GSWebBridgeController.m
//  Gigya-iOS-Demos
//
//  Created by Jay Reardon & Giovanni Alvarez on 12/22/14.
//  Copyright (c) 2014 Gigya. All rights reserved.
//

#import "GSWebBridgeController.h"
#import <GigyaSDK/Gigya.h>

@interface GSWebBridgeController () <GSWebBridgeDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webBridgeWebView;

@end

@implementation GSWebBridgeController

- (void)loadView {
    [super loadView];
    [GSWebBridge registerWebView:_webBridgeWebView delegate:self];
    [_webBridgeWebView setDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the webbridge URL
    NSString *urlAddress = @"http://demos.gigya-cs.com/main_demo.html";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webBridgeWebView loadRequest:requestObj];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [GSWebBridge unregisterWebView:_webBridgeWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Web View Delegate functionality
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([GSWebBridge handleRequest:request webView:webView]) {
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
   [GSWebBridge webViewDidStartLoad:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // Report errors here
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"GSWebBridge"
                                       message:@"WebView Failed to load with an error"
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    [alert show];
}

@end
