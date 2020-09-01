class String
	def vowels()
		self.scan(/[aeiouAEIOU]/)
	end

	def consonants()
		self.scan(/[^aeiouAEIOU\W\d]/)
	end

	def titleize()
		self.gsub(/(\A|\s)\w/){|letter| letter.upcase}
	end
end

