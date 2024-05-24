module AresMUSH
  module Faserip
    class AbilityPageTemplate < ErbTemplateRenderer


      attr_accessor :data
      
      def initialize(file, data)
        @data = data
        super File.dirname(__FILE__) + file
      end
      
      def page_footer
        footer = t('pages.page_x_of_y', :x => @data[:page], :y => @data[:num_pages])
        template = PageFooterTemplate.new(footer)
        template.render
      end
      
      def attr_blurb
        Faserip.attributes_blurb
      end
      
      def skills_blurb
        Faserip.skills_blurb
      end
      
      def advantages_blurb
        Faserip.advantages_blurb
      end
      
      def disadvantages_blurb
        Faserip.disadvantages_blurb
      end

      def powers_blurb
        Faserip.powers_blurb
      end

    end
  end
end
