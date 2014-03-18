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

@interface CoreDataTableViewController ()


// tony trying to load my list of core data objects here
@property NSMutableArray *tripItems;

//tony I added this to get managed context data
@property (nonatomic,strong)NSArray* fetchedContactsArray;




@end

@implementation CoreDataTableViewController



// Tony added this to unwind
- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    
    
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
    - (void)viewDidLoad
    {
        [super viewDidLoad];
        
        // Tony load my array here with core data
        CoreDataAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        
        // Fetching Records and saving it in "fetchedRecordsArray" object
        self.fetchedContactsArray = [appDelegate getAllPhoneBookRecords];
        
        // tony sandbox to try and get a managed object to load a string
        // this does get the data from the _fetchedContacsArray and can get values out of it but seems odd
        // research best way to do this
        NSManagedObject *matches = nil;
        matches = _fetchedContactsArray[0];
        NSString *name = [matches valueForKey:@"name"];
        NSString *address = [matches valueForKey:@"address"];
        NSString *phone = [matches valueForKey:@"phone"];
        
        NSLog(@"Name: %@", name);
        NSLog(@"Address : %@", address);
        NSLog(@"Phone: %@", phone);
        // end sandbox
        
        
        [self.tableView reloadData];
        
        
        
        
//        self.tripItems = [[NSMutableArray alloc] init]; // Array of trip items I want to get from core data
//        [self loadInitialData];
        
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
     return [self.tripItems count];

    
}


// tony this is where I am broken
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"ListPrototypeCell";
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
        TripItem *myTripItem = [self.tripItems objectAtIndex:indexPath.row];
    
        NSString *combine =   [myTripItem.name stringByAppendingString:myTripItem.address]; //tony hack to concatinate a string
    
    
        cell.textLabel.text = combine;
    
    
    // tony dont think I need completion state
//    if (myTripItem.completed) {
 //       cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    return cell;
    
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
