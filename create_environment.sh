#!/bin/bash

# =============================================================================
# SUBMISSION REMINDER APP ENVIRONMENT SETUP SCRIPT
# =============================================================================
# Script Name: create_environment.sh
# Purpose: Automates the creation of directory structure and files for the
#          submission reminder application using provided content and packing method
# Author: Student Assignment
# Date: $(date +%Y-%m-%d)
# =============================================================================

# Display initial setup banner
echo "=== Submission Reminder App Environment Setup ==="
echo

# =============================================================================
# USER INPUT SECTION
# =============================================================================
# Prompt the user to enter their name which will be used in the directory name
# This creates a personalized directory structure for each user
echo "This script will create a personalized submission reminder application."
echo "The directory will be named: submission_reminder_{yourName}"
echo
read -p "Please enter your name: " user_name

# =============================================================================
# INPUT VALIDATION
# =============================================================================
# Check if the user provided a name (not empty or just whitespace)
# Exit with error code 1 if no name is provided
if [ -z "$user_name" ]; then
    echo "Error: Name cannot be empty!"
    echo "Please run the script again and provide a valid name."
    exit 1
fi

# =============================================================================
# DIRECTORY CREATION SECTION
# =============================================================================
# Create the main application directory using the provided name
# Replace any spaces in the name with underscores for filesystem compatibility
app_dir="submission_reminder_${user_name// /_}"
echo "Creating main application directory: $app_dir"

# Check if directory already exists and handle the situation
# Remove existing directory to ensure clean installation
if [ -d "$app_dir" ]; then
    echo "Warning: Directory $app_dir already exists."
    echo "Removing existing directory to create fresh installation..."
    rm -rf "$app_dir"
fi

# Create the main directory and navigate into it
# All subsequent files and directories will be created relative to this location
mkdir "$app_dir"
cd "$app_dir"

# =============================================================================
# SUBDIRECTORY STRUCTURE CREATION
# =============================================================================
# Create the required subdirectory structure for the application
# Each directory serves a specific purpose in the application architecture
echo "Creating application subdirectories..."

# Create all directories in a single command grouping
{
    mkdir -p app      # Contains the main application scripts
    mkdir -p modules  # Contains reusable functions and utility scripts
    mkdir -p assets   # Contains data files like student submission records
    mkdir -p config   # Contains configuration files and environment settings
}

echo "Creating application files..."

# =============================================================================
# CONFIGURATION FILE CREATION (PROVIDED CONTENT)
# =============================================================================
# Create the main configuration file using the provided content
# This file contains the assignment and deadline information
# Location: config/config.env
echo "Creating configuration file: config/config.env"

{
    echo "# This is the config file"
    echo "ASSIGNMENT=\"Shell Navigation\""
    echo "DAYS_REMAINING=2"
} > config/config.env

# =============================================================================
# FUNCTIONS MODULE CREATION (PROVIDED CONTENT)
# =============================================================================
# Create the functions.sh file using the provided content
# This contains the check_submissions function for processing student data
# Location: modules/functions.sh
echo "Creating functions module: modules/functions.sh"

{
    echo "#!/bin/bash"
    echo ""
    echo "# Function to read submissions file and output students who have not submitted"
    echo "function check_submissions {"
    echo "    local submissions_file=\$1"
    echo "    echo \"Checking submissions in \$submissions_file\""
    echo ""
    echo "    # Skip the header and iterate through the lines"
    echo "    while IFS=, read -r student assignment status; do"
    echo "        # Remove leading and trailing whitespace"
    echo "        student=\$(echo \"\$student\" | xargs)"
    echo "        assignment=\$(echo \"\$assignment\" | xargs)"
    echo "        status=\$(echo \"\$status\" | xargs)"
    echo ""
    echo "        # Check if assignment matches and status is 'not submitted'"
    echo "        if [[ \"\$assignment\" == \"\$ASSIGNMENT\" && \"\$status\" == \"not submitted\" ]]; then"
    echo "            echo \"Reminder: \$student has not submitted the \$ASSIGNMENT assignment!\""
    echo "        fi"
    echo "    done < <(tail -n +2 \"\$submissions_file\") # Skip the header"
    echo "}"
} > modules/functions.sh

# =============================================================================
# MAIN REMINDER SCRIPT CREATION (PROVIDED CONTENT)
# =============================================================================
# Create the main reminder.sh script using the provided content
# This script orchestrates the reminder checking process
# Location: app/reminder.sh
echo "Creating main reminder script: app/reminder.sh"

{
    echo "#!/bin/bash"
    echo ""
    echo "# Source environment variables and helper functions"
    echo "source ./config/config.env"
    echo "source ./modules/functions.sh"
    echo ""
    echo "# Path to the submissions file"
    echo "submissions_file=\"./assets/submissions.txt\""
    echo ""
    echo "# Print remaining time and run the reminder function"
    echo "echo \"Assignment: \$ASSIGNMENT\""
    echo "echo \"Days remaining to submit: \$DAYS_REMAINING days\""
    echo "echo \"--------------------------------------------\""
    echo ""
    echo "check_submissions \$submissions_file"
} > app/reminder.sh

# =============================================================================
# STUDENT SUBMISSIONS DATA FILE CREATION (PROVIDED CONTENT)
# =============================================================================
# Create the submissions.txt file using the exact provided content
# This file contains the student submission records as provided
# Location: assets/submissions.txt
echo "Creating student submissions data file: assets/submissions.txt"

