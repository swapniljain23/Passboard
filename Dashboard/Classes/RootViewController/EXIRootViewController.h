//
//  EXIRootViewController.h
//  Dashboard
//
//  Created by Swapnil Jain on 8/21/14.

#import <UIKit/UIKit.h>
#import "EXILoginViewController.h"

enum passcodeState{
    eCreatePasscode = 0,
    eConfirmPasscode,
    eVerifyPasscode,
};

@interface EXIRootViewController : UINavigationController <LoginDelegate>{

}

@end
