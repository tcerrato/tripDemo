//
//  CoreDataViewController.m
//  CoreData
//
//  Created by Tony Cerrato on 3/15/14.
//  Copyright (c) 2014 Tony Cerrato. All rights reserved.
//


// Should these go in the .H file
#import "CoreDataViewController.h"
#import "CoreDataAppDelegate.h"



@implementation CoreDataViewController

    // TONY adding these to store info for geocodeing.
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
   // CLLocation *currentLocation;


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
    
    //tony new start up location services here
    _locationManager = [[CLLocationManager alloc] init];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/







// tony created a location button for now and linked it to this
// todo need an if location - null try again
//  This is null on first button push should enable locations on page load then just use it on button click
- (IBAction)getLocation:(id)sender {

   // start with do I have one yet and do I need one
    
    [_locationManager setDelegate:self];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    geocoder = [[CLGeocoder alloc] init]; // geo coding to get address
    
    [_locationManager startUpdatingLocation]; // start the update service

    
    

    
    
    
}





// This code should feed the location manager becuase it has been assigned a deligate
// this needs to return an object so the start and end buttons
// should return the placemark
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        _status.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        NSLog(@"longitude: %@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
        
        _status.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSLog(@"latitude: %@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
    }
    
    // Stop Location Manager
    [_locationManager stopUpdatingLocation];
    
    NSLog(@"Resolving the Address");
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            
            // tony this was _status label but I want this int he text box
            _startLocation.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                   placemark.subThoroughfare, placemark.thoroughfare,
                                   placemark.postalCode, placemark.locality,
                                   placemark.administrativeArea,
                                   placemark.country];
            
            //tony some debugging to see how placemark breaks down
            NSLog(@"%@", placemark.subThoroughfare); // address number
            NSLog(@"%@", placemark.thoroughfare); // address St
            NSLog(@"%@", placemark.postalCode); // zip
            NSLog(@"%@", placemark.locality); // city
            NSLog(@"%@", placemark.administrativeArea); // state
            NSLog(@"%@", placemark.country); // country
            
            NSLog(@" tony == %@", placemark.country); // country
          
            
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
    

}








- (IBAction)saveData:(id)sender {
    
    CoreDataAppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Contacts"
                  inManagedObjectContext:context];
//    [newContact setValue: _name.text forKey:@"name"];
//    [newContact setValue: _address.text forKey:@"address"];
//    [newContact setValue: _phone.text forKey:@"phone"];
//    _name.text = @"";
//    _address.text = @"";
//    _phone.text = @"";
    NSError *error;
    [context save:&error];
    _status.text = @"Contact saved";
    
    [self.view endEditing:YES];  // Tony dismiss the keyboard after saving
    
}


/*
- (IBAction)findContact:(id)sender {
    
    CoreDataAppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Contacts"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"(name = %@)",
     _name.text];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        _status.text = @"No matches";
    } else {
        matches = objects[0];
        _address.text = [matches valueForKey:@"address"];
        _phone.text = [matches valueForKey:@"phone"];
        _status.text = [NSString stringWithFormat:
                        @"%lu matches found", (unsigned long)[objects count]];
    }
    
    
    
}
*/



- (IBAction)endTrip:(id)sender {
    
    // start with do I have one yet and do I need one
    
    [_locationManager setDelegate:self];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    geocoder = [[CLGeocoder alloc] init]; // geo coding to get address
    [_locationManager startUpdatingLocation]; // start the update service
    
    
}





@end
