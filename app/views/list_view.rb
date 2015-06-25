class ListView < UIView

  attr_accessor :text_area, :task_list, :add_task_button, :tasks
  @text_area = @text_field_view
  #@tasks = []
  self.completed_tasks = Task.find(:completed, NSFEqualTo, 1).sort {|a, b| b.created_at <=> a.created_at }
  self.uncompleted_tasks = Task.find(:completed, NSFEqualTo, 0).sort {|a, b| b.created_at <=> a.created_at }

  def initWithFrame frame
    super
    self.tasks = Task.all.sort {|a,b| b.created_at <=> a.created_at}
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
    task = Task.create(:name => self.text_area.text, :created_at => Time.now)
    self.tasks.unshift(task)

    #self.tasks << self.text_area.text
    self.task_list.reloadData
    self.text_area.text = ""
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

    if indexPath.section == 0
      cell.textLabel.text = "#{self.uncompleted_tasks[indexPath.row].name}"
    elsif indexPath.section == 1
      cell.textLabel.text = "#{self.completed_tasks[indexPath.row].name}"
    end

    cell
  end

  def tableView(tableView, titleForHeaderInSection: section)
    if section == 1
      "completed"
    elsif section == 0
      "pending"
    end
  end

  def tableView(tableView, numberOfRowsInSection: section)
    if section == 0
      Task.find(:completed, NSFEqualTo, 0).count
      self.uncompleted_tasks.count
    elsif section == 1
      Task.find(:completed, NSFEqualTo, 1).count
    else
      0
    end
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    cell = tableView.cellForRowAtIndexPath(indexPath)
    self.mark_as_done(cell)
  end

  def mark_as_done cell
    task = Task.find(:name, NSFEqualTo, cell.textLabel.text).first
    task.completed = !task.completed
    task.save
    self.reload_table_sections
  end
end