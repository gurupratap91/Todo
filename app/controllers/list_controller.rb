
class ListController < UIViewController

  def viewDidLoad
    super
    self.title = "Todo"
    self.view.backgroundColor = UIColor.whiteColor
    list_view = ListView.alloc.initWithFrame(self.view.frame)
    self.view.addSubview(list_view)
    #add_text_area
    #add_task_list
  end

end