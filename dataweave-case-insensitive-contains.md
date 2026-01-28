# Case-insensitive string match in Mule 4 DataWeave

Use `lower()` (or `upper()`) on both the array elements and the search string, then use `contains` or `any`.

## Example: `contains` with a normalized array

```dw
%dw 2.0
output application/json
var values = ["Foo", "Bar", "BAZ"]
var needle = "baz"
---
(values map ((v) -> lower(v))) contains lower(needle)
```

## Example: `any` with per-element comparison

```dw
%dw 2.0
output application/json
var values = ["Foo", "Bar", "BAZ"]
var needle = "baz"
---
values any ((v) -> lower(v) == lower(needle))
```

Both examples return `true` when `needle` is present in `values`, regardless of casing.
