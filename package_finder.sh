#!/bin/bash

# Check if the file exists
if [ ! -f /tmp/packages.list ]; then
  # Create a blank file
  touch /tmp/packages.list
fi

# List the packages in sys1
installed_packages=$(apt list --installed | grep -F \[installed\])

# Save the list of packages to a file
echo "$installed_packages" > /tmp/packages.list
