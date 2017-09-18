//
//  EXILoginViewController.h
//  Dashboard
//
//  Created by Swapnil Jain on 7/30/13.
//

#import <UIKit/UIKit.h>
#import "EXIMainViewController.h"

@protocol LoginDelegate <NSObject>

@required
-(void)passwordMatchesWithString:(NSString*)passcode;
@optional
-(void)passwordDoesNotMatchWithString:(NSString*)passcode;

@end

enum passwordState{
    eNew = 0,
    eVerify = 1,
    eSet = 2
};

@interface EXILoginViewController : UIViewController<UITextFieldDelegate>{
    EXIMainViewController *mMainViewController;
}

@property (strong, nonatomic) IBOutlet UITextField *firstField;
@property (strong, nonatomic) IBOutlet UITextField *secondField;
@property (strong, nonatomic) IBOutlet UITextField *thirdField;
@property (strong, nonatomic) IBOutlet UITextField *fourthField;
@property (strong, nonatomic) IBOutlet UILabel *passcodeLabel;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@property (assign, nonatomic) enum passwordState ePasswordState;
@property (strong, nonatomic) NSString *passcodeToVerify;

-(void)updateLabelsForString:(NSString*)string;
-(void)clearTextFields;

-(void)resetLoginPage;
-(void)setPageText;

@property (nonatomic, strong) NSString *passcodeToMatch;
@property (nonatomic, assign) id<LoginDelegate> delegate;

@end
