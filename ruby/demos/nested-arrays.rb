music_library = [
  ["Adele",
    ["19",
      ["Day Dreamer", "Best for Last"]
    ],
    ["21",
      ["Rolling in the Deep", "Rumor Has It"]
    ]
  ],
  ["Beyonce",
    ["4",
      ["1 + 1", "Countdown"]
    ],
    ["Beyonce",
      ["Haunted", "Pretty Hurts"]
    ]
  ]
]

music_library.each do |artist|
    artist.each do |artist_element|
        if artist_element.class != Array
            puts "Artist: #{artist_element}"
        else
            artist_element.each do |album_element|
               if album_element.class != Array
                    puts "Album title: #{album_element}"
               else
                   album_element.each do |song|
                        puts "Song title: #{song}"
                   end         
               end         
            end       
        end
    end    
end   