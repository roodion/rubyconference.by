require 'mechanize'

class RubyConference
  class << self

    def by
      self
    end

    def schedule
      raw_schedule.map do |x|
        {
          when: x.at('span').text,
          title: x.at('h3').text.strip,
          presentor: x.at('a:last').text.strip
        }
      end
    end

    def print_schedule
      schedule.each do |row|
        if row[:presentor].empty?
          p "#{row[:when]} - #{row[:title]}"
        else
          p "#{row[:when]} - #{row[:title]} - #{row[:presentor]}"
        end
      end
      nil
    end

    protected

    def raw_schedule
      a = Mechanize.new
      p = a.get('http://rubyconference.by')
      p.parser.css('.program ul li')
    end

  end
end
