module InstagsHelper
  def choose_new_or_edit
    if action_name == "new" || action_name == "confirm"
      confirm_instags_path
    else action_name == "edit"
      instag_path
    end
  end
end
