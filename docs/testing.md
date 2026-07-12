# Testing

This document outlines the testing conventions and requirements for DashKite River.

## Running Tests

To run the test suite, use the `genie` task runner:

```bash
pnpm genie test
```

## Test Structure

Tests are located in the `test/` directory. Each function has a corresponding test file validating its behavior with both iterators and reactors. Creators adding new functionality must include tests covering both synchronous and asynchronous inputs.
