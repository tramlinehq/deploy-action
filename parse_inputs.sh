#!/bin/bash -l

echo "Starting tramline input parsing..."

# Install jq if it doesn't exist
if ! command -v jq &> /dev/null
then
    echo "jq is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y jq
else
    echo "jq is already installed. Skipping..."
fi

# Parse JSON and store keys in an array
echo $1 > tramline_input.json
keys=()
while read -r value
do
    keys+=("$value")
done < <(jq -c 'keys_unsorted[]' tramline_input.json)

# Exit if there are parse errors
if [ -z "$keys" ]; then
    echo "Error parsing Tramline inputs. Exiting..."
    exit 1
fi

# Loop through the keys and set variables
for key in "${keys[@]}"; do
    # Get the value of the key from JSON
    value=$(jq -r ".$key" tramline_input.json)
    # Remove double quotes from key
    key="${key//\"/}"
    # Assign the value to a variable with a name based on the key
    output="${key}=${value}"
    # Output
    echo $output >> "$GITHUB_OUTPUT"
done

# Cleanup
rm -f tramline_input.json
echo "Finishing up tramline input parsing..."
