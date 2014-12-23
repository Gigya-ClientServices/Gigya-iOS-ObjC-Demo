//
//  RaaSViewController.m
//  Gigya-iOS-Demos
//
//  Created by Jay Reardon on 12/22/14.
//  Copyright (c) 2014 Gigya. All rights reserved.
//

#import "RaaSViewController.h"

@interface RaaSViewController ()

@end

@implementation RaaSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showScreenSet:(id)sender {
    NSNumber *navBarHeight = [NSNumber numberWithFloat:self.navigationController.navigationBar.frame.size.height];
    NSNumber *statBarHeight = [NSNumber numberWithFloat:[UIApplication sharedApplication].statusBarFrame.size.height];
    NSNumber *topOffset = [NSNumber numberWithFloat:([navBarHeight floatValue] + [statBarHeight floatValue])];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    GSPluginView *pluginView = [[GSPluginView alloc] initWithFrame:CGRectMake(0,
                                                                              [topOffset floatValue],
                                                                              [[UIScreen mainScreen] applicationFrame].size.width,
                                                                              [[UIScreen mainScreen] applicationFrame].size.height)];
    pluginView.delegate = self;

    [params setObject:@"DefaultMobile-RegistrationLogin" forKey:@"screenSet"];
    [pluginView loadPlugin:@"accounts.screenSet" parameters:params];
    [self.view addSubview:pluginView];
}

@end
