class RoomScraper
  attr_reader :doc, :url

  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(open(url))
  end

  def call
    # rows.map {|row| scrape_row(row)}
    self.rows.each do |row|
      # instantiate a Room instance and save to the database
      Room.create_from_hash(self.scrape_row(row))
    end
  end

  #private
    def rows
      @rows ||= self.doc.search('div.content ul.rows p.result-info')
    end

    def scrape_row(row)
      # scrape data from an individual row and return a hash
      {
        :date_created => row.search('time.result-date').attr('datetime').text,
        :title => row.search('a.result-title').text.gsub(/^\W*/, '').strip,
        :url => "#{self.url}#{row.search('a.result-title').attr('href')}",
        :price => row.search('span.result-price').text
      }
    end
end
