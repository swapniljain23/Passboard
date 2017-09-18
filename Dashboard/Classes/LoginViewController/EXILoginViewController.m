//
//  EXILoginViewController.m
//  Dashboard
//
//  Created by Swapnil Jain on 7/30/13.
//

#import "EXILoginViewController.h"

@interface EXILoginViewController ()

@end

@implementation EXILoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.title = @"Dashboard";

    [self setPageText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //NSLog(@"textFieldDidBeginEditing : %@",textField.text);
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //NSLog(@"textFieldDidEndEditing : %@",textField.text);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //NSLog(@"shouldChangeCharactersInRange %@",newString);
    [self updateLabelsForString:newString];

    if(newString.length==4){
        return NO;
    }
    else
        return YES;
}

-(void)updateLabelsForString:(NSString*)string{

    [self.messageLabel setHidden:YES];

    for (int index=0; index<4; index++) {
        char ch = '\0';
        if(index<string.length)
            ch = [string characterAtIndex:index];
        switch (index) {
            case 0:
                self.firstField.text = [NSString stringWithFormat:@"%c",ch];
                break;
            case 1:
                self.secondField.text = [NSString stringWithFormat:@"%c",ch];
                break;
            case 2:
                self.thirdField.text = [NSString stringWithFormat:@"%c",ch];
                break;
            case 3:
                self.fourthField.text = [NSString stringWithFormat:@"%c",ch];
                break;

            default:
                break;
        }
    }
    if(string.length==4){

        UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:kStoryboardIdentifier bundle:nil];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults synchronize];
        NSString *password = [defaults stringForKey:@"password"];

        if(password==nil){      // Set new passcode

            if(self.ePasswordState==eVerify){
                if([string isEqualToString:self.passcodeToVerify]){

                    [defaults setValue:string forKey:@"password"];
                    [defaults synchronize];

                    if(nil == mMainViewController){
                        mMainViewController = [stroyBoard instantiateViewControllerWithIdentifier:kMainViewController];
                    }
                    [self.navigationController pushViewController:mMainViewController animated:YES];
                }else{
                    NSLog(@"Wrong Passcode");

                }
            }else if(self.ePasswordState==eNew){
                EXILoginViewController *login = [stroyBoard instantiateViewControllerWithIdentifier:kLoginViewController];
                [login setEPasswordState:eVerify];
                [login setPasscodeToVerify:string];
                [self.navigationController pushViewController:login animated:YES];
            }

        }else{     // Validating existing passcode

            if([string isEqualToString:password]){
                if(nil == mMainViewController){
                    mMainViewController = [stroyBoard instantiateViewControllerWithIdentifier:kMainViewController];
                }
                [self.navigationController pushViewController:mMainViewController animated:YES];
            }else{
                [self.messageLabel setHidden:NO];
                self.messageLabel.text = @"Ooops ! Wrong passcode entered :)";
                [self performSelector:@selector(clearTextFields) withObject:self afterDelay:0.1];
            }
        }
    }
}

-(void)clearTextFields{

    self.firstField.text = [NSString stringWithFormat:@"%c",'\0'];
    self.secondField.text = [NSString stringWithFormat:@"%c",'\0'];
    self.thirdField.text = [NSString stringWithFormat:@"%c",'\0'];
    self.fourthField.text = [NSString stringWithFormat:@"%c",'\0'];

    self.textField.text = [NSString stringWithFormat:@"%c",'\0'];
    [self.textField becomeFirstResponder];
}

-(void)resetLoginPage{
    [self clearTextFields];
}

-(void)setPageText{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    NSString *password = [defaults stringForKey:@"password"];
    if(password==nil){
        if(self.ePasswordState==eVerify){
            self.passcodeLabel.text = @"Verify Passcode";
            [self.navigationItem setHidesBackButton:YES];
        }else{
            self.passcodeLabel.text = @"Set Passcode";
            self.ePasswordState = eNew;
        }
    }else{
        self.passcodeLabel.text = @"Enter Passcode";
        self.ePasswordState = eSet;
    }
    [self.textField becomeFirstResponder];
}

@end
