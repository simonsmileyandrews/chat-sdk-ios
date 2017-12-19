//
//  BForgotPasswordViewController.m
//  ChatSDK-ChatUI
//
//  Created by Simon Smiley-Andrews on 19/12/17.
//

#import "BForgotPasswordViewController.h"
#import <ChatSDK/ChatUI.h>
#import <ChatSDK/ChatCore.h>

@interface BForgotPasswordViewController ()

@end

@implementation BForgotPasswordViewController

@synthesize titleLabel;
@synthesize instructionsLabel;
@synthesize resetButton;

-(instancetype) init {
    self = [super initWithNibName:@"BForgotPasswordViewController" bundle:[NSBundle chatUIBundle]];
    if (self) {
        self.title = [NSBundle t:bResetPassword];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSBundle t: bBack] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    
    [resetButton setTitle:[NSBundle t:bResetPassword] forState:UIControlStateNormal];
    titleLabel.text = [NSBundle t:bCantSignInForgotYourPassword];
    instructionsLabel.text = [NSBundle t:bEnterYourEmailAddressToResetPassword];
}

- (IBAction)resetButtonPressed:(id)sender {

    // We want to check first that the email is an appropriate email address
    if ([self validateEmail:_resetEmailField.text]) {
        
        [NM.auth resetPasswordWithCredential:_resetEmailField.text].thenOnMain(^id(id success) {
            [self showResetWithSuccess:YES];
            return Nil;
        }, ^id(NSError * error) {
            [self showResetWithSuccess:NO];
            return Nil;
        });
    }
    else {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:[NSBundle t: bErrorTitle]
                                                                        message:[NSBundle t: bEmailError]
                                                                 preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okButton = [UIAlertAction actionWithTitle:[NSBundle t: bOk] style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)showResetWithSuccess: (BOOL)success {
    
    NSString * messageTitle = success ? [NSBundle t: bSuccess] : [NSBundle t: bErrorTitle];
    NSString * messageBody = success ? [NSBundle t: bPasswordResetSuccessfully] : [NSBundle t: bPasswordResetFailure];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:messageTitle
                                                                    message:messageBody
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * okButton = [UIAlertAction actionWithTitle:[NSBundle t:bOk]
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          
                                                          if (success) {
                                                              _resetEmailField.text = @"";
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }
                                }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)validateEmail: (NSString *)email {
    
    NSString * emailFormat = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}";
    NSPredicate * emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailFormat];
    return [emailPredicate evaluateWithObject:email];
}

- (void)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
