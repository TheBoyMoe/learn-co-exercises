class Team
  attr_reader :name, :motto

  def initialize(params)
    @name = params[:name]
    @motto = params[:motto]
  end
  
end
