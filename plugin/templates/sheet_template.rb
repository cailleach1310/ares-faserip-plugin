module AresMUSH
  module Faserip
    class SheetTemplate < ErbTemplateRenderer
      
      attr_accessor :char, :client, :section
      
      def initialize(char, client, section = nul)
        @char = char
        @client = client
        @section = section
        super File.dirname(__FILE__) + "/sheet.erb"
      end
     
      def approval_status
        Chargen.approval_status(@char)
      end
      
      def attributes
       list = []
        @char.attributes.each_with_index do |a,i|
          list << format_attr(a,i)
        end
        list
      end

      def skills
       list = []
        @char.skills.each_with_index do |a,i|
          list << format_skill(a,i)
        end
        list
      end

      def powers
        list = []
        @char.powers.each do |m|
           list << format_power(m)
        end
        list
      end

      def advantages
        list = []
        @char.advantages.each do |m| 
           list << format_option(m)
        end
        list
      end
      
      def disadvantages
        list = []
        @char.disadvantages.each do |f|
          list << format_option(f)
        end
        list
      end
      
      def format_attr(a,i)
        linebreak = ((i+1) % 3 == 1) ? "%r" : ""
        name = "  %xh#{a.name}%xn "
        rank_short = " " + Faserip.get_rank_short(a.rank)
        dots = 30 - name.length
        "#{linebreak}#{name}#{rank_short.rjust(dots,".")}  "
      end

      def format_skill(a,i)
        linebreak = ((i+1) % 3 == 1) ? "%r" : ""
        name = "  %xh#{a.name}%xn "
        rank = " " + a.rank.to_s
        dots = 30 - name.length
       "#{linebreak}#{name}#{rank.rjust(dots,".")}  "
      end

      def format_power(a)
        return "  %xh#{a.name}%xn (#{Faserip.get_rank_name(a.rank)}): #{a.notes}%r"
      end

      def format_option(a)
        return "  %xh#{a.name}%xn (Rank #{a.rank}): #{a.notes}%r"
      end

      def section_line(title)
        @client.screen_reader ? title : line_with_text(title)
      end

    end
  end
end
