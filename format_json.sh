format_json() {
    local recursive=""
    local find_command="find . -maxdepth 1 -type f"

    # Check for optional recursive flag
    while getopts "r" opt; do
        case $opt in
            r)
                recursive="1"
                find_command="find . -type f"
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                return 1
                ;;
        esac
    done

    # Reset OPTIND to allow function to be called multiple times
    OPTIND=1

    # Exclude files listed in .gitignore if it exists
    local exclude_from=""
    if [ -f ".gitignore" ]; then
        exclude_from="--exclude-from .gitignore"
    fi

    # Execute find command, exclude .gitignore contents if applicable
    $find_command -name "*.json" $exclude_from -exec sh -c '
        for file do
            jq . "$file" > "${file%.json}_formatted.json"
        done
    ' sh {} +
}


