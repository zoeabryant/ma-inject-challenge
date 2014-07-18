This has since been debunked, see README for the understood version

### anaylsing behaviour in pry / irb
``````
numbers = [1,2,3,4,5]
letters = ['A','a','B','b','C','c']

numbers.inject() { |current, nextnum| current * nextnum }
> 120
1*2*3*4*5
> 120
# inject runs block on array

numbers.inject(2) { |current, nextnum| current * nextnum }
> 240
2*1*2*3*4*5
> 240
# the passed paramater becomes the first element in the array. If one isn't specified, it defaults to first item

letters.inject { |current, nextletter | puts current }
> A

letters.inject { |current, nextletter | puts nextletter }
> a
> B
> b
> C
> c

letters.inject('z') { |current, nextletter | puts current }
> z

letters.inject('z') { |current, nextletter | puts nextletter }
> A
> a
> B
> b
> C
> c

letters.inject('z') { |current, nextletter | print nextletter.downcase }
aabbcc

letters.inject('z') { |current, nextletter | nextletter.downcase }
=> "c"
# so it returns the last value if not requested to print anything...

letters.inject('z') { |current, nextletter | puts nextletter.ord }
> 65
> 97
> 66
> 98
> 67
> 99

```
