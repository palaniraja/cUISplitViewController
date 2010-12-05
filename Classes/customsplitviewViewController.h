

#import <UIKit/UIKit.h>


@interface customsplitviewViewController : UIViewController <UIPopoverControllerDelegate>{
	IBOutlet UIView *master, *detail;
	UIPopoverController *popoverController;

	UIBarButtonItem *popOverButton;
	IBOutlet UITableView *tvMasterList;
	IBOutlet UIToolbar *detailToolbar;
	NSMutableArray *toolBarButtons;
}

@property (nonatomic, retain) UIPopoverController *popoverController;
//@property (nonatomic, retain)  UIBarButtonItem *popOverButton;
@property (nonatomic, retain) IBOutlet UIToolbar *detailToolbar;


-(IBAction) presentPopover:(id)sender;
-(void) togglePopOver;
-(IBAction) tempAction;

-(void)reposLandscape;
-(void)reposPotrait;

@end

