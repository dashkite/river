# DashKite River API Reference

## Transformation

### map

*map function, iterator → iterator*

*map function, reactor ⇢ reactor*

Produces a new stream where each item is the result of applying the mapping function to the original items.

#### Example

CoffeeScript

```
assert.deepEqual [ 2, 4, 6 ], collect map double, [ 1..3 ]
```

### resolve

*resolve iterator → reactor*

Converts an iterator that produces Promises into a reactor that produces the resolved values of those Promises.

#### Example

CoffeeScript

```
assert.deepEqual [ 1..5 ], await collect resolve promised [ 1..5 ]
```

### spread

*spread function, iterator → iterator*

*spread function, reactor ⇢ reactor*

Applies a function to each item that returns an iterable, then flattens the results into a single stream.

#### Example

CoffeeScript

```
clone = ( x ) -> [ x, x ]
assert.deepEqual [ 1, 1, 2, 2 ], collect spread clone, [ 1, 2 ]
```

### tap

*tap function, iterator → iterator*

*tap function, reactor ⇢ reactor*

Applies a side-effect function to each item but passes the original item through unchanged.

#### Example

CoffeeScript

```
x = 0
f = -> x++
collect tap f, [ 1..5 ]
assert.equal 5, x
```

## Filtering

### reject

*reject predicate, iterator → iterator*

*reject predicate, reactor ⇢ reactor*

Produces a stream containing only the items that **do not** satisfy the predicate.

#### Example

CoffeeScript

```
assert.deepEqual [ 1, 3, 5 ], collect reject even, [ 1..5 ]
```

### select

*select predicate, iterator → iterator*

*select predicate, reactor ⇢ reactor*

Produces a stream containing only the items that satisfy the predicate.

#### Example

CoffeeScript

```
assert.deepEqual [ 1, 3, 5 ], collect select odd, [ 1..5 ]
```

### unique

*unique iterator → iterator*

*unique reactor ⇢ reactor*

Produces a stream containing only unique items, filtering out duplicates.

#### Example

CoffeeScript

```
assert.deepEqual [ 1, 2 ], collect unique [ 1, 1, 2, 2 ]
```

### uniquely

*uniquely selector, iterator → iterator*

*uniquely selector, reactor ⇢ reactor*

Produces a stream where items are unique based on the value returned by the provided selector function.

#### Example

CoffeeScript

```
list = [ {id: 1, name: 'a'}, {id: 1, name: 'b'}, {id: 2, name: 'c'} ]
getId = (obj) -> obj.id
assert.deepEqual [ list[0], list[2] ], collect uniquely getId, list
```

## Truncating

### drop

*drop n, iterator → iterator*

*drop n, reactor ⇢ reactor*

Skips the first *n* items of the stream and produces the remaining items.

#### Example

CoffeeScript

```
assert.deepEqual [ 3, 4 ], collect drop 2, [ 1..4 ]
```

### take

*take n, iterator → iterator*

*take n, reactor ⇢ reactor*

Produces only the first *n* items from the stream.

#### Example

CoffeeScript

```
assert.deepEqual [ 1, 2, 1, 2 ], collect take 4, cycle [ 1, 2 ]
```

## Combining

### merge

*merge iterator, iterator → iterator*

*merge reactor, reactor ⇢ reactor*

Combines two streams by alternating between their items.

#### Example

CoffeeScript

```
assert.deepEqual [ 1, 3, 2, 4 ], collect merge [ 1, 2 ], [ 3, 4 ]
```

### zip

*zip iterator, iterator → iterator*

*zip reactor, reactor ⇢ reactor*

Produces a stream of pairs (arrays of two items) created from the corresponding items of the two input streams.

#### Example

CoffeeScript

```
assert.deepEqual [[ 1, 3 ], [ 2, 4 ]], collect zip [ 1, 2 ], [ 3, 4 ]
```

## Reducing

### all

*all predicate, iterator → boolean*

*all predicate, reactor ⇢ boolean*

Returns true if all items satisfy the predicate. It short-circuits as soon as an item fails.

#### Example

CoffeeScript

```
assert.equal false, all odd, [ 1..5 ]
```

### any

*any predicate, iterator → boolean*

*any predicate, reactor ⇢ boolean*

Returns true if at least one item in the stream satisfies the predicate.

#### Example

CoffeeScript

```
assert.equal true, any even, [ 1..3 ]
```

### collect

*collect iterator → array*

*collect reactor ⇢ array*

Exhausts the stream and gathers all produced items into a single array.

#### Example

CoffeeScript

```
assert.deepEqual [ 1, 2 ], collect [ 1, 2 ].values()
```

### each

*each function, iterator → undefined*

*each function, reactor ⇢ undefined*

Exhausts the stream by applying the provided function to every item.

#### Example

CoffeeScript

```
x = 0
add = ( y ) -> x += y
each add, [ 1..3 ]
assert.equal 6, x
```

### find

*find predicate, iterator → value | undefined*

*find predicate, reactor ⇢ value | undefined*

Returns the first item that satisfies the predicate, or undefined if no such item exists.

#### Example

CoffeeScript

```
assert.equal 2, find even, [ 1..3 ]
```

### group

*group selector, iterator → Map*

*group selector, reactor ⇢ Map*

Groups items from the stream into a `Map` where keys are produced by the selector.

#### Example

CoffeeScript

```
parity = (x) -> if x % 2 == 0 then 'even' else 'odd'
result = group parity, [ 1..4 ]
```

### reduce

*reduce initial, accumulator, iterator → value*

*reduce initial, accumulator, reactor ⇢ value*

Reduces the stream to a single value using an accumulator and an initial seed.

#### Example

CoffeeScript

```
assert.equal 6, reduce 0, sum, [ 1..3 ]
```

### start

*start iterator → undefined*

*start reactor ⇢ undefined*

Exhausts the stream without performing any action on the products, typically to trigger side effects.

#### Example

CoffeeScript

```
start someLazyStream
```

