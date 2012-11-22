class Cabinet::Manager::RuleParameterInputController < Cabinet::ManagerController
  def index
    @rules = RuleParameterInput.all
  end
end
