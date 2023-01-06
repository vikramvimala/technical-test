## Technical Challenge
`Challenge #3`: We have a nested object. We would like a function where you pass in the object and a key and get back the value. 
The choice of language and implementation is up to you.

Example Inputs
object = {“a”:{“b”:{“c”:”d”}}}
key = a/b/c
object = {“x”:{“y”:{“z”:”a”}}}
key = x/y/z
value = a

Hints:
We would like to see some tests. 

### Example code:
This example would return the value output as "a" with obj and key as below:
```sh
obj = {
    "x": {
        "y": {
            "z": "a"
        }
    }
}
key = "x/y/z"
``` 
### Get the value:
```sh
value = get_nested_value(obj, key)
print(value)  # Output: "a"
```
