//
//  OnlineShop.m
//  Atapy3
//
//  Created by Nikolay on 18.03.16.
//  Copyright © 2016 Nikolay. All rights reserved.
//

#import "OnlineShop.h"
#import "Information.h"
#import "Book.h"
#import "Disc.h"

@interface OnlineShop ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)changeProduct:(id)sender;
@property (strong) NSMutableArray *books;
@property (strong) NSMutableArray *discs;
@end

@implementation OnlineShop

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
 
    NSFetchRequest *fetchRequestBook = [[NSFetchRequest alloc] initWithEntityName:@"Book"];
    NSFetchRequest *fetchRequestDisc = [[NSFetchRequest alloc] initWithEntityName:@"Disc"];

    
    switch(self.segmentControl.selectedSegmentIndex)
    {
        case 0:
             self.books = [[managedObjectContext executeFetchRequest:fetchRequestBook error:nil] mutableCopy];
            break;
        case 1:
            self.discs = [[managedObjectContext executeFetchRequest:fetchRequestDisc error:nil] mutableCopy];
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [context deleteObject:[self.books objectAtIndex:indexPath.row]];
        [context deleteObject:[self.discs objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if(![context save:&error]){
            NSLog(@"Не удалилось! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [self.books removeObjectAtIndex:indexPath.row];
        [self.discs removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger returnValue = 0;
    
        switch(self.segmentControl.selectedSegmentIndex)
        {
            case 0:
                returnValue = self.books.count;
                break;
            case 1:
                returnValue = self.discs.count;
                break;
            default:
                break;
        }
    
    return returnValue;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
    NSManagedObject *book = [self.books objectAtIndex:indexPath.row];
    NSManagedObject *disc  = [self.discs objectAtIndex:indexPath.row];
    
    switch(self.segmentControl.selectedSegmentIndex)
    {
        case 0:
            [cell.textLabel setText:[NSString stringWithFormat:@"%@ ",
                                     [book valueForKey:@"title"]]];
            [cell.detailTextLabel setText:[book valueForKey:@"category"]];
            break;
        case 1:
            [cell.textLabel setText:[NSString stringWithFormat:@"%@ ",
                                     [disc valueForKey:@"title"]]];
            [cell.detailTextLabel setText:[disc valueForKey:@"category"]];
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"UpdateDevice"]){
       
        NSManagedObject *selectedDevice = [self.books objectAtIndex:[[self.tableView indexPathForSelectedRow] row]]; 
        Information *infoViewController = segue.destinationViewController;
        infoViewController.book = selectedDevice;
        infoViewController.disc = selectedDevice;
        
    }}


- (IBAction)changeProduct:(id)sender {
    [self.tableView reloadData];
}
@end
