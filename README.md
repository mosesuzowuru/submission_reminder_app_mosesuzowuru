# Submission Reminder App Setup Script

## Overview

The `create_environment.sh` script automates the creation of a complete submission reminder application environment. It uses shell command grouping with braces `{}` and redirection operators to efficiently create directories and files with predetermined content.

## How to Run the Script

### Prerequisites
- Linux/Unix environment with Bash shell
- Execute permissions for the script

### Execution Steps

1. **Make the script executable:**
   ```bash
   chmod +x create_environment.sh
   ```

2. **Run the script:**
   ```bash
   ./create_environment.sh
   ```

3. **Enter your name when prompted:**
   ```
   Please enter your name: [Your Name]
   ```

4. **Navigate to the created directory:**
   ```bash
   cd submission_reminder_{YourName}
   ```

5. **Start the application:**
   ```bash
   ./startup.sh
   ```

## What the Script Creates

### Directory Structure
```
submission_reminder_{YourName}/
├── app/
│   └── reminder.sh          # Main application script
├── modules/
│   └── functions.sh         # Helper functions
├── assets/
│   └── submissions.txt      # Student submission data
├── config/
│   └── config.env          # Configuration variables
└── startup.sh              # Application launcher
```

### File Contents

#### `config/config.env`
Contains environment variables for the application:
- `ASSIGNMENT="Shell Navigation"` - Current assignment being tracked
- `DAYS_REMAINING=2` - Days left for submission

#### `modules/functions.sh`
Contains the `check_submissions` function that:
- Reads the submissions file
- Filters students by assignment type
- Identifies students who haven't submitted
- Displays reminder messages

#### `app/reminder.sh`
Main application script that:
- Sources configuration and functions
- Sets path to submissions file
- Displays assignment information
- Calls the check_submissions function

#### `assets/submissions.txt`
Student data in CSV format:
```
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
```

#### `startup.sh`
Interactive menu system providing options to:
- Run submission reminder check
- View all submissions
- View application information
- Exit the application

## How the Script Works

### 1. User Input Processing
```bash
read -p "Please enter your name: " user_name
app_dir="submission_reminder_${user_name// /_}"
```
- Prompts for user name
- Replaces spaces with underscores for valid directory naming

### 2. Directory Creation
```bash
{
    mkdir -p app
    mkdir -p modules
    mkdir -p assets
    mkdir -p config
}
```
- Uses command grouping to create all directories efficiently

### 3. File Creation with Packing Method
```bash
{
    echo "# This is the config file"
    echo "ASSIGNMENT=\"Shell Navigation\""
    echo "DAYS_REMAINING=2"
} > config/config.env
```
- Groups multiple echo commands
- Redirects all output to a single file atomically
- Ensures consistent file creation

### 4. Permission Setting
```bash
{
    chmod +x startup.sh
    chmod +x app/reminder.sh
    chmod +x modules/functions.sh
}
```
- Makes all shell scripts executable in one operation

## Application Functionality

### Running the Reminder Check
When you select option 1 from the startup menu, the application:

1. **Loads Configuration**: Sources `config.env` to get assignment details
2. **Loads Functions**: Sources `functions.sh` to access helper functions
3. **Displays Header**: Shows current assignment and days remaining
4. **Processes Data**: Reads `submissions.txt` and filters for the current assignment
5. **Shows Reminders**: Displays messages for students who haven't submitted

### Sample Output
```
Assignment: Shell Navigation
Days remaining to submit: 2 days
--------------------------------------------
Checking submissions in ./assets/submissions.txt
Reminder: Chinemerem has not submitted the Shell Navigation assignment!
Reminder: Divine has not submitted the Shell Navigation assignment!
```

## Technical Implementation

### Command Grouping Benefits
- **Atomic Operations**: All content written to file in single operation
- **Efficiency**: Reduces system calls and I/O operations
- **Reliability**: Ensures complete file creation or failure
- **Readability**: Groups related commands logically

### Variable Expansion
- User input variables expand at runtime
- File paths remain relative for portability
- Environment variables properly escaped in generated scripts

### Error Handling
- Input validation for empty names
- Directory existence checking with cleanup
- File permission verification
- Script dependency validation in startup

## Customization

### Modifying Assignment Details
Edit `config/config.env` after creation:
```bash
ASSIGNMENT="New Assignment Name"
DAYS_REMAINING=5
```

### Adding More Students
Edit `assets/submissions.txt` following the CSV format:
```
student, assignment, submission status
NewStudent, Shell Navigation, not submitted
```

### Configuration Requirements
- Assignment names must match exactly between config and data files
- Status values should be "submitted" or "not submitted"
- CSV format must be maintained with proper spacing

## Troubleshooting

### Common Issues
- **Permission Denied**: Ensure script has execute permissions
- **Directory Exists**: Script automatically removes existing directories
- **File Not Found**: Verify you're in the correct directory when running startup.sh

### Debugging
- Check file creation in each subdirectory
- Verify file permissions with `ls -la`
- Test individual components by running `app/reminder.sh` directly

## Summary

This script demonstrates professional shell scripting practices by using command grouping and redirection to efficiently create a complete application environment with predetermined, tested content. The resulting application provides a functional submission tracking and reminder system for educational environments.
