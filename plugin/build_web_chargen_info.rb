module AresMUSH
  module Faserip
    class WebChargenInfoBuilder

      def build()
        {
          attrs_blurb: Website.format_markdown_for_html(Faserip.attributes_blurb),
          skills_blurb: Website.format_markdown_for_html(Faserip.skills_blurb),
          advantages_blurb: Website.format_markdown_for_html(Faserip.advantages_blurb),
          disadvantages_blurb: Website.format_markdown_for_html(Faserip.disadvantages_blurb),
          powers_blurb: Website.format_markdown_for_html(Faserip.powers_blurb),

          attr_ranks: Faserip.attribute_ranks,
          skill_ranks: create_skill_ranks_list,
          skills: Faserip.skills,
          advantages: create_option_list("advantage"),
          disadvantages: create_option_list("disadvantage"),
          powers: create_option_list("powers")
        }
      end

      def create_skill_ranks_list()
         max = Global.read_config('faserip', 'max_skill_rank')
         return (0..max).to_a
      end

      def create_option_list(type)
         new_list = []
         case type
           when "advantage"
             list = Faserip.advantages
           when "disadvantage"
             list = Faserip.disadvantages
           when "powers"
             list = Faserip.powers
           else
             return nil
         end
         max = Global.read_config('faserip', 'max_advantage_rank')
         list.each do |m|
           option_ranks = (type != "power") ? (1..max).to_a : Faserip.attribute_ranks.map{ |r| r["short"] }
           new_list << { name: m["name"], desc: m["desc"], ranks: option_ranks }
         end
         return new_list
      end

    end
  end
end
