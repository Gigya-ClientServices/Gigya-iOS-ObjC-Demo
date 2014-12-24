//
//  CommentsViewController.m
//  Gigya-iOS-Demos
//
//  Created by Jay Reardon & Giovanni Alvarez on 12/22/14.
//  Copyright (c) 2014 Gigya. All rights reserved.
//

#import "CommentsViewController.h"
#import <GigyaSDK/Gigya.h>

@interface CommentsViewController () <GSPluginViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *commentsScrollView;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showCommentsAsDialog:(id)sender{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"Comments" forKey:@"categoryID"];
    [params setObject:@"Gigya-iOS-Demos" forKey:@"streamID"];

    [Gigya showPluginDialogOver:self plugin:@"comments.commentsUI" parameters:params completionHandler:^(BOOL closedByUser, NSError *error) {
        if (!error) {
            // Show Comments was successful
        }
        else {
            // Handle error
        }
    }];
}

- (IBAction)showCommentsAsSubView:(id)sender{
    NSNumber *statBarHeight = [NSNumber numberWithFloat:[UIApplication sharedApplication].statusBarFrame.size.height];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    GSPluginView *pluginView = [[GSPluginView alloc] initWithFrame:CGRectMake(0,
                                                                              [[UIScreen mainScreen] applicationFrame].size.height/2,
                                                                              [[UIScreen mainScreen] applicationFrame].size.width,
                                                                              ([[UIScreen mainScreen] applicationFrame].size.height/2) + [statBarHeight floatValue])];
    pluginView.delegate = self;
    
    [params setObject:@"Comments" forKey:@"categoryID"];
    [params setObject:@"Gigya-iOS-Demos" forKey:@"streamID"];
    [pluginView loadPlugin:@"comments.commentsUI" parameters:params];
    [self.view addSubview:pluginView];

}

@end
