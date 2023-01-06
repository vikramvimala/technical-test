def get_nested_value(obj, key):
    # Split the key into a list of keys
    keys = key.split("/")

    # Iterating with the keys and retrieving the corresponing value
    for k in keys:
        obj = obj[k]

    return obj

obj = {
    "a": {
        "b": {
            "c": "d"
        }
    }
}
key = "a/b/c"

value = get_nested_value(obj, key)
print(value)
