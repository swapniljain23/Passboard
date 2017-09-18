//
//  EXIAddTextViewController.h
//  Dashboard
//
//  Created by Swapnil Jain on 7/31/13.
//

#import <UIKit/UIKit.h>

#import "FBEncryptorAES.h"
@class EXIAddAccountViewController;


@interface EXIAddTextViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) NSString *defaultText;
@property (nonatomic, assign) enum pageType pageIdentifier;
@property (nonatomic, assign) EXIAddAccountViewController *delegate;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSIndexPath *previousIndexPath;

@end