{
    echo "student, assignment, submission status"
    echo "Chinemerem, Shell Navigation, not submitted"
    echo "Chiagoziem, Git, submitted"
    echo "Divine, Shell Navigation, not submitted"
    echo "Anissa, Shell Basics, submitted"
} > assets/submissions.txt

# =============================================================================
# STARTUP SCRIPT CREATION (CUSTOM IMPLEMENTATION)
# =============================================================================
# Create the startup.sh script that serves as the main application launcher
# This script initializes and runs the submission reminder application
# Location: ./startup.sh (in the root of the application directory)
echo "Creating application startup script: startup.sh"

{
    echo "#!/bin/bash"
    echo ""
    echo "# Startup script for Submission Reminder App"
    echo "# This script initializes and runs the submission reminder application"
    echo ""
    echo "echo \"Starting Submission Reminder App...\""
    echo "echo"
    echo ""
    echo "# Check if we're in the correct directory"
    echo "if [ ! -f \"app/reminder.sh\" ]; then"
    echo "    echo \"Error: reminder.sh not found! Make sure you're in the correct directory.\""
    echo "    exit 1"
    echo "fi"
    echo ""
    echo "# Make sure all scripts are executable"
    echo "chmod +x app/reminder.sh"
    echo "chmod +x modules/functions.sh"
    echo ""
    echo "# Display menu"
    echo "show_menu() {"
    echo "    echo \"========================================\""
    echo "    echo \"    Submission Reminder Application\""
    echo "    echo \"========================================\""
    echo "    echo \"1. Run submission reminder check\""
    echo "    echo \"2. View all submissions\""
    echo "    echo \"3. View application info\""
    echo "    echo \"4. Exit\""
    echo "    echo \"========================================\""
    echo "}"
    echo ""
    echo "# Function to display all submissions"
    echo "view_submissions() {"
    echo "    echo"
    echo "    echo \"All Student Submissions:\""
    echo "    echo \"----------------------------------------\""
    echo "    cat assets/submissions.txt"
    echo "    echo \"----------------------------------------\""
    echo "}"
    echo ""
    echo "# Main loop"
    echo "while true; do"
    echo "    show_menu"
    echo "    read -p \"Please select an option (1-4): \" choice"
    echo "    "
    echo "    case \$choice in"
    echo "        1)"
    echo "            echo"
    echo "            echo \"Running submission reminder check...\""
    echo "            echo"
    echo "            bash app/reminder.sh"
    echo "            echo"
    echo "            read -p \"Press Enter to continue...\""
    echo "            ;;"
    echo "        2)"
    echo "            view_submissions"
    echo "            echo"
    echo "            read -p \"Press Enter to continue...\""
    echo "            ;;"
    echo "        3)"
    echo "            echo"
    echo "            echo \"Application: Submission Reminder App\""
    echo "            echo \"Purpose: Track and remind about assignment deadlines\""
    echo "            echo \"Created by: \$USER\""
    echo "            echo \"Date: \$(date)\""
    echo "            echo \"Total Students: \$((\$(wc -l < assets/submissions.txt) - 1))\""
    echo "            echo"
    echo "            read -p \"Press Enter to continue...\""
    echo "            ;;"
    echo "        4)"
    echo "            echo \"Thank you for using Submission Reminder App!\""
    echo "            exit 0"
    echo "            ;;"
    echo "        *)"
    echo "            echo \"Invalid option. Please select 1-4.\""
    echo "            read -p \"Press Enter to continue...\""
    echo "            ;;"
    echo "    esac"
    echo "    clear"
    echo "done"
} > startup.sh

# =============================================================================
# FILE PERMISSIONS SETUP
# =============================================================================
# Make all shell scripts executable so they can be run directly
# This is essential for the application to function properly
echo "Setting executable permissions on all scripts..."

{
    chmod +x startup.sh
    chmod +x app/reminder.sh
    chmod +x modules/functions.sh
}

# =============================================================================
# COMPLETION SUMMARY AND INSTRUCTIONS
# =============================================================================
# Display summary of what was created and how to use the application

{
    echo
    echo "Environment setup completed successfully!"
    echo
    echo "Directory structure created:"
    echo "DIRECTORY: $app_dir/"
    echo "  |-- SUBDIRECTORY: app/"
    echo "  |   |-- FILE: reminder.sh (main application logic)"
    echo "  |-- SUBDIRECTORY: modules/"
    echo "  |   |-- FILE: functions.sh (utility functions)"
    echo "  |-- SUBDIRECTORY: assets/"
    echo "  |   |-- FILE: submissions.txt (student data - 4 records)"
    echo "  |-- SUBDIRECTORY: config/"
    echo "  |   |-- FILE: config.env (application configuration)"
    echo "  |-- FILE: startup.sh (application launcher)"
    echo
    echo "NEXT STEPS:"
    echo "1. Navigate to the application directory: cd $app_dir"
    echo "2. Run the application: ./startup.sh"
    echo
    echo "APPLICATION FEATURES:"
    echo "- Uses provided config.env, functions.sh, and reminder.sh content"
    echo "- Contains exactly the provided student records"
    echo "- Interactive menu system for easy navigation"
    echo "- Checks for 'Shell Navigation' assignment submissions"
    echo "- Displays reminders for students who haven't submitted"
    echo
    echo "CONFIGURATION:"
    echo "- Current assignment: Shell Navigation"
    echo "- Days remaining: 2 days"
    echo "- Total students: 4 (as provided)"
}
