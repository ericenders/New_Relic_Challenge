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
    IBOutlet UITableView *tableView;
    
}
 @property (strong, nonatomic) IBOutlet UITextField *textField;
 @property (strong, nonatomic) IBOutlet UILabel *labelCount;
@property (strong, nonatomic) NSMutableArray *nr_mut_array;
- (IBAction) clearList;
- (IBAction) addToList;
- (IBAction) removeRow;
- (IBAction) replaceRow;
- (IBAction) addBefore;
- (IBAction) addAfter;
- (IBAction) shuffleArray;
@end

