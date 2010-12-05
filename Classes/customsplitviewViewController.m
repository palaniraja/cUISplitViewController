

#import "customsplitviewViewController.h"

#define LEFT_VIEW_WIDTH 320
#define LEFT_VIEW_HEIGHT 1004 

#define RIGHT_VIEW_WIDTH_LANDSCAPE 704
#define RIGHT_VIEW_HEIGHT_LANDSCAPE 1004 

#define RIGHT_VIEW_WIDTH_POTRAIT 768
#define RIGHT_VIEW_HEIGHT_POTRAIT 1004 

@implementation customsplitviewViewController

@synthesize popoverController,  detailToolbar;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//little tweak to use the detail background for main view
	
	self.view.backgroundColor = detail.backgroundColor;
	
	popOverButton = [[UIBarButtonItem alloc] initWithTitle:@"Master"
													 style:UIBarButtonItemStyleBordered
													target:self
													action:@selector(presentPopover:)];
	
}

- (void)viewWillAppear:(BOOL)animated{
	
	NSLog(@"willappear");
	UIInterfaceOrientation toInterfaceOrientation = [[UIDevice currentDevice] orientation];
	
	NSLog(@"viewdidload - orientation : %d", toInterfaceOrientation);
	
	
	
	if ((toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)) {
		[self reposLandscape];
	}else {
		[self reposPotrait];
	}
	
}

#pragma mark -
#pragma mark orientation

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
	
	NSLog(@"didrotate from Orientation %d", fromInterfaceOrientation);
	
	//NSLog(@"from-orientation %d hidden:%d frame:%@", fromInterfaceOrientation, master.hidden, NSStringFromCGRect(master.frame));
	
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{

	NSLog(@"willrotate to Orientation %d", toInterfaceOrientation);
	
	
	if ((toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)) {
		[self reposLandscape];
	}else {
		[self reposPotrait];
	}
	


}

#pragma mark -

-(void)reposLandscape{
	
	//NSLog(@"Going to reposition views for Landscape initial: %d", initial);
	
	if([popoverController isPopoverVisible]){
		NSLog(@"popover visible: going to clean");
		[popoverController dismissPopoverAnimated:YES];
	}
	
	CGRect frame = CGRectMake(0, 0, LEFT_VIEW_WIDTH, LEFT_VIEW_HEIGHT);
	master.frame = frame;
	[self.view addSubview:master];
	
	frame = CGRectMake(LEFT_VIEW_WIDTH, 0, RIGHT_VIEW_WIDTH_LANDSCAPE, RIGHT_VIEW_HEIGHT_LANDSCAPE);
	detail.frame = frame;
	
	//NSLog(@"original: %@", detailToolbar.items);
	
	NSMutableArray *buttons  = [[NSMutableArray alloc] init];
	
	[buttons addObjectsFromArray:detailToolbar.items];
	
	//remove popover button if exists
	if ([buttons objectAtIndex:0] == popOverButton ) {
		NSLog(@"0th button is popover so going to remove."); 
		
		[buttons removeObjectAtIndex:0];
		
		detailToolbar.items = buttons;

	}else {
		NSLog(@"0th button is not popover");
	}
	
	//NSLog(@"buttons after deleting master: %@", buttons);
	
	detailToolbar.items = buttons;
	[buttons release];
	
}
-(void)reposPotrait{
	
	NSLog(@"Going to reposition views for Potrait initial: ");
	[UIView beginAnimations:@"foo" context:nil];
	[UIView setAnimationDuration:0.4f];
	[master removeFromSuperview];
	[UIView commitAnimations];
	
	
	CGRect frame = CGRectMake(0, 0, RIGHT_VIEW_WIDTH_POTRAIT, RIGHT_VIEW_HEIGHT_POTRAIT);
	detail.frame = frame;
	
	//NSLog(@"original: %@", detailToolbar.items);
	
	NSMutableArray *buttons = [[NSMutableArray alloc] init];
	
	[buttons addObjectsFromArray:detailToolbar.items];
	
	/*
	
	NSLog(@"potrait. no. of buttons toolbar: %d", [detailToolbar.items count]);
	NSLog(@"potrait. no. of buttons array: %d", [buttons count]);
	
	//NSLog(@"buttons after adding master: %@", buttons);
	
	 */
	
	//remove popover button if exists
	
	if ([buttons objectAtIndex:0] != popOverButton ) {
		
		NSLog(@"0th button is not a popover so going to add."); 
		
		[buttons insertObject:popOverButton atIndex:0];
		
		detailToolbar.items = buttons;
		
		
		
	}
	
	
	[buttons release];
	
}


-(IBAction) tempAction{
		NSLog(@"I AM TEMP ");
	
}

#pragma mark -

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark  - 

-(void) togglePopOver{
	
	
	
}

-(IBAction) presentPopover:(id)sender{
	if([popoverController isPopoverVisible]){
		NSLog(@"popover visible: going to clean");
		[popoverController dismissPopoverAnimated:YES];
	}
	
	
	
	
	//build our custom popover view
	UIViewController* popoverContent = [[UIViewController alloc]
										init];
	
	
	popoverContent.view = master;
	
	//resize the popover view shown
	//in the current view to the view's size
	popoverContent.contentSizeForViewInPopover =
	CGSizeMake(320, 600);
	
	//create a popover controller
	popoverController = [[UIPopoverController alloc]
							  initWithContentViewController:popoverContent];
	
	//present the popover view non-modal with a
	//refrence to the toolbar button which was pressed
	[popoverController presentPopoverFromBarButtonItem:sender
								   permittedArrowDirections:UIPopoverArrowDirectionUp
												   animated:YES];
	
	//release the popover content
	
	[popoverContent release];
	
}



#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil)
    {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
    }
    
	cell.textLabel.text = [NSString stringWithFormat:@"My row %d", indexPath.row];
	
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Sec: %d, row %d selected", indexPath.section, indexPath.row);
	
}

-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	//NSLog(@"willbeginediting");
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
	return YES;
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
}


@end
