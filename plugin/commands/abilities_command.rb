module AresMUSH
  module Faserip
    class AbilitiesCmd
      include CommandHandler
      
      def handle
        
        num_pages = 5
        
        case cmd.page
        when 1
          template = AbilityPageTemplate.new("/attributes.erb", 
              { attributes: Faserip.primary_attributes, num_pages: num_pages, page: cmd.page })
        when 2
          template = AbilityPageTemplate.new("/skills.erb", 
              { skills: Faserip.skills.sort_by { |a| a['linked_attr'] }, num_pages: num_pages, page: cmd.page })
        when 3
          template = AbilityPageTemplate.new("/powers.erb",
              { powers: Faserip.powers.sort_by { |a| a['name'] }, num_pages: num_pages, page: cmd.page } )
        when 4
          template = AbilityPageTemplate.new("/advantages.erb",
              { advantages: Faserip.advantages.sort_by { |a| a['name'] }, num_pages: num_pages, page: cmd.page } )
        when 5
          template = AbilityPageTemplate.new("/disadvantages.erb",
              { disadvantages: Faserip.disadvantages.sort_by { |a| a['name'] }, num_pages: num_pages, page: cmd.page } )
        else
          client.emit_failure t('pages.not_that_many_pages')
          return
        end
      
        client.emit template.render
      end
    end
  end
end
