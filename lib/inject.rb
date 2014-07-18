class Array

	def myinject(initial = nil)
		memory = initial || self.first

		self.delete(self.first) if memory == self.first

		self.each do |value|
			memory = yield(memory, value)
		end
		memory
	end

end