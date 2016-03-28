//
//  Information.m
//  Atapy3
//
//  Created by Nikolay on 18.03.16.
//  Copyright © 2016 Nikolay. All rights reserved.
//

#import "AppDelegate.h"
#import "Book.h"
#import "Disc.h"
#import "Information.h"


@interface Information ()
- (IBAction)SegmentCCD:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegmentControlCD;


@end

@implementation Information

-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
            if(self.book){
                self.titleText.hidden = YES;
                self.costText.hidden = YES;
                self.barcodeText.hidden = YES;
                self.pageText.hidden = YES;
                self.categoryText.hidden = YES;
                self.categoryLabel.hidden = YES;
                self.buttonSave.hidden = YES;
                self.SegmentControlCD.hidden = YES;
                self.pageLabel.hidden = NO;
                
                [self.titleLabel setText:[self.book valueForKey:@"title"]];
                [self.costLabel setText:[[self.book valueForKey:@"cost"] stringValue]];
                [self.barcodeLabel setText:[self.book valueForKey:@"barcode"]];
                [self.pageLabel setText:[[self.book valueForKey:@"page"] stringValue]];
                [self.categoryLabel setText:[self.book valueForKey:@"category"]];
            } else if(self.disc){
                self.titleText.hidden = YES;
                self.costText.hidden = YES;
                self.barcodeText.hidden = YES;
                self.pageText.hidden = YES;
                self.categoryText.hidden = YES;
                self.categoryLabel.hidden = YES;
                self.buttonSave.hidden = YES;
                self.SegmentControlCD.hidden = YES;
                self.pageLabel.hidden = YES;
                
                [self.titleLabel setText:[self.disc valueForKey:@"title"]];
                [self.costLabel setText:[[self.disc valueForKey:@"cost"] stringValue]];
                [self.barcodeLabel setText:[self.disc valueForKey:@"barcode"]];
                [self.pageLabel setText:[[self.disc valueForKey:@"page"] stringValue]];
                [self.categoryLabel setText:[self.disc valueForKey:@"category"]];
            }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)save:(id)sender {
    AppDelegate *appDelegate = [self appDelegate];
    NSManagedObjectContext *context = [self managedObjectContext];
    
    switch(self.SegmentControlCD.selectedSegmentIndex)
    {
        case 0:
            self.pageText.hidden = NO;
            self.pageLabel.hidden = NO;
            
            if(self.book){
                [self.book setValue:self.titleText.text forKey:@"title"];
                [self.book setValue:[NSNumber numberWithInteger:[self.costText.text integerValue]] forKey:@"cost"];
                [self.book setValue:self.barcodeText.text forKey:@"barcode"];
                [self.book setValue:[NSNumber numberWithInteger:[self.pageText.text integerValue]] forKey:@"page"];
                [self.book setValue:self.categoryText.text forKey:@"category"];
            }
            else {
                Book *newBook = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:context];
                [newBook setValue:self.titleText.text forKey:@"title"];
                [newBook setValue:[NSNumber numberWithInteger:[self.costText.text integerValue]] forKey:@"cost"];
                [newBook setValue:self.barcodeText.text forKey:@"barcode"];
                [newBook setValue:[NSNumber numberWithInteger:[self.pageText.text integerValue]] forKey:@"page"];
                [newBook setValue:self.categoryText.text forKey:@"category"];
            }
            break;
        case 1:
            self.pageText.hidden = YES;
            self.pageLabel.hidden = YES;
            
            if(self.disc){
                [self.disc setValue:self.titleText.text forKey:@"title"];
                [self.disc setValue:[NSNumber numberWithInteger:[self.costText.text integerValue]] forKey:@"cost"];
                [self.disc setValue:self.barcodeText.text forKey:@"barcode"];
                [self.disc setValue:self.categoryText.text forKey:@"category"];
            }
            else {
                Disc *newDisc = [NSEntityDescription insertNewObjectForEntityForName:@"Disc" inManagedObjectContext:context];
                [newDisc setValue:self.titleText.text forKey:@"title"];
                [newDisc setValue:[NSNumber numberWithInteger:[self.costText.text integerValue]] forKey:@"cost"];
                [newDisc setValue:self.barcodeText.text forKey:@"barcode"];
                [newDisc setValue:self.categoryText.text forKey:@"category"];
            }
            
            break;
        default:
            break;
    }

    
    [appDelegate saveContext];
    
    [self dismissViewControllerAnimated:YES completion:nil];

    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ура!" message:@"Успешно добавлено!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    }
}

-(AppDelegate *)appDelegate{
    return [[UIApplication sharedApplication]delegate];
}

- (IBAction)SegmentCCD:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    switch(self.SegmentControlCD.selectedSegmentIndex)
    {
        case 0:
                self.pageText.hidden = NO;
                self.pageLabel.hidden = NO;

            if(self.book){
                [self.book setValue:self.titleText.text forKey:@"title"];
                [self.book setValue:[NSNumber numberWithInteger:[self.costText.text integerValue]] forKey:@"cost"];
                [self.book setValue:self.barcodeText.text forKey:@"barcode"];
                [self.book setValue:[NSNumber numberWithInteger:[self.pageText.text integerValue]] forKey:@"page"];
                [self.book setValue:self.categoryText.text forKey:@"category"];
            }
            else {
                Book *newBook = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:context];
                [newBook setValue:self.titleText.text forKey:@"title"];
                [newBook setValue:[NSNumber numberWithInteger:[self.costText.text integerValue]] forKey:@"cost"];
                [newBook setValue:self.barcodeText.text forKey:@"barcode"];
                [newBook setValue:[NSNumber numberWithInteger:[self.pageText.text integerValue]] forKey:@"page"];
                [newBook setValue:self.categoryText.text forKey:@"category"];
            }
            break;
        case 1:
                self.pageText.hidden = YES;
                self.pageLabel.hidden = YES;
            
            if(self.disc){
                [self.disc setValue:self.titleText.text forKey:@"title"];
                [self.disc setValue:[NSNumber numberWithInteger:[self.costText.text integerValue]] forKey:@"cost"];
                [self.disc setValue:self.barcodeText.text forKey:@"barcode"];
                [self.disc setValue:self.categoryText.text forKey:@"category"];
            }
            else {
                Disc *newDisc = [NSEntityDescription insertNewObjectForEntityForName:@"Disc" inManagedObjectContext:context];
                [newDisc setValue:self.titleText.text forKey:@"title"];
                [newDisc setValue:[NSNumber numberWithInteger:[self.costText.text integerValue]] forKey:@"cost"];
                [newDisc setValue:self.barcodeText.text forKey:@"barcode"];
                [newDisc setValue:self.categoryText.text forKey:@"category"];
            }

            break;
        default:
            break;
    }

}
    
@end
