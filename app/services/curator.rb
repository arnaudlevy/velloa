class Curator
  attr_reader :url, :title, :text, :image

  BLACKLIST = [
    'head', 'script', 'style', 'iframe', 'nav', 'noscript', 'header', 'footer', 'aside',
    '.navigation', '.top-menu-container', '.navbar', '.navbar-header', '.breadcrumb',
    '#breadcrumbs', '[typeof="v:Breadcrumb"]', '.skip-link', '.search', '.search-form',
    '.categories', '.post-categories', '.datas', '.post-datas', '.twitter-media',
    '.instagram-media', '.widget', '.related-post-tags', '.social-list', '.top-scroll',
    '.comments', '.signature', '.publicite', '.footer', '.Footer', '.footer-copyright',
    '[itemprop*="author"]', '[style*="display:none;"]', '[style*="display:none"]',
    '[style*="display: none;"]', '[style*="display: none"]', '[aria-hidden="true"]'
  ]

  def initialize(url)
    @url = url
  end

  def title
    json_ld ? json_ld['headline']
            : metainspector.best_title
  end

  def image
    if json_ld
      if json_ld.has_key? 'image'
        image = json_ld['image']
        if image.is_a? Array
          return image.first
        else
          return image['url']
        end
      end
    end
    metainspector.images.best
  end

  def text
    unless @text
      if json_ld
        if json_ld.has_key? 'text'
          @text = json_ld['text']
        elsif json_ld.has_key? 'articleBody'
          @text = json_ld['articleBody']
        else
          @text = json_ld.to_s
        end
      else
        @text = ''
        h = html.dup
        BLACKLIST.each do |tag|
          h.css(tag).remove
        end
        nodes = h.css('p')
        nodes.xpath('//style').remove
        @text = nodes.to_html
        @text.gsub!('<br><br>', '<br>')
      end
    end
    @text
  end

  def html
    @html ||= Nokogiri::HTML data
  rescue
    puts "Nokogiri error"
  end

  def json_ld
    unless @json_ld
      begin
        data = html.css('[type="application/ld+json"]').first
        string = data.inner_text
        @json_ld = JSON.parse string
      rescue
        puts "JSON LD error"
      end
    end
    @json_ld
  end

  def data
    require 'open-uri'
    URI.open url
  rescue
    puts "Impossible to open #{url}"
  end

  def metainspector
    @metainspector ||= MetaInspector.new url
  rescue
    puts "MetaInspector error"
  end
end
