//
//  EXIAddAccountViewController.h
//  Dashboard
//
//  Created by Swapnil Jain on 7/31/13.
//

#import <UIKit/UIKit.h>

#import "EXIAppConstant.h"
#import "EXIAddTextViewController.h"
#import "EXIAccountModel.h"

@interface EXIAddAccountViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) EXIAddTextViewController *addTextViewController;
@property(nonatomic, weak) id<EXIMainViewProtocol> delegate;
@property(nonatomic, strong) EXIAccountModel *model;

@property(nonatomic, strong) UIAlertView *alertView;

-(void)saveText:(NSString*)text ForIdentifier:(enum pageType)pageIdentifier;

@end
