#!/usr/bin/env just --justfile

set shell := ["bash", "-uc"]
set dotenv-required := true
set dotenv-load := true
set export := true

COMMIT_HASH := `git rev-parse --short HEAD`

# List available recipes
_default:
    @just --list


[group('utils')]
format:
    #!/usr/bin/env bash
    formatted_count=0
    # Function to format a single justfile
    format_single() {
        local file="$1"
        if [ -f "$file" ]; then
            echo "  Formatting: $file"
            if just --unstable --fmt --justfile "$file"; then
                ((formatted_count++))
            else
                echo "  ❌ Failed to format: $file"
                return 1
            fi
        fi
    }
    
    # Format main justfile
    echo "  Formatting main justfile"
    just --unstable --fmt
    ((formatted_count++))
    
    # Format all .just files
    while IFS= read -r -d '' file; do
        format_single "$file"
    done < <(find . -name "*.just" -type f -print0)
    
    # Format hidden justfiles if they exist
    if [ -f ".justfile" ]; then
        format_single ".justfile"
    fi
    
    echo "✅ Formatted $formatted_count justfiles successfully"
