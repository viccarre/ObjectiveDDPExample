//
//  CreateAccountViewController.m
//  Demo2ObjectiveDDP
//
//  Created by Victor Carreño on 7/16/14.
//  Copyright (c) 2014 Victor Carreño. All rights reserved.
//

#import "CreateAccountViewController.h"
#import <ObjectiveDDP/MeteorClient.h>
#import "MeteorClient.h"
#import "ObjectiveDDP.h"
#import <ObjectiveDDP/MeteorClient.h>

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.meteor addObserver:self
                  forKeyPath:@"websocketReady"
                     options:NSKeyValueObservingOptionNew
                     context:nil];
}

#pragma mark <NSKeyValueObserving>

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"websocketReady"] && self.meteor.websocketReady) {
        NSLog(@"Connected to Todo Server");
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createAccount:(id)sender{
    
    [self.meteor signupWithUsernameAndEmail:_username.text email:_email.text password:_password.text fullname:@"" responseCallback:^(NSDictionary *response, NSError *error) {
        if (error) {
            [self handleFailedAuth:error];
            return;
        }
        [self handleSuccessfulAuth];
    }];
    
}

#pragma mark - Meteor Hanldes

- (void)handleSuccessfulAuth {
    
    NSLog(@"Handle Succes");
    
}

- (void)handleFailedAuth:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"Meteor Todos" message:[error description] delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil] show];
}

@end
