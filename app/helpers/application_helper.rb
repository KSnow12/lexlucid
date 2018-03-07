module ApplicationHelper
  def active_page?(*controller_actions)
    controller_actions.each do |controller_action|
      con_name, act_name = controller_action.split("#")

      if con_name == controller_name && (!act_name || act_name == action_name)
        return true
      end
    end
    return false
  end
end
