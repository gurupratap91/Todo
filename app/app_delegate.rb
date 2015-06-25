class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    #rootViewController = UIViewController.alloc.init
    #rootViewController.title = 'todo'
    #rootViewController.view.backgroundColor = UIColor.whiteColor
    #@navigationController = UINavigationController.alloc.initWithRootViewController(@list_controller)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    @window.rootViewController = ListController.new
    @window.rootViewController.wantsFullScreenLayout = true

    $root_controller = @window.rootViewController

    true
  end
end
