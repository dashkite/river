# API Reference

[DashKite River](https://github.com/dashkite/river) provides a unified functional interface for iterators and reactors (asynchronous iterators). Every function is curried and automatically dispatches to the most efficient implementation.

## Table of Contents

- **[Classes](#classes)**
  - [IteratorQueue](#iterator-queue)
  - [ReactorQueue](#reactor-queue)
  - [BufferedIterator](#buffered-iterator)
  - [BufferedReactor](#buffered-reactor)
- **[Functions](#functions)**
  - **[Transformation](#transformation)**
    - [map](#map)
    - [resolve](#resolve)
    - [spread](#spread)
    - [tap](#tap)
    - [tee](#tee)
  - **[Filtering](#filtering)**
    - [partition](#partition)
    - [reject](#reject)
    - [select](#select)
    - [unique](#unique)
    - [uniquely](#uniquely)
  - **[Truncating](#truncating)**
    - [drop](#drop)
    - [take](#take)
  - **[Combining](#combining)**
    - [merge](#merge)
    - [zip](#zip)
  - **[Reducing](#reducing)**
    - [all](#all)
    - [any](#any)
    - [collect](#collect)
    - [each](#each)
    - [find](#find)
    - [group](#group)
    - [reduce](#reduce)
    - [start](#start)

## Classes

These internal classes handle the buffering and coordination required for multi-consumer operations like `tee` and `partition`.

### IteratorQueue

A synchronous FIFO queue that can be consumed as an iterator.

### ReactorQueue

An asynchronous FIFO queue that can be consumed as a reactor.

### BufferedIterator

Composes a buffer and an iterator, allowing for shared iterators that push values into a buffer until they’re ready to be consumed.

### BufferedReactor

Composes a buffer and a reactor, allowing for shared reactors that push values into a buffer until they’re ready to be consumed.

## Functions

### Transformation

#### map

*map function, iterator → iterator*

*map function, reactor ⇢ reactor*

Given a mapping function and a stream, returns a new stream of the same type where each item has been transformed by the function.

```coffeescript
assert.deepEqual [ 2, 4, 6 ], collect map double, [ 1..3 ]
```

#### resolve

*resolve iterator → reactor*

Converts an iterator of Promises into a reactor that yields the resolved values.

```coffeescript
assert.deepEqual [ 1..5 ], await collect resolve promised [ 1..5 ]
```

#### spread

*spread function, iterator → iterator*

*spread function, reactor ⇢ reactor*

Maps a function over a stream where the function returns an iterable, then flattens the result.

```coffeescript
clone = ( x ) -> [ x, x ]
assert.deepEqual [ 1, 1, 2, 2 ], collect spread clone, [ 1, 2 ]
```

#### tap

*tap function, iterator → iterator*

*tap function, reactor ⇢ reactor*

Executes a side-effect for each item in the stream, but returns a stream of the original items.

```coffeescript
x = 0
f = -> x++
collect tap f, [ 1..5 ]
assert.equal 5, x
```

#### tee

*tee iterator → [ iterator, iterator ]*

*tee reactor ⇢ [ reactor, reactor ]*

Splits a single source into two identical streams. Uses internal buffering to ensure both consumers see all items.

```coffeescript
[ a, b ] = tee [ 1..3 ]
assert.deepEqual [ 1..3 ], collect a
assert.deepEqual [ 1..3 ], collect b
```

### Filtering

#### partition

*partition predicate, iterator → [ iterator, iterator ]*

*partition predicate, reactor ⇢ [ reactor, reactor ]*

Splits a stream into two: the first yielding items that pass the predicate, and the second yielding those that do not.

```coffeescript
[ odds, evens ] = partition odd, [ 1..4 ]
assert.deepEqual [ 1, 3 ], collect odds
assert.deepEqual [ 2, 4 ], collect evens
```

#### reject

*reject predicate, iterator → iterator*

*reject predicate, reactor ⇢ reactor*

Produces a stream containing only the items that **do not** satisfy the predicate.

```coffeescript
assert.deepEqual [ 1, 3, 5 ], collect reject even, [ 1..5 ]
```

#### select

*select predicate, iterator → iterator*

*select predicate, reactor ⇢ reactor*

Produces a stream containing only the items that satisfy the predicate.

```coffeescript
assert.deepEqual [ 1, 3, 5 ], collect select odd, [ 1..5 ]
```

#### unique

*unique iterator → iterator*

*unique reactor ⇢ reactor*

Filters out duplicate items from the stream.

```coffeescript
assert.deepEqual [ 1, 2 ], collect unique [ 1, 1, 2, 2 ]
```

#### uniquely

*uniquely selector, iterator → iterator*

*uniquely selector, reactor ⇢ reactor*

Filters items based on a uniqueness key produced by the selector function.

```coffeescript
list = [ {id: 1, name: 'a'}, {id: 1, name: 'b'} ]
getId = (obj) -> obj.id
assert.deepEqual [ list[0] ], collect uniquely getId, list
```

### Truncating

#### drop

*drop n, iterator → iterator*
*drop predicate, iterator → iterator*

*drop n, reactor ⇢ reactor*
*drop predicate, reactor ⇢ reactor*

Discards the first *n* items or the first items that satisfy the predicate, and returns a stream of the remainder.

```coffeescript
assert.deepEqual [ 3, 4 ], collect drop 2, [ 1..4 ]
```

#### take

*take n, iterator → iterator*
*take predicate, iterator → iterator*

*take n, reactor ⇢ reactor*
*drop predicate, reactor ⇢ reactor*

Returns a stream consisting of only the first *n* items or the first items that satisfy the predicate.

```coffeescript
assert.deepEqual [ 1, 2 ], collect take 2, [ 1..5 ]
```

### Combining

#### merge

*merge iterator, iterator → iterator*

*merge reactor, reactor ⇢ reactor*

Interleaves items from two streams into a single stream.

```coffeescript
assert.deepEqual [ 1, 3, 2, 4 ], collect merge [ 1, 2 ], [ 3, 4 ]
```

#### zip

*zip iterator, iterator → iterator*

*zip reactor, reactor ⇢ reactor*

Combines two streams into a stream of pairs (2-element arrays).

```coffeescript
assert.deepEqual [[ 1, 3 ], [ 2, 4 ]], collect zip [ 1, 2 ], [ 3, 4 ]
```

### Reducing

#### all

*all predicate, iterator → boolean*

*all predicate, reactor ⇢ boolean*

Returns true if every item passes the predicate. Short-circuits on first failure.

```coffeescript
assert.equal false, all odd, [ 1..5 ]
```

#### any

*any predicate, iterator → boolean*

*any predicate, reactor ⇢ boolean*

Returns true if at least one item passes the predicate. Short-circuits on first success.

```coffeescript
assert.equal true, any even, [ 1..3 ]
```

#### collect

*collect iterator → array*

*collect reactor ⇢ array*

Exhausts the stream and returns all items in an array.

```coffeescript
assert.deepEqual [ 1, 2 ], collect [ 1, 2 ].values()
```

#### each

*each function, iterator → undefined*

*each function, reactor ⇢ undefined*

Iterates over the stream and applies the function to each item for side effects.

```coffeescript
x = 0
each ((y) -> x += y), [ 1..3 ]
assert.equal 6, x
```

#### find

*find predicate, iterator → value | undefined*

*find predicate, reactor ⇢ value | undefined*

Returns the first item that satisfies the predicate.

```coffeescript
assert.equal 2, find even, [ 1..3 ]
```

#### group

*group selector, iterator → Map*

*group selector, reactor ⇢ Map*

Categorizes items into a Map where keys are generated by the selector.

```coffeescript
result = group parity, [ 1..4 ]
```

#### reduce

*reduce initial, accumulator, iterator → value*

*reduce initial, accumulator, reactor ⇢ value*

Standard reduction of a stream to a single value.

```coffeescript
assert.equal 6, reduce 0, sum, [ 1..3 ]
```

#### start

*start iterator → undefined*

*start reactor ⇢ undefined*

Drives a stream to completion without yielding products. Useful for lazy streams with side effects.

```coffeescript
start logger
```
