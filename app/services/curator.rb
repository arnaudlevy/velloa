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
    if json_ld.any?
      json_ld.each do |ld|
        return ld['headline'] if ld.has_key? 'headline'
      end
    end
    metainspector.best_title
  end

  def image
    @image = find_image
    @image = @image.gsub('http://', 'https://')
    @image
  end

  def text
    if json_ld.any?
      json_ld.each do |ld|
        next unless ld['@type'] == 'NewsArticle'
        return ld['text'] if ld.has_key? 'text'
        return ld['articleBody'] if ld.has_key? 'articleBody'
      end
    end
    text = ''
    h = html.dup
    BLACKLIST.each do |tag|
      h.css(tag).remove
    end
    nodes = h.css('p')
    nodes.xpath('//style').remove
    text = nodes.to_html
    text.gsub!('<br><br>', '<br>')
    text
  end

  protected

  def find_image
    if json_ld.any?
      json_ld.each do |ld|
        if ld.has_key? 'image'
          image = ld['image']
          return image.first if image.is_a? Array
          return image['url'] if image.is_a? Hash
        end
      end
    end
    metainspector.images.best
  end

  def html
    @html ||= Nokogiri::HTML data
  rescue
    puts "Nokogiri error"
  end

  def json_ld
    unless @json_ld
      @json_ld = []
      begin
        options = html.css('[type="application/ld+json"]')
        options.each do |option|
          string = option.inner_text
          hash = JSON.parse(string)
          @json_ld << hash
        end
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
