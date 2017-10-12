class TechcrunchCli::CLI

  def call
    puts "Welcome to Techcrunch"
    list_stories
    menu
  end

  def list_stories
    stories = TechcrunchCli::Story.scrape_titles
    stories.each_with_index do |story, i|
      puts "#{i+1} #{story}"
    end
  end

  def menu
    input = ""
    while input != "exit"
      puts "What story do you want to read?"
      input = gets.strip

      stories = TechcrunchCli::Story.scrape_titles
      authors = TechcrunchCli::Story.scrape_authors
      summaries = TechcrunchCli::Story.scrape_summaries
      urls = TechcrunchCli::Story.scrape_urls


      if input.to_i-1 <= 10 # Why 10?
        story = stories[input.to_i-1]
        author = authors[input.to_i-1].split("\t").first.strip
        summary = summaries[input.to_i-1]
        url = urls[input.to_i-1]

        puts story
        puts
        puts "By: #{author}"
        puts "Summary: #{summary}"

        puts "Would you like to read more?"
        answer = gets.strip

        if ["Y", "YES"].include?(answer.upcase)
          # how do I get the content for this story?
          content = TechcrunchCli::Story.scrape_content(url)
          puts content
        end
      end
      puts "Would you like to exit or list again?"
      input = gets.strip
    end
  end
end
