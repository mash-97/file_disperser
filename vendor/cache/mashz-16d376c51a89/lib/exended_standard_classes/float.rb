
class Float
	def positify()
		return self.positive? ? self : self * (-1)
	end
	alias :positified :positify
end


