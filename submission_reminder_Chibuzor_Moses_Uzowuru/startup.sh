#!/bin/bash

# Startup script for Submission Reminder App
# This script initializes and runs the submission reminder application

echo "Starting Submission Reminder App..."
echo

# Check if we're in the correct directory
if [ ! -f "app/reminder.sh" ]; then
    echo "Error: reminder.sh not found! Make sure you're in the correct directory."
    exit 1
fi

# Make sure all scripts are executable
chmod +x app/reminder.sh
chmod +x modules/functions.sh

# Display menu
show_menu() {
    echo "========================================"
    echo "    Submission Reminder Application"
    echo "========================================"
    echo "1. Run submission reminder check"
    echo "2. View all submissions"
    echo "3. View application info"
    echo "4. Exit"
    echo "========================================"
}

# Function to display all submissions
view_submissions() {
    echo
    echo "All Student Submissions:"
    echo "----------------------------------------"
    cat assets/submissions.txt
    echo "----------------------------------------"
}

# Main loop
while true; do
    show_menu
    read -p "Please select an option (1-4): " choice
    
    case $choice in
        1)
            echo
            echo "Running submission reminder check..."
            echo
            bash app/reminder.sh
            echo
            read -p "Press Enter to continue..."
            ;;
        2)
            view_submissions
            echo
            read -p "Press Enter to continue..."
            ;;
        3)
            echo
            echo "Application: Submission Reminder App"
            echo "Purpose: Track and remind about assignment deadlines"
            echo "Created by: $USER"
            echo "Date: $(date)"
            echo "Total Students: $(($(wc -l < assets/submissions.txt) - 1))"
            echo
            read -p "Press Enter to continue..."
            ;;
        4)
            echo "Thank you for using Submission Reminder App!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please select 1-4."
            read -p "Press Enter to continue..."
            ;;
    esac
    clear
done
