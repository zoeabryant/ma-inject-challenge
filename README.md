### Challenge 4 - Level 1
* Reopen the Array class or subclass it.
* Rewrite the inject method. Write a test for it first. Don't worry about returning an enumerator, assume a block is always given

Name your method differently (that is, not inject() or subclass Array) because rspec uses inject() internally, so the tests will fail with weird messages unless your implementation of inject is perfect.
If you would like a challenge, rewrite inject using two approaches: using iterators and using recursion but it’s not required to pass.


### Analysing inject
```
[1,2,3,4,5].inject() { |original, new| original * new} > 120
```
Runs a block against the array, like each...?

http://www.ruby-doc.org/core-2.1.2/Enumerable.html#method-i-inject

> **inject(initial, sym) → obj**

> **inject(sym) → obj**

> **inject(initial) { |memo, obj| block } → obj**

> **inject { |memo, obj| block } → obj**
>
> Combines all elements of enum by applying a binary operation, specified by a block or a symbol that names a method or operator.
>
> If you specify a block, then for each element in enum the block is passed an accumulator value (memo) and the element. If you specify a symbol instead, then each element in the collection will be passed to the named method of memo. In either case, the result becomes the new value for memo. At the end of the iteration, the final value of memo is the return value for the method.
>
> If you do not explicitly specify an initial value for memo, then the first element of collection is used as the initial value of memo.

**So it iterates through the passed array and performs a block on them. And has a starting point.**

### Anaylsing behaviour in pry / irb
```````
numbers = [1,2,3,4,5]

numbers.inject {|currentnum, nextnum| currentnum + nextnum }
=> 15

1+2+3+4+5
=> 15

numbers.inject(100) {|currentnum, nextnum| currentnum + nextnum }
=> 115

100+1+2+3+4+5
=> 115

numbers.inject {|current, nextnum| puts current + nextnum }
3
NoMethodError: undefined method `+' for nil:NilClass

numbers.inject {|current, nextnum| puts "#{nextnum} + #{nextnum} = #{nextnum + nextnum}" }
2 + 2 = 4
3 + 3 = 6
4 + 4 = 8
5 + 5 = 10

numbers.inject {|currentnum, nextnum| puts "#{currentnum} + #{currentnum} = #{currentnum + currentnum}" }
1 + 1 = 2
NoMethodError: undefined method `+' for nil:NilClass

numbers.inject {|initialnum, nextnum| initialnum + nextnum }
=> 15
# perhaps more accurate way of putting it?

(1+1)+(1+2)+(1+3)+(1+4)+(1+5)
=> 20
# hmmm.....

((((1+2)+3)+4)+5)
=> 15
# That makes more sense.

numbers.inject {|total, current| total + current }
=> 15

numbers.inject(100) {|total, current| total + current }
=> 115
# starts the total at 100

(((((100+1)+2)+3)+4)+5)
=> 115


```````

##Got it!
````
numbers.inject {|total, current| total + current }
=> 15

# is eq to

((((1+2)+3)+4)+5)
=> 15

# starts the total at 100

numbers.inject(100) {|total, current| total + current }
=> 115

# is eq to

(((((100+1)+2)+3)+4)+5)
=> 115

```
### Now with letters...

```
letters = ['A','a','B','b','C','c']
letters.inject('Alphabet: ') {|memo, current| memo + current }
=> "Alphabet: AaBbCc"

# so 'memo' here refers to keep track of what it is doing.
# otherwise...

letters.inject('Alphabet: ') {|memo, current| current }
=> "c"
```

### Spec
* it uses the parameter passed as the starting point
* if no parameter passed, it starts with the first element in array
* it works with parameters
* it works without parameters
* it stores the running total, the result of the block so far in the first argument passed
* it stores the current array val in the second argument passed
* it iterates through the entire array
* it iterates through the entire array running the passed block

* numbers.myinject(100) {|total, current| total + current } => 115
* letters.myinject('Alphabet: ') {|memo, current| memo + current } => "Alphabet: AaBbCc"

### Real use scenarios - as suggested by a senior maker :) cheers!
* Use it to add up a shopping cart total
* Use the passed parameter to add VAT or a delievery charge
