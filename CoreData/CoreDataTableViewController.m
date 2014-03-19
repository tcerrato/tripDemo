//
//  CoreDataTableViewController.m
//  CoreData
//
//  Created by Tony Cerrato on 3/15/14.
//  Copyright (c) 2014 Tony Cerrato. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "TripItem.h"
#import "CoreDataAppDelegate.h" // Tony I added this
#import "Contacts.h"

@interface CoreDataTableViewController ()


// tony trying to load my list of core data objects here
@property NSMutableArray *tripItems;

//tony I added this to get managed context data
@property (nonatomic,strong)NSArray* fetchedContactsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext; // Tony added




@end

@implementation CoreDataTableViewController



// Tony added this to unwind
- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{

    [self viewDidLoad]; //Tony This releads the page on inwind and shows all new data
    
}






- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}





// Tony this is me trying to load an array of items here to display in the list
- (void)viewDidLoad{
    [super viewDidLoad];
    CoreDataAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedContactsArray = [appDelegate getAllPhoneBookRecords];
    [self.tableView reloadData];
        
}





// Tony through away method to load fake data replace code here maybe with load from core data!!!!!!

- (void)loadInitialData {
    
    TripItem *item1 = [[TripItem alloc] init];
    item1.name = @"Buy milk";
    item1.address = @"cheese";
  //  item1.phone = @"Buy milk";
    
    [self.tripItems addObject:item1];
    
    TripItem *item2 = [[TripItem alloc] init];

    item2.name = @"item 2";
    item2.address = @"more item 2";
    //  item1.phone = @"Buy milk";
    
    [self.tripItems addObject:item2];

}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //return 0;
  
     // NSLog(@"tony is here", self.tripItems);
     return [self.fetchedContactsArray count];

    
}


// tony this is where I am broken
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Tony got this to not be red by creating a Contacts class for the data model
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Contacts * contacts = [self.fetchedContactsArray objectAtIndex:indexPath.row];
    
    //Tony returns core data all on 1 line
    //cell.textLabel.text = [NSString stringWithFormat:@"%@, %@, %@ ",contacts.name,contacts.address,contacts.phone];
    //cell.detailTextLabel.text = @"tony is here";  // Changed cell style to subtle and this writes to the second text line
    
    // Tony Drops phone number down to second line
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@ ",contacts.name,contacts.address];
    cell.detailTextLabel.text = contacts.phone;
    
    return cell;
    
    
}






/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TripItem *tappedItem = [self.tripItems objectAtIndex:indexPath.row];
   // tappedItem.completed = !tappedItem.completed;
   // [tableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationNone];
}



@end
