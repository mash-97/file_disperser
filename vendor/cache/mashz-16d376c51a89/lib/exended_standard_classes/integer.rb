class Integer
	@@factorial_hash = Hash.new do
		|hself, key|
		hself[key] = (key==0 ? 1 : (Math::gamma(key).floor)*key)
	end

	def facto
		return @@factorial_hash[self]
	end

	def factorial
		(1..self).inject{|x,y| x*y}
	end

	def positify
		return self.positive? ? self : self*(-1)
	end


	def bits
		number = self
		bits = ""
		if(self==0) then return '0' end
		until number==0 do
			bits << (number&1).to_s
			number >>=1
		end
		return bits.reverse
	end

	alias :positified :positify
end

