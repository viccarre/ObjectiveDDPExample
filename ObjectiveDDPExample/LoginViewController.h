
//
//  Created by Victor Carreño on 7/10/14.
//  Copyright (c) 2014 Victor Carreño. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateAccountViewController.h"

@class MeteorClient;

@interface LoginViewController : UIViewController

@property (strong, nonatomic) MeteorClient *meteor;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *connectionStatusText;

- (IBAction)didTapLoginButton:(id)sender;

@end
