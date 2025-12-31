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

[API Reference](docs/reference/api.md)