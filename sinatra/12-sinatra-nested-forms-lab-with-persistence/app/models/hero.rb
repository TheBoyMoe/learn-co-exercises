class Hero
  attr_reader :name, :power, :bio

  def initialize(params)
    @name  = params[:name]
    @power = params[:power]
    @bio = params[:bio]
  end
  
end
