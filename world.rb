
package 'book-templates/world'


world adapter: 'sqlite3', database: './world.db'
## will connect to database;
## will require all libs
## will include all models


puts "self.class.name (in top level): #{self.class.name}"

book do |b|
 
  puts "before first page"
  puts "self.class.name (in book block): #{self.class.name}"
 
  b.page 'index', title: 'Contents',
                  id:    'index'   do |p|
    puts "enter index"
    
    p.render_toc( {} )
    ## render :toc   -- auto includes opts???

    puts "self.class.name (in page block): #{self.class.name}"
    puts "leave index"
 end


  ### generate pages for countries
  # note: use same order as table of contents

  Continent.order(:id).each do |continent|
    continent.countries.order(:name).limit(1).each do |country|

      puts "build country page #{country.key}..."
      path = country.to_path
      puts "path=#{path}"
    
      b.page path, title: "#{country.name} (#{country.code})",
               id:    country.key do |p|
        p.write "render_country(#{country.name})"  ## render_country( country )  ## render_country( country, opts )
        p.render_country( country, {} )  ### fix: auto-include opts in render - how??
      end
    end
  end
end

