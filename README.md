# Universal Bash Script Logger

A robust and flexible logging framework for Bash scripts, designed to be easily integrated into your shell scripts. This logger provides multiple logging levels, customizable verbosity, and optional colored output to enhance readability.

## Features

- **Multiple Logging Levels**: Supports `SILENT`, `CRITICAL`, `ERROR`, `SUCCESS`, `WARN`, `INFO`, and `DEBUG`.
- **Customizable Verbosity**: Control the amount of log output by setting the desired verbosity level.
- **Colored Output**: Optional colored log messages for better readability in the terminal.
- **Log to File**: Optionally specify a log file to save all log messages.
- **Easy Integration**: Simple functions to include in your scripts for consistent logging.
- **Variable Dumping**: Quickly dump variable values for debugging purposes.

## Installation

To use the Universal Bash Script Logger in your scripts, you can include it by sourcing the script at the beginning of your script.

### Download the Script

Clone the repository or download the `logger.sh` script directly:

```bash
wget https://raw.githubusercontent.com/Stillreich/UBSL/main/logger.sh
```

Alternatively, you can clone the repository:

```bash
git clone https://github.com/Stillreich/UBSL.git
```

### Include in Your Script

At the top of your Bash script, source the logger script:

```bash
#!/bin/bash

# Include the logger script
source /path/to/logger.sh

# Your script code below
```

Make sure to replace `/path/to/logger.sh` with the actual path to the logger script on your system.

## Usage

### Initialize the Logger

Before using the logging functions, initialize the logger with your preferred settings:

```bash
log_initialize [log_file_path] [verbosity_level] [use_color]
```

- `log_file_path` (optional): Path to the log file. If not specified or empty, logging to a file is disabled.
- `verbosity_level` (optional): Set the logging verbosity level. Possible values are `SILENT`, `CRITICAL`, `ERROR`, `SUCCESS`, `WARN`, `INFO`, or `DEBUG`. Default is `INFO`.
- `use_color` (optional): Set to `true` or `false` to enable or disable colored output. Default is `true`.

**Example:**

```bash
log_initialize "/var/log/my_script.log" "DEBUG" true
```

### Logging Functions

After initialization, you can use the following functions to log messages at different levels:

- `log_silent "message"`: Silent logging (level 0).
- `log_critical "message"`: Critical errors that require immediate attention (level 1).
- `log_error "message"`: Standard error messages (level 2).
- `log_success "message"`: Success messages (level 3).
- `log_warn "message"`: Warnings that are not critical (level 4).
- `log_info "message"`: Informational messages (level 5).
- `log_debug "message"`: Debugging messages (level 6).

**Example:**

```bash
log_info "Starting the backup process."
log_warn "Disk space is running low."
log_error "Failed to connect to the database."
log_success "Backup completed successfully."
```

### Verbosity Levels

The verbosity level controls which messages are logged. Here are the levels in order:

1. **SILENT (0)**: No logging output.
2. **CRITICAL (1)**: Only critical messages.
3. **ERROR (2)**: Critical and error messages.
4. **SUCCESS (3)**: Critical, error, and success messages.
5. **WARN (4)**: Up to warning messages.
6. **INFO (5)**: Up to informational messages (default).
7. **DEBUG (6)**: All messages, including debug.

Set the desired verbosity level in the `log_initialize` function.

### Dumping Variables

To dump the values of variables for debugging, use:

```bash
log_dumpvar var1 var2 ...
```

This function logs the names and values of the specified variables at the `DEBUG` level.

**Example:**

```bash
log_dumpvar USER HOME PWD
```

This will output:

```
YYYY-MM-DD HH:MM:SS - DEBUG - USER=username
YYYY-MM-DD HH:MM:SS - DEBUG - HOME=/home/username
YYYY-MM-DD HH:MM:SS - DEBUG - PWD=/current/working/directory
```

## Examples

Here is a simple example of how to use the logger in a script:

```bash
#!/bin/bash

# Include the logger
source /path/to/logger.sh

# Initialize the logger
log_initialize "/tmp/my_script.log" "INFO" true

# Log messages
log_info "Script started."
log_debug "This is a debug message."
log_warn "This is a warning."
log_error "An error occurred."

# Perform some operations
if some_command; then
    log_success "Command executed successfully."
else
    log_error "Command failed to execute."
fi

# Dump variables
log_dumpvar USER HOSTNAME PWD

log_info "Script finished."
```

## Embedding in Other Scripts

To embed the Universal Bash Script Logger in your scripts:

1. **Include the Logger Script**: Source the `logger.sh` at the beginning of your script.
2. **Initialize the Logger**: Call `log_initialize` with your desired settings.
3. **Use Logging Functions**: Replace `echo` statements with appropriate `log_*` functions to provide consistent and controlled logging output.

## Customization

### Adjusting Verbosity Levels

You can control which messages are displayed or written to the log file by setting the verbosity level in `log_initialize`.

For example, to display only warnings and above:

```bash
log_initialize "/tmp/my_script.log" "WARN" true
```

### Enabling/Disabling Colored Output

Pass `true` or `false` to the `use_color` parameter in `log_initialize` to enable or disable colored output.

**Example:**

```bash
# Disable colored output
log_initialize "/tmp/my_script.log" "INFO" false
```

### Custom Log Levels

If you need to define custom log levels or adjust the existing ones, you can modify the verbosity levels defined in the script:

```bash
# Adjusted Levels: SILENT=0, CRITICAL=1, ERROR=2, SUCCESS=3, WARN=4, INFO=5, DEBUG=6
log_silent_lvl=0
log_critical_lvl=1
log_error_lvl=2
log_success_lvl=3
log_warn_lvl=4
log_info_lvl=5
log_debug_lvl=6
```

## License

This project is licensed under the terms of the GNU General Public License v3.0.

## Author

Developed by [Stillreich](https://github.com/Stillreich).
