# DashKite River

*Iterator and reactor functions for JavaScript*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

River provides a unified functional interface for iterators and **reactors** (asynchronous iterators). Every function is curried and automatically dispatches to the most efficient implementation based on the input type.

## Use

```coffeescript
import { pipe } from "@dashkite/joy/function"
import {
  collect
  map
  resolve
} from "@dashkite/river"

json = ( response ) -> response.json()

get = pipe [
  map fetch
  resolve
  map json
  resolve
  collect
]

values = await get [ "https://httpbin.org/json" ]
```

## Features

- Uses lazy evaluation whenever possible
- Dispatches to the optimized implementation based on the arguments
- Provides a functional interface for a superset of the JavaScript iterator helpers
- Preserves _this_ binding within combinators allowing use within methods

## API Reference

| **Category**   | **Function** | **Description**                                              |
| -------------- | ------------ | ------------------------------------------------------------ |
| Transformation | `map`        | Applies a mapping function to each item                      |
|                | `resolve`    | Converts an iterator producing promises into a reactor producing the promised values |
|                | `spread`     | Flattens results after apply a function to each item (analogous to `flatMap` in the JavaScript API) |
|                | `tap`        | Applies a function to each item, but produces the original value |
| Filtering      | `reject`     | Produces items where a predicate is true                     |
|                | `select`     | Produces items where a predicate is true                     |
|                | `unique`     | Produces unique items                                        |
|                | `uniquely`   | Produces items with unique values based on a getter          |
| Truncating     | `drop`       | Skips the first _n_ items based on an index or predicate     |
|                | `take`       | Produces the first _n_ items based on an index or predicate  |
| Combining      | `merge`      | Produces alternating items from two streams                  |
|                | `zip`        | Produces pairs based on the corresponding items in two streams |
| Reducing       | `all`        | Returns true if all items satisfy a predicate, false otherwise |
|                | `any`        | Returns true if any item satisfies a predicate, false otherwise |
|                | `collect`    | Collect the items of a stream into an array                  |
|                | `each`       | Exhaust a stream by calling a function on each item          |
|                | `find`       | Returns the first item matching a predicate, `undefined` otherwise |
|                | `group`      | Groups items into a Map by key                               |
|                | `reduce`     | Accumulates the items into a single value                    |
|                | `start`      | Exhaust a stream without doing anything with the products    |

