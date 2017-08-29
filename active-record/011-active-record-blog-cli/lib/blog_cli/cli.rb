class BlogCLI::CLI
  attr_reader :last_input, :current_user

  def call
    puts 'Welcom to the Blog CLI!'
    self.login
    self.menu
  end

  def login
    puts 'Please enter your user name to login'
    @current_user = BlogCLI::Author.find_or_create_by(:name => self.user_input)
    puts "You are logged in as: #{self.current_user.name}" # current_user is an author instance
  end

  def menu
    puts 'What would you like to do?'
    puts '1. Write a post'
    self.main_menu_loop
  end

  def main_menu_loop
    while self.user_input != 'exit'
      case self.last_input.to_i
      when 1
        self.post_new
      else
        menu
        break
      end
    end
  end

  # instantiate a post
  def post_new
    params = {}
    puts 'Please enter the title of your new post:'
    params[:title] = self.user_input
    puts 'Please enter the content:'
    params[:content] = self.user_input
    post = BlogCLI::Post.new(params)
    post.save
  end

  def user_input
    @last_input = gets.strip
  end

end
