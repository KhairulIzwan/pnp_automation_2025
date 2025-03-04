# pnp_automation_2025

## Overview

This repository contains scripts and tools for automating various tasks related to performance and power management.

## Directory Structure

```
pnp_automation_2025/
├── linux/
│   ├── select_governor.sh
│   └── toggle_governor.sh
└── README.md
```

## Scripts

### `select_governor.sh`

This script allows the user to select the CPU frequency governor from the available options for all CPUs in the system. It requires sudo privileges to set the governor.

#### Usage

```bash
sudo ./select_governor.sh
```

#### Functions

- `get_current_governor`: Prints the current CPU frequency governor.
- `list_available_governors`: Lists all available CPU frequency governors.
- `list_available_governors_with_numbers`: Lists all available CPU frequency governors with numbers.
- `set_governor_for_all_cpus`: Sets the specified governor for all CPUs.
- `main`: Main script logic to interact with the user and set the governor.

#### Example

1. Run the script with sudo privileges:

    ```bash
    sudo ./select_governor.sh
    ```

2. The script will display the current governor and list available governors:

    ```
    Current governor: performance
    Available governors:
    0) performance
    1) powersave
    ```

3. Enter the number of the governor you want to set (e.g., `1` for `powersave`).

4. The script will set the selected governor for all CPUs and confirm the change:

    ```
    Switched all CPUs to powersave
    ```

### `toggle_governor.sh`

This script toggles the CPU frequency governor between `performance` and `powersave` for all CPUs in the system. It requires sudo privileges to set the governor.

#### Usage

```bash
sudo ./toggle_governor.sh
```

#### Example

1. Run the script with sudo privileges:

    ```bash
    sudo ./toggle_governor.sh
    ```

2. The script will toggle the governor and confirm the change:

    ```
    Switched all CPUs to performance
    ```

## License

This project is licensed under the MIT License.