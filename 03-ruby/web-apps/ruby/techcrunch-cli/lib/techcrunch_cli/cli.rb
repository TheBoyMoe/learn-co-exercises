class TechcrunchCli::CLI

  def call
    puts "Welcome to Techcrunch"
    TechcrunchCli::Scraper.new.scrape_articles
    self.list_stories
    self.menu
  end

  def list_stories
    TechcrunchCli::Story.all.each.with_index(1) do |story, i|
      puts "#{i} #{story.title}"
    end
  end

  def menu
    input = ""
    while input != "exit"
      puts "What story do you want to read?"
      input = gets.strip

      if input.to_i-1 <= TechcrunchCli::Story.all.size
        story = TechcrunchCli::Story.all[input.to_i - 1]
        puts '-----------------------------------------------------------------'
        puts "#{story.title}"
        puts
        puts "By: #{story.author.gsub("\t", '').gsub("\n", '').split(' by ')[1]}"
        puts "Summary: #{story.summary}"
        puts '-----------------------------------------------------------------'
        puts "Would you like to read more?"
        answer = gets.strip

        if ["Y", "YES"].include?(answer.upcase)
          # puts '-----------------------------------------------------------------'
          # puts story.content.gsub("\t", '').gsub("\n", '')
          # puts '----------------------------------------------------------------'
          story.open_in_browser
        end
      end
      puts "Would you like to exit or list again?"
      input = gets.strip
      if ['L', 'LIST'].include?(input.upcase)
        self.list_stories
      end
    end
  end
end
