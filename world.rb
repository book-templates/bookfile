
package 'book-templates/world'


world adapter: 'sqlite3', database: './world.db'


book do |b|

  opts = {}

  b.page 'index', title: 'Contents',
                  id:    'index'   do |page|
    page.render_toc( opts )  ### fix: auto-include opts in render - how??
  end

  ### generate pages for countries
  # note: use same order as table of contents

  Continent.order(:id).each do |continent|
    continent.countries.order(:name).each do |country|

      puts "build country page #{country.key}..."
      path = country.to_path
      puts "path=#{path}"

      b.page path, title: "#{country.name} (#{country.code})",
                   id:    country.key do |page|
        page.render_country( country, opts )  ### fix: auto-include opts in render - how??
      end
    end
  end
end

