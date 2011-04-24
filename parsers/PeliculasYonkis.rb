module Parser

  module PeliculasYonkis
    require 'net/http'
    require 'uri'

    PLAYER_LINK = /http:\/\/www.peliculasyonkis\.com\/player\/visor_.*id=[%a-z0-9A-Z]*/
    DOWNLOAD_LINK = /http:\/\/www.peliculasyonkis\.com\/go\/d\/[0-9]*/
    TEMP_JS = 'temp.js'
    SCRIPTS = {
      "visor_stage6-aeno.php" => "aeno.js",
      "visor_pymeno2.php" => "geno2.js",
      "visor_gvideo.php" => "gvideo.js",
      "visor_manueno.php" => "manueno.js",
      "visor_svueno.php" => "svueno.js",
      "visor_veoh2.php" => "veoh2.js",
      "visor_zeno.php" => "zeno.js",
      "visor_pfflano.php" => "flano.js",
      "visor_pymeno5.php" => "geno5.js",
      "visor_pya.php" => "i.js",
      "visor_pyg.php" => "m.js",
      "visor_veno.php" => "veno.js",
      "visor_videoweed.php" => "videoweed.js"
    }

    def self.film_file(file, film_name = nil)
      f = File.new(file)
      online_links = []
      download_links = []
      categories = []
      year = nil
      desc = nil

      #flags para optimizar el procesado
      film_name_done = false
      cats_done = false
      year_done = false
      desc_done = false


      while line = f.gets

        if !film_name_done and film_name.nil? and line =~ /<ul><li>Nombre de la pelicula:/
          l = line.sub(/<ul><li>Nombre de la pelicula: <b>/, '')
          l = l.sub(/<\/b>\.<\/li>/, '')
          film_name = l.strip
          film_name_done = true
          next
        end

        if !desc_done and line =~ /Sinopsis de la película:/
          l = line.sub(/<li>Sinopsis de la película:<br \/><b>/, '')
          desc = l.sub(/<br \/>/, '')
          desc_done = true
          next
        end

        if !cats_done and line =~ /Categorías de la película: /
          l = line.sub(/<li>Categorías de la película: <b>/, '')
          l = l.sub(/<\/b>\.<\/li>/, '')
          categories = l.split(". ")
          cats_done = true
          next
        end

        if !year_done and line =~ /Año de estreno: /
          l = line.sub(/<li>Año de estreno: <b>/, '')
          year = l.sub(/<\/b>\.<\/li>/, '')
          year_done = true
          next
        end

        if line =~ /peliculasyonkis\.com\/player/ and !(line =~ /iframe/)
          online_links << line.scan(PLAYER_LINK)[0]
          next
        end

        if line =~ /peliculasyonkis\.com\/go/
          download_links << line.scan(DOWNLOAD_LINK)[0]
          next
        end

      end

      online_links.each{|l| online_link(l)}

      #save on database
      #film = Film.create(:name => film_name, :description => desc, :date => year)
    end

    def self.download_link(link)
    end

    def self.online_link(link)
      build_temp_js(link)
    end

    def self.build_temp_js(link)
      url = URI.parse(link)
      head = javascript_util_head(url)
      tail = javascript_util_tail


      require 'rubygems'
      require 'v8'
      require 'v8/cli'

      script = SCRIPTS[url.path.split("/")[2]]

      File.open(TEMP_JS, "w") do |w|
        w.puts head
        File.open(script, "r") do |io|
          while l = io.gets
            w.puts l
          end
        end
        w.puts tail
      end
      puts "---"
      puts url.path
      c = V8::Context.new(:with => V8::CLI::Shell.new)
      c.load(TEMP_JS)
    end

    def self.javascript_util_head(link)
      js_text = """
      function locclass() {
          this.search = '?" + link.query + "'; }
      location = new locclass();
           
      function docclass() {
          this.write = docwrite; }
      function docwrite(str) {
          print(str); }
      document = new docclass();
      """
    end

    def self.javascript_util_tail
      js_text = """
      sy1();
      """
    end

  end

end
