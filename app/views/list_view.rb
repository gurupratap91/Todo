class ListView < UIView

  attr_accessor :text_area, :task_list, :add_task_button
  self.text_area = self.text_field_view

  def initWithFrame frame
    super
    add_text_area
    add_task_list
  end

  def add_text_area
    text_field_view = UITextField.alloc.initWithFrame(CGRectMake(0,20,self.frame.size.width - 50, 40))
    text_field_view.delegate = self
    text_field_view.borderStyle = UITextBorderStyleRoundedRect

    text_field_view.textColor = UIColor.blackColor
    text_field_view.becomeFirstResponder

    text_field_view.placeholder = "new task"
    text_field_view.textAlignment = NSTextAlignmentLeft
    self.addSubview(text_field_view)

    #add button
    add_task_button = UIButton.buttonWithType UIButtonTypeCustom
    add_task_button.setFrame(CGRectMake(self.frame.size.width - 40,20,35,40))
    add_task_button.setTitleColor(UIColor.blackColor, forState: UIControlStateNormal)
    add_task_button.setTitle("Add", forState: UIControlStateNormal)
    add_task_button.addTarget(self,
                              action: :add_task,
                              forControlEvents: UIControlEventTouchUpInside)
    self.addSubview add_task_button
  end

  def add_task
    NSLog("Task Added")
    self.tasks << self.text_area.text
    self.task_list.reloadData
  end

  def add_task_list
    table_view = UITableView.alloc.initWithFrame(CGRectMake(0,70,self.frame.size.width, 200))
    table_view.dataSource = self
    table_view.delegate = self
    table_view.clipsToBounds = false
    self.addSubview table_view
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "cell"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    cell.textLabel.text = "#{self.tasks[indexPath.row]}"
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    10
  end
end