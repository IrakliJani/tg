# -*- encoding: utf-8 -*-

module Tg
	class Tg
		def api_server
			"beta.translate.ge"
		end

		def api_uri text, language
			"/Main/Translate?text=#{URI.escape(text)}&lang=#{language}"
		end

		def translate text
			highlight = %w{noun verb adverb adjective}

			lang = text.ascii_only? ? :en : :ge;

			json_response = Net::HTTP.get_response(api_server, api_uri(text, lang)).body

			# weird unicode pair \xC2\xAD (some sort of hyphen) fix
			json_response.force_encoding 'utf-8'
			json_response.gsub!(/\xC2\xAD/i, '')

			parsed = JSON.parse json_response, :symbolize_names => true

			parsed.each do |data|
				word, text = data[:Word], data[:Text]
				text = text.gsub(/\s+/, ' ').strip

				text.gsub!(/(#{highlight.join('|')})/) { $1.color :blue    }
				text.gsub!(/({\p{Word}+})/)            { $1.color :magenta }
				text.gsub!(/(\[.+\])/)                 { $1.color :yellow  }

				puts word.capitalize.color :green
				text = text.split(/\d\) ?/).drop_while {|t| t == '' }
				text.map! {|t| t.split(/; ?/) }

				text.each_with_index do |g, i|
					print "#{i + 1}) "
					g.each {|t| puts t }
				end

				puts
			end
		end
	end
end