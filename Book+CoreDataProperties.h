//
//  Book+CoreDataProperties.h
//  Atapy3
//
//  Created by Nikolay on 18.03.16.
//  Copyright © 2016 Nikolay. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface Book (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *cost;
@property (nullable, nonatomic, retain) NSString *barcode;
@property (nullable, nonatomic, retain) NSNumber *page;
@property (nullable, nonatomic, retain) NSString *category;

@end

NS_ASSUME_NONNULL_END
