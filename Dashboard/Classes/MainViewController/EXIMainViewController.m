//
//  EXIMainViewController.m
//  Dashboard
//
//  Created by Swapnil Jain on 7/30/13.
//

#import "EXIMainViewController.h"

#import "EXIAppDelegate.h"

@interface EXIMainViewController ()

@end

@implementation EXIMainViewController

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

    self.mailComposer = [[MFMailComposeViewController alloc] init];

    // Add left bar button item
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(openActionSheet:)];
    [self.navigationItem setLeftBarButtonItem:leftBarButton];

    [self.navigationItem setHidesBackButton:YES];
    
    // Add right bar button item
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPasswords:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    // Set page title
    [self setTitle:@"Dashboard"];

    self.dataArray = [[NSMutableArray alloc] init];
    
    [self refreshData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SELECTOR

-(void)openActionSheet:(id)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Import/Export" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Import data from CSV",@"Export data to CSV", nil];
    [actionSheet showInView:self.view];
}

-(void)addPasswords:(id)sender{
    //NSLog(@"addPasswords");
    UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:kStoryboardIdentifier bundle:nil];
    self.addAccountViewController = [stroyBoard instantiateViewControllerWithIdentifier:@"AddAccountViewController"];
    [self.addAccountViewController setDelegate:self];

    //[self presentViewController:self.addAccountViewController animated:YES completion:nil];
    [self.navigationController pushViewController:self.addAccountViewController animated:YES];
}

#pragma mark - Table View DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.filteredDataArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.filteredDataArray objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionTitleArray objectAtIndex:section];
}

- (UIView *)tableView: (UITableView *)tableView viewForHeaderInSection: (NSInteger)section{
        return nil;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForHeaderInSection:(NSInteger)section{
    if([[self.filteredDataArray objectAtIndex:section] count]<= 0)
        return 0.0;
    return 20.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"PasswordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    EXIAccountModel *model = [[self.filteredDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    // Configure cell
    cell.textLabel.text = [model url];
    cell.detailTextLabel.text = [model login];

    return cell;
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)refreshData{

    NSMutableArray *tempDataArray = [[NSMutableArray alloc] init];
    
    EXIAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:kEntityIdentifier inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if ([objects count] == 0) {

    } else {
        for (NSManagedObject *match in objects) {
            EXIAccountModel *model = [[EXIAccountModel alloc] init];
            [model setItemId:[match valueForKey:kItemIdKey]];
            [model setUrl:[match valueForKey:kUrlKey]];
            [model setLogin:[match valueForKey:kLoginKey]];
            [model setPassword:[match valueForKey:kPasswordKey]];
            [model setCategory:[match valueForKey:kCategoryKey]];

            [tempDataArray addObject:model];
        }
    }

    [self prepareDataDictionaryForModelArray:tempDataArray];
    
    // Reload table view
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    EXIEditViewController *editViewController = (EXIEditViewController*)[segue destinationViewController];

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    EXIAccountModel *model = [[self.filteredDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [editViewController setModel:model];
    [editViewController setTitle:@"Info"];
    [editViewController setDelegate:self];
}

-(void)prepareDataDictionaryForModelArray:(NSArray*)array{

    self.dataArray = [[NSMutableArray alloc] init];
    self.sectionTitleArray = [[NSMutableArray alloc] init];
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"CategoryList" ofType:@"plist"];
    NSArray *categoryArray = [NSArray arrayWithContentsOfFile:filePath];

    for (NSString *category in categoryArray) {
        NSMutableArray *itemArray = [[NSMutableArray alloc] init];
        for (EXIAccountModel *model in array) {
            if([category isEqualToString:model.category]){
                [itemArray addObject:model];
                //[itemArray addObject:[EXIUtility modelToDictionary:model]];
            }
        }
        [self.dataArray addObject:itemArray];
        [self.sectionTitleArray addObject:category];
    }

    // Copy of the actual data array
    self.filteredDataArray = self.dataArray;

    // Clear search bar
    if(![self.searchBar.text isEqualToString:@""]){
        self.searchBar.text = @"";
    }
    [self.searchBar resignFirstResponder];
}

#pragma mark - Search Bar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    self.filteredDataArray = [[NSMutableArray alloc] init];

    // Clear filter/search
    if([searchText isEqualToString:@""]){
        self.filteredDataArray = self.dataArray;
        [self.tableView reloadData];
        return;
    }

    for (NSMutableArray *innerArr in self.dataArray) {
        NSArray *innerFilteredArray = nil;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.url contains[c] %@",searchText];
        innerFilteredArray = [innerArr filteredArrayUsingPredicate:predicate];
        [self.filteredDataArray addObject:innerFilteredArray];
    }
    [self.tableView reloadData];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    NSLog(@"searchBarCancelButtonClicked");
}


#pragma mark - Action Sheet Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case eImport:

            break;
        case eExport:{

            NSMutableString *csvString = [[NSMutableString alloc] init];
            NSString *separator = @", ";
            for (NSArray *innerArr in self.dataArray) {
                for(EXIAccountModel *model in innerArr){
                    [csvString appendString:model.url]; [csvString appendString:separator];
                    [csvString appendString:model.login]; [csvString appendString:separator];
                    [csvString appendString:model.password]; [csvString appendString:separator];
                    [csvString appendString:model.category]; [csvString appendString:separator];
                }
            }

            NSLog(@"Outout - %@",csvString);

            NSString *pathToFile = [[NSBundle mainBundle] pathForResource:@"Output" ofType:@"csv"];
            [csvString writeToFile:pathToFile atomically:YES encoding:NSUTF8StringEncoding error:nil];

            if ([MFMailComposeViewController canSendMail]) {

                self.mailComposer.mailComposeDelegate = self;
                [self.mailComposer setSubject:@"Dashboard data export in .csv format"];
                [self.mailComposer setMessageBody:@"1 file attached" isHTML:NO];
                NSData *fileData = [NSData dataWithContentsOfFile:pathToFile];
                [self.mailComposer addAttachmentData:fileData mimeType:@"text/csv" fileName:@"Output"];

                [self presentViewController:self.mailComposer animated:YES completion:nil];

            }else{
                NSLog(@"Unable to send mail !");
            }
        }
        break;
        default:
            break;
    }
}

#pragma mark - MFMailComposer Delegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
