//
//  ViewController.h
//  New_Relic_Challenge
//
//  Created by Enders, Eric on 10/6/17.
//  Copyright © 2017 Enders, Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tableView1;
    IBOutlet UITableView *tableView2;
}
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *list1LabelCount;
@property (strong, nonatomic) IBOutlet UILabel *list2LabelCount;
@property (strong, nonatomic) IBOutlet UIButton *removeButton;
@property (strong, nonatomic) IBOutlet UIButton *replaceButton;
@property (strong, nonatomic) IBOutlet UIButton *addBeforeButton;
@property (strong, nonatomic) IBOutlet UIButton *addAfterButton;
@property (strong, nonatomic) NSMutableArray *nr_mut_array_list1;
@property (strong, nonatomic) NSMutableArray *nr_mut_array_list2;
- (IBAction) clearList;
- (IBAction) addToList;
- (IBAction) removeRow;
- (IBAction) replaceRow;
- (IBAction) addBefore;
- (IBAction) addAfter;
- (IBAction) shuffleArray;
- (IBAction) sortArray;
- (IBAction) mergeLists;
@end

