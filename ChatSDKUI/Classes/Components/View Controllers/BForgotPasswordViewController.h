//
//  BForgotPasswordViewController.h
//  ChatSDK-ChatUI
//
//  Created by Simon Smiley-Andrews on 19/12/17.
//

#import <UIKit/UIKit.h>

@interface BForgotPasswordViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField * resetEmailField;
@property (nonatomic, weak) IBOutlet UILabel * titleLabel;
@property (nonatomic, weak) IBOutlet UILabel * instructionsLabel;
@property (nonatomic, weak) IBOutlet UIButton * resetButton;

@end
