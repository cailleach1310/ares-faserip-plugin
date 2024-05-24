module AresMUSH
  module Faserip
    class AbilitiesRequestHandler
      def handle(request)
        attributes = Faserip.primary_attributes.map { |a| { 
          name: a['name'].titleize,
          desc: a['desc']
        } }

        skills = Faserip.skills.map { |a| {
          name: a['name'].titleize,
          desc: a['desc']
        }}

        advantages = Faserip.advantages.sort_by { |a| a['name'] }.map { |a| {
          name: a['name'].titleize,
          desc: a['desc'],
        }}

        disadvantages = Faserip.disadvantages.sort_by { |a| a['name'] }.map { |a| {
          name: a['name'].titleize,
          desc: a['desc'],
        }}

        powers = Faserip.powers.sort_by { |a| a['name'] }.map { |a| {
          name: a['name'].titleize,
          desc: a['desc'],
        }}
        
        {
          attrs_blurb: Website.format_markdown_for_html(Faserip.attributes_blurb),
          skills_blurb: Website.format_markdown_for_html(Faserip.skills_blurb),
          advantages_blurb: Website.format_markdown_for_html(Faserip.advantages_blurb),
          disadvantages_blurb: Website.format_markdown_for_html(Faserip.disadvantages_blurb),
          powers_blurb: Website.format_markdown_for_html(Faserip.powers_blurb),
          
          attributes: attributes,
          skills: skills,
          advantages: advantages,
          disadvantages: disadvantages,
          powers: powers
        } 
      end
    end
  end
end
