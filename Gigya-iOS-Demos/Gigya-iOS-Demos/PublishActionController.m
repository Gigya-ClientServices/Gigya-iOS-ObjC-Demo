//
//  PublishActionController.m
//  Gigya-iOS-Demos
//
//  Created by Jay Reardon & Giovanni Alvarez on 12/22/14.
//  Copyright (c) 2014 Gigya. All rights reserved.
//

#import "PublishActionController.h"
#import <GigyaSDK/Gigya.h>

@interface PublishActionController ()

@property (weak, nonatomic) IBOutlet UITextView *shareText;

@end

@implementation PublishActionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)publishButtonAction:(id)sender {
    
    if (![Gigya session]) {
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                           message:@"You must be logged in to do that!"
                                          delegate:nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
    } else {
        if ([[[Gigya session] lastLoginProvider] isEqual: @"facebook"]) {
            [Gigya requestNewFacebookPublishPermissions:@"publish_actions"
                                        responseHandler:^(BOOL granted, NSError *error, NSArray *declinedPermissions) {
                                            if (!granted) {
                                                UIAlertView *alert;
                                                // Handle error
                                                alert = [[UIAlertView alloc] initWithTitle:@"Gigya Publish User Action"
                                                                                   message:error.description
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil
                                                         ];
                                                [alert show];
                                                return;
                                            }
                                        }
             ];
        }
        
        NSMutableDictionary *userAction = [NSMutableDictionary dictionary];
        [userAction setObject:@"Gigya iOS SDK Demos" forKey:@"title"];
        [userAction setObject:self.shareText.text forKey:@"description"];
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userAction
                                                           options:0
                                                             error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        GSRequest *request = [GSRequest requestForMethod:@"socialize.publishUserAction"];
        [request.parameters setObject:jsonString forKey:@"userAction"];
        [request sendWithResponseHandler:^(GSResponse *response, NSError *error) {
            if (!error) {
                NSLog(@"Success");
                // Success! Use the response object.
            }
            else {
                NSLog(@"error");
                // Check the error code according to the GSErrorCode enum, and handle it.
            }
        }];
    }
}

@end
