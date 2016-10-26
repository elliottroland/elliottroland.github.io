# A mermaid plugin: https://github.com/knsv/mermaid
# A combination of the advice here: http://knsv.github.io/mermaid/#simple-usage-on-a-web-page
# And the jekyll-mermaid plugin: https://github.com/jasonbellamy/jekyll-mermaid/blob/master/lib/jekyll-mermaid.rb
module Jekyll
  class Mermaid < Liquid::Block
    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      @config = context.registers[:site].config['mermaid']
      "<div class=\"mermaid\">#{super}</div>"
    end
  end
end

Liquid::Template.register_tag('mermaid', Jekyll::Mermaid)
