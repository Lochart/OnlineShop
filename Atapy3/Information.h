//
//  Information.h
//  Atapy3
//
//  Created by Nikolay on 18.03.16.
//  Copyright © 2016 Nikolay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Information : UIViewController<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *barcodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *costText;
@property (weak, nonatomic) IBOutlet UITextField *barcodeText;
@property (weak, nonatomic) IBOutlet UITextField *pageText;
@property (weak, nonatomic) IBOutlet UITextField *categoryText;
- (IBAction)save:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonSave;
@property (strong) NSManagedObjectModel *book;
@property (strong) NSManagedObjectModel *disc;

@end
