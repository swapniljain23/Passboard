//
//  EXIEditViewController.h
//  Dashboard
//
//  Created by Swapnil Jain on 8/23/13.
//

#import <UIKit/UIKit.h>
#import "EXIAccountModel.h"
#import "EXIAppConstant.h"
#import "EXIAddAccountViewController.h"
#import "FBEncryptorAES.h"

@interface EXIEditViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) EXIAccountModel *model;
@property(nonatomic, strong) EXIAddAccountViewController *addAccountViewController;
@property(nonatomic, weak) id<EXIMainViewProtocol> delegate;

@property(nonatomic, strong) UIAlertView *alertView;

@end
