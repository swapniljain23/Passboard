//
//  EXIEditViewController.m
//  Dashboard
//
//  Created by Swapnil Jain on 8/23/13.
//

#import "EXIEditViewController.h"

@interface EXIEditViewController ()

@end

@implementation EXIEditViewController

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

    // Add right bar button item to save the data
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editInfo:)];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    if(nil!=self.alertView)
        [self.alertView dismissWithClickedButtonIndex:-1 animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"EditViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    // Configure cell
    switch (indexPath.section) {
        case eURLField:
            cell.textLabel.text = [self.model url];
            break;
        case eLogin:
            cell.textLabel.text = [self.model login];
            break;
        case ePassword:
            cell.textLabel.text = @"*****";
            break;
        case eCategory:
            cell.textLabel.text = [self.model category];
            break;
        default:
            break;
    }


    return cell;
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section ==  ePassword){
        NSString *decryptedText = [FBEncryptorAES decryptBase64String:[self.model password] keyString:@"somekey"];
         self.alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"The Password Is \n %@",decryptedText] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self.alertView show];
    }
}

#pragma mark - Selector

-(void)editInfo:(id)sender{
    if(self.addAccountViewController==nil){
        UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:kStoryboardIdentifier bundle:nil];
        self.addAccountViewController = [stroyBoard instantiateViewControllerWithIdentifier:@"AddAccountViewController"];
        [self.addAccountViewController setDelegate:self.delegate];
    }
    [self.addAccountViewController setModel:self.model];
    [self.addAccountViewController.tableView reloadData];
    [self.navigationController pushViewController:self.addAccountViewController animated:YES];
}

@end
