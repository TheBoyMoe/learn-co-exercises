class BlogCLI::CLI

  def call
    puts 'Welcom to the Blog CLI!'
    self.menu
  end

  def menu
    puts 'What would you like to do?'
    puts '1. Write a post'
    self.main_menu_loop
  end

  def main_menu_loop
    while user_input != 'exit'
      case @last_input.to_i
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
    puts 'Please enter the title of your new post:'
    post = BlogCLI::Post.new
    post.title = self.user_input
    post.save
  end

  def user_input
    @last_input = gets.strip
  end

end
