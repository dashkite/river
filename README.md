# DashKite River

*Iterator and reactor functions for JavaScript*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

River provides a unified functional interface for iterators and **reactors** (asynchronous iterators). Every function is curried and automatically dispatches to the most efficient implementation based on the input type.

### API Reference

| **Category**   | **Function** | **Description**                                              |
| -------------- | ------------ | ------------------------------------------------------------ |
| Transformation | `map`        | Applies a mapping function to each item                      |
|                | `spread`     | Flattens results after apply a function to each item (analogous to `flatMap` in the JavaScript API) |
|                | `resolve`    | Converts an iterator producing promises into a reactor producing the promised values |
|                | `tap`        | Applies a function to each item, but produces the original value |
| Filtering      | `select`     | Produces items where a predicate is true                     |
|                | `reject`     | Produces items where a predicate is true                     |
|                | `uniquely`   | Produces items with unique values based on a given key function |
|                | `unique`     | Produces unique items                                        |
| Truncation     | `take`       | Produces the first _n_ items based on an index or predicate  |
|                | `drop`       | Skips the first _n_ items based on an index or predicate     |
| Combination    | `zip`        | Produces pairs based on the corresponding items in two streams |
|                | `merge`      | Produces alternating items from two streams                  |
| Reducers       | `reduce`     | Accumulates the items into a single value                    |
|                | `group`      | Groups items into a Map by key                               |
|                | `collect`    | Collect the items of a stream into an array                  |
|                | `each`       | Exhaust a stream by calling a function on each item          |
|                | `start`      | Exhaust a stream without doing anything with the products    |
|                | `any`        | Returns true if any item satisfies a predicate, false otherwise |
|                | `all`        | Returns true if all items satisfy a predicate, false otherwise |

