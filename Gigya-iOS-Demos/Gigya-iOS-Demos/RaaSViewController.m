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
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"DefaultMobile-RegistrationLogin" forKey:@"screenSet"];
    [Gigya showPluginDialogOver:self plugin:@"accounts.screenSet" parameters:params completionHandler:^(BOOL closedByUser, NSError *error) {
        if (!error) {
            // Login was successful
        }
        else {
            // Handle error
        }
    }];
}

@end
