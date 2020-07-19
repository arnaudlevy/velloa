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
    @url = url.split('?').first
  end

  def title
    @title ||= metainspector.best_title
  end

  def image
    @image ||= metainspector.images.best
  end

  def text
    unless @text
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
    @text
  end

  def html
    @html ||= Nokogiri::HTML data
  rescue
    puts "Nokogiri error"
  end

  def data
    require 'open-uri'
    URI.open url
  rescue
    puts "Impossible to open #{url}"
  end

  def metainspector
    @metainspector ||= MetaInspector.new self.url
  end
end
