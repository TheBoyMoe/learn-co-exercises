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
    puts "2. List your posts"
    puts "3. List all posts"
    self.main_menu_loop
  end

  def main_menu_loop
    while self.user_input != 'exit'
      case self.last_input.to_i
      when 1
        self.post_new
        break
      when 2
        self.post_index
        break
      else
        menu
        break
      end
    end
  end

  # print all the posts of the current_user
  def post_index
    puts "--- Posts by you, #{current_user.name} ---"
    # How to print out each post by this user with an ID and a Title
    current_user.posts.each do |post|
      puts "#{post.id}. #{post.title}"
    end

    puts "Enter the Post ID you'd like to see or edit or go back to the main menu:"
    if user_input.to_i > 0
      post_show
    else
      menu
    end
  end

  def post_show
    puts "Loading Post #{last_input}..."
    # When we load this post, it 100% belongs to the current_user
    # begin
    #   post = current_user.posts.find(last_input)
    # SELECT * FROM posts WHERE id = ? AND author_id = ?
    # find_by returns nil if no match, find throws an exception
    if post = current_user.posts.find_by(:id => last_input)
      puts "--- #{post.id} --- #{post.title}"
      puts
      puts post.content
    else
      # trying to retrieve the post of another user (current_user.id != author_id of post)
      # rescue ActiveRecord::RecordNotFound
      puts "Can't find a post with ID #{last_input} for you..."
    end
    menu
  end

  # instantiate a post
  def post_new
    params = {}
    puts 'Please enter the title of your new post:'
    params[:title] = self.user_input
    puts 'Please enter the content:'
    params[:content] = self.user_input
    post = BlogCLI::Post.new(params)

    # 1. manually assign the current_user
    # post.author = self.current_user

    # 2. instantiate the post already asociated with the current_user
    post = self.current_user.posts.build(params)
    post.save # insert post
    puts "Saved post, id: #{post.id}"
    menu
  end

  def user_input
    @last_input = gets.strip
  end

end
