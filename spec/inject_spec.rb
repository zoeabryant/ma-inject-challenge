require 'inject.rb'

describe 'Inject' do

	let(:array) { Array.new }

	it 'is a method applicable to Arrays' do
		expect(array.respond_to?(:myinject)).to be true
	end

	it 'takes a parameter' do
		expect{ array.myinject('parameter') }
		# {} so to avoid error for not passing a block to yield, irrelevant for this test
	end

	it 'works without a parameter' do
		expect{ array.myinject }
	end

	xit 'takes a block' do
		expect { | block | array.myinject('parameter', &block) }.to yield_control
		# expect(injectarray).to yield_with_args
	end

	it 'if I pass it an array of numbers, I expect it to add them up' do
		mynumbers = [1,2,3,4,5]
		injectarray = mynumbers.myinject(0) { |a,b| a + b}
		expect(injectarray).to eq 15
	end

	it 'if I try that again without a parameter, I expect the same result' do
		mynumbers = [1,2,3,4,5]
		injectarray = mynumbers.myinject { |a,b| a + b}
		expect(injectarray).to eq 15
	end

	it 'if I pass it an array of numbers with a parameter, I expect it to add them up' do
		mynumbers = [1,2,3,4,5]
		injectarray = mynumbers.myinject(100) { |a,b| a + b}
		expect(injectarray).to eq 115
	end

end