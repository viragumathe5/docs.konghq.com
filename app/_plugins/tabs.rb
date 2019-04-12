module Jekyll
  class Tabs < Liquid::Block

    Tab = Struct.new(:title, :attachment)

    attr_reader :tabs

    def initialize(tag_name, markup, options)
      super
      @tabs = []
    end

    def unknown_tag(tag, markup, tokens)
      @nodelist = []
      if 'tab'.freeze == tag
        @tabs << Tab.new(markup, @nodelist)
      else
        super
      end
    end

    def render(context)
      context.stack do
        tabs_content = @tabs.map do |tab|
          "**".freeze + tab.title.strip + "**\n\n".freeze +
          render_all(tab.attachment, context)
        end
        tabs_content.join("\n\n".freeze)
      end
    end
  end
end

Liquid::Template.register_tag('tabs'.freeze, Jekyll::Tabs)
