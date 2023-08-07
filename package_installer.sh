#!/bin/bash

# Input file containing the package list
input_file="packages.list"

# Function to install each package using apt
install_packages() {
  total_packages=$(wc -l < "$input_file")
  current_package_count=0

  # Function to handle the SIGINT and SIGTSTP signals
  stop_script() {
    echo "Script stopped. Stopping package installations..."
    kill -TERM 0  # Terminate all child processes, including apt
  }

  trap stop_script SIGINT SIGTSTP

  while read -r package_info; do
    ((current_package_count++))
    # Extract the package name from the package_info
    package=$(echo "$package_info" | cut -d '/' -f 1)

    # Calculate the percentage and the number of "|" characters for the progress bar
    percentage=$((current_package_count * 100 / total_packages))
    bar_length=$((percentage / 2)) # Using 2 "|" characters for each percent
    dot_length=$((50 - bar_length)) # Total length of the progress bar is 50 characters

    # Install the package using apt and capture the output and error code
    if output=$(apt install -y "$package" 2>&1); then
      echo "Package $package installed successfully."
      ((success_count++))
    else
      echo "Error installing package $package:"
      echo "$output"
      ((failed_count++))
    fi

    # Update the progress bar and percentage
    dots=$(printf '%*s' "$dot_length" | tr ' ' '.') # Generate the dots
    printf "Progress: [%-${bar_length}s%s] %d%%\r" "$(printf '%*s' "$bar_length" | tr ' ' '|')" "$dots" $percentage

    if [ $current_package_count -eq $total_packages ]; then
      echo # Move to the next line after completion
    fi

  done <"$input_file"
}

# Check if the script is being run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run this script as root (sudo)."
  exit 1
fi

# Variables to track successful and failed installations
success_count=0
failed_count=0

# Run the function to install packages
install_packages

# Display the summary of successful and failed installations
echo "Total packages: $((success_count + failed_count))"
echo "Successfully installed: $success_count"
echo "Failed to install: $failed_count"
