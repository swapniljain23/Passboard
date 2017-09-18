//
//  EXIAddTextViewController.m
//  Dashboard
//
//  Created by Swapnil Jain on 7/31/13.
//

#import "EXIAddTextViewController.h"

#import "EXIAddAccountViewController.h"

@interface EXIAddTextViewController ()

@end

@implementation EXIAddTextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.previousIndexPath = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self.tableView setHidden:YES];

    // Add right bar button
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveInfo:)];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
    switch (self.pageIdentifier) {
        case eLogin:
            [self.textField setKeyboardType:UIKeyboardTypeEmailAddress];
            [self.textField becomeFirstResponder];
            self.title = kLoginText;
            break;
        case eURLField:
            [self.textField setKeyboardType:UIKeyboardTypeURL];
            [self.textField becomeFirstResponder];
            self.title = kUrlText;
            break;
        case ePassword:
            [self.textField setSecureTextEntry:YES];
            [self.textField becomeFirstResponder];
            self.title = kPasswordText;
            break;
        case eCategory:{
                [self.textField setHidden:YES];
                [self.tableView setHidden:NO];
                self.title = kCategoryText;
                NSString * filePath = [[NSBundle mainBundle] pathForResource:@"CategoryList" ofType:@"plist"];
                self.dataArray = [NSArray arrayWithContentsOfFile:filePath];
            }
            break;
        default:
            break;
    }
    self.textField.text = self.defaultText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SELECTORs

-(void)saveInfo:(id)sender{
    NSString *text = self.textField.text;
    if(self.pageIdentifier==ePassword && ![text isEqualToString:@""]){
        text = [FBEncryptorAES encryptBase64String:text keyString:@"somekey"separateLines:NO];
    }
    [self.delegate saveText:text ForIdentifier:self.pageIdentifier];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return (self.dataArray==nil)?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (self.dataArray==nil)?0:self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"CategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    // Configure cell
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];

    if([cell.textLabel.text isEqualToString:self.defaultText]){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        self.previousIndexPath = indexPath;
    }
    else
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    return cell;
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [[tableView cellForRowAtIndexPath:self.previousIndexPath] setAccessoryType:UITableViewCellAccessoryNone];
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    self.textField.text = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;

    self.previousIndexPath = indexPath;
}

@end
