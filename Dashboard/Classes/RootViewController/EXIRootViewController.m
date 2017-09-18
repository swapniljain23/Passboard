//
//  EXIRootViewController.m
//  Dashboard
//
//  Created by Swapnil Jain on 8/21/14.

#import "EXIRootViewController.h"

@interface EXIRootViewController ()

@end

@implementation EXIRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Login Delegate

-(void)passwordMatchesWithString:(NSString *)passcode{
    NSLog(@"Match");
//    [mPasscodeViewController.view removeFromSuperview];
//    UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:kStoryboardIdentifier bundle:nil];
//    if(nil == mMainViewController){
//        mMainViewController = [stroyBoard instantiateViewControllerWithIdentifier:kMainViewController];
//    }
//    [self.navigationController pushViewController:mMainViewController animated:YES];
}

-(void)passwordDoesNotMatchWithString:(NSString *)passcode{
    NSLog(@"Doesn't Match");
}

@end
