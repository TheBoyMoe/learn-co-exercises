module ItemsHelper
  # helper methods found in the '/helpers' folder are scoped to the View.
  # thus not available to controllers or models
  # available in all of the views

  def li_class_for_item(item)
    "completed" if item.complete?
  end
end
