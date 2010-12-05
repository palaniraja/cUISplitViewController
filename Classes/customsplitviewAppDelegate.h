

#import <UIKit/UIKit.h>

@class customsplitviewViewController;

@interface customsplitviewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    customsplitviewViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet customsplitviewViewController *viewController;

@end

