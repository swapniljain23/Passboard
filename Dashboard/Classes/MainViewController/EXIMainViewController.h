//
//  EXIMainViewController.h
//  Dashboard
//
//  Created by Swapnil Jain on 7/30/13.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "EXIAddAccountViewController.h"
#import "EXIEditViewController.h"
#import "EXIAccountModel.h"
#import "EXIUtility.h"

@interface EXIMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EXIMainViewProtocol,UISearchBarDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) EXIAddAccountViewController *addAccountViewController;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *sectionTitleArray;

@property (strong, nonatomic) NSMutableArray *filteredDataArray;

-(void)prepareDataDictionaryForModelArray:(NSArray*)array;

@property (nonatomic, strong) MFMailComposeViewController *mailComposer;

@end
