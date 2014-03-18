//
//  Contacts.h
//  CoreData
//
//  Created by Tony Cerrato on 3/18/14.
//  Copyright (c) 2014 Tony Cerrato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contacts : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;

@end
