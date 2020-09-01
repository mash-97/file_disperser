
class Array

	$Array_strip_voids_desc =
<<DESC
\tArray@strip_voids()\n
\t--> strips voids (nil or free spaces)
\t--> returns an array by stripping nil or space elements
\t--> strip_voids!() uses O(n^2)
DESC

	def strip_voids()
		array = []
		self.each{|element| array << element if not element.to_s.strip.length==0}
		return array
	end

	def strip_voids!
		indx = 0
		while indx < self.length do
			if self[indx].to_s.strip.length == 0 then
				self.delete(self[indx])
			else
				indx += 1
			end
		end

		return self
	end
	
	def includes_all?(array)
		array.each{|element|
			return false if not self.include?(element)
		}
		return true
	end
	
	def includes_any?(array)
		array.each{|element|
			return true if self.include?(element)
		}
		return false
	end

	def nprint()
		(0...(self.length-1)).each{|indx| print("#{self[indx]} ")}
		puts(print(self[self.length-1]))
	end
	
	def relate_with_as_hash_value(array)
		self.map.with_index{|element, index| [element, array[index]]}.to_h()
	end

end

