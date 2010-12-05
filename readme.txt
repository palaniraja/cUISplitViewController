Custom UISplitViewController


I created this custom UISplitViewController as one of my iPad project required Split view for only one screen. The default UISplitViewController provided by Apple can only be added to UIWindow which means you can't use it with normal UINavigation based project with only one splitview screen.

You can add/remove UINavigationController and UISplitViewController from AppDelegate, but that doesn't help give you smooth pushtoviewcontroller animation or the default navigation stack in order to go forward and backward.

Refer images: portrait.png, landscape.png