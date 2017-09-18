//
//  EXIAddAccountViewController.m
//  Dashboard
//
//  Created by Swapnil Jain on 7/31/13.
//

#import "EXIAddAccountViewController.h"

#import "EXIAppDelegate.h"

@interface EXIAddAccountViewController ()

@end

@implementation EXIAddAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    if(nil != self.alertView)
        [self.alertView dismissWithClickedButtonIndex:-1 animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    // Add right bar button item to save the data
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveInfo:)];
    [self.navigationItem setRightBarButtonItem:barButtonItem];

    if(nil == self.model){
        self.model = [[EXIAccountModel alloc] initWithId:0 URL:@"" Login:@"" Password:@"" Category:@"None"];
        self.title = @"Add";
    }else{
        self.title = @"Update";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"LoginCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    // Configure cell
    switch (indexPath.row) {
        case eURLField:
            cell.textLabel.text = kUrlText;
            cell.detailTextLabel.text = self.model.url;
            break;
        case eLogin:
            cell.textLabel.text = kLoginText;
            cell.detailTextLabel.text = self.model.login;
            break;
        case ePassword:
            cell.textLabel.text = kPasswordText;
            if(![self.model.password isEqualToString:@""])
                cell.detailTextLabel.text = @"*****";
            else
                cell.detailTextLabel.text = @"";
            break;
        case eCategory:
            cell.textLabel.text = kCategoryText;
            cell.detailTextLabel.text = self.model.category;
            break;
        default:
            break;
    }

    return cell;
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:kStoryboardIdentifier bundle:nil];
    self.addTextViewController = [stroyBoard instantiateViewControllerWithIdentifier:@"AddTextViewController"];
    [self.addTextViewController setPageIdentifier:(enum pageType)indexPath.row];
    [self.addTextViewController setDelegate:self];
    [self.addTextViewController setDefaultText:[[self.tableView cellForRowAtIndexPath:indexPath] detailTextLabel].text];
    [self.navigationController pushViewController:self.addTextViewController animated:YES];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    EXIAddTextViewController *textViewController = (EXIAddTextViewController*)[segue destinationViewController];
//    [textViewController setPageIdentifier:<#(enum pageType)#>]
//}

#pragma mark - SELECTORs

-(void)saveInfo:(id)sender{

    EXIAppDelegate *appDelegate = (EXIAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    if([self.model.login isEqualToString:@""] || [self.model.url isEqualToString:@""]){
        self.alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"Please provide URL & Login details"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self.alertView show];
        return;
    }

    if(self.model.itemId!=nil){ // Update previous record
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:kEntityIdentifier inManagedObjectContext:context]];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(id = %d)",[self.model.itemId intValue]];
        [request setPredicate:pred];

        NSError *error;
        NSArray *objects = [context executeFetchRequest:request error:&error];

        if([objects count]==1){
            NSManagedObject *object = [objects objectAtIndex:0];
            [object setValue:self.model.url forKey:kUrlKey];
            [object setValue:self.model.login forKey:kLoginKey];
            [object setValue:self.model.password forKey:kPasswordKey];
            [object setValue:self.model.category forKey:kCategoryKey];
        }
        
    }else{  // Add new record

        NSEntityDescription *entityDesc = [NSEntityDescription entityForName:kEntityIdentifier inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDesc];
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request error:&error];

        NSNumber *count = [NSNumber numberWithInt:(int)([objects count]+1)];
        NSManagedObject *newAccount = [NSEntityDescription insertNewObjectForEntityForName:kEntityIdentifier inManagedObjectContext:context];
        [newAccount setValue:count forKey:kItemIdKey];
        [newAccount setValue:self.model.url forKey:kUrlKey];
        [newAccount setValue:self.model.login forKey:kLoginKey];
        [newAccount setValue:self.model.password forKey:kPasswordKey];
        [newAccount setValue:self.model.category forKey:kCategoryKey];
    }

    NSError *error;
    [context save:&error];

    [self.delegate refreshData];
    [self.navigationController popToViewController:(EXIMainViewController*)self.delegate animated:YES];
}

-(void)saveText:(NSString*)text ForIdentifier:(enum pageType)pageIdentifier{

    switch (pageIdentifier) {
        case eURLField:
            self.model.url = text;
            break;
        case eLogin:
            self.model.login = text;
            break;
        case ePassword:
            self.model.password = text;
            break;
        case eCategory:
            self.model.category = text;
            break;

        default:
            break;
    }
    [self.tableView reloadData];
}

@end
