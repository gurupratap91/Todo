class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    #rootViewController = UIViewController.alloc.init
    #rootViewController.title = 'todo'
    #rootViewController.view.backgroundColor = UIColor.whiteColor
    #@navigationController = UINavigationController.alloc.initWithRootViewController(@list_controller)

    documents_path         = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
    puts documents_path
    NanoStore.shared_store = NanoStore.store(:file, documents_path + "/nano.db")

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    @window.rootViewController = ListController.new
    @window.rootViewController.wantsFullScreenLayout = true

    $root_controller = @window.rootViewController



    true
  end
end
