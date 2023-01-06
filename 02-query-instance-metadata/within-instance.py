import requests

def get_metadata(key=None):
    myRequest = requests.get("http://169.254.169.254/latest/meta-data/")
    if myRequest.status_code == 200:
        # Split the string into a list of strings
        metadata = myRequest.text.split("\n")
        if key:
            if key in metadata:
                # Key exists, retrieve the value
                value = requests.get(f"http://169.254.169.254/latest/meta-data/{key}").text
                return value
            else:
                # Key does not exist
                return None
        else:
            return metadata
    else:
        return None

metadata = get_metadata()
print(metadata)

instance_id = get_metadata("instance-id")
print(instance_id)
