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


//@interface phoneLocationViewController : UIViewController <CLLocationManagerDelegate> {




//@interface NSObject(Private)<CLLocationManagerDelegate>
//    @property (strong, nonatomic) CLLocationManager *locationManager;

//@end


@implementation CoreDataViewController

    // TONY adding these to store info for geocodeing.
    CLGeocoder *geocoder;
    CLPlacemark *placemark;


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
    [_locationManager setDelegate:self];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    geocoder = [[CLGeocoder alloc] init];
     [_locationManager startUpdatingLocation];
   
    
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
    
    
    // wait here for start updating location to get data  locationManager:didUpdateToLocation:fromLocation

    CLLocation *location = _locationManager.location;
    
    NSLog(@"%@", location); // Just logging delete
    
     _status.text = [NSString stringWithFormat: @"location=%@", location]; // Tony this formats a object into a string
    
    
  // _status.text = @"Contact location", *tony;
    
    float latitude = _locationManager.location.coordinate.latitude;
    float longitude = _locationManager.location.coordinate.longitude;
    
    NSLog(@"%.8f",latitude); // Just logging delete
    NSLog(@"%.8f",longitude); // Just logging delete
    
    

    ///// sandbox below
    
    
    // Reverse Geocoding.  This takes a location object and returns an address.  Works
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            _status.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
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
    [newContact setValue: _name.text forKey:@"name"];
    [newContact setValue: _address.text forKey:@"address"];
    [newContact setValue: _phone.text forKey:@"phone"];
    _name.text = @"";
    _address.text = @"";
    _phone.text = @"";
    NSError *error;
    [context save:&error];
    _status.text = @"Contact saved";
    
    [self.view endEditing:YES];  // Tony dismiss the keyboard after saving
    
}

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





@end
