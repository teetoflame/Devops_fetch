#!/bin/bash

# Function to list all active ports and services
show_ports() {
    echo "Listing Active Ports and Services:"
    netstat -tuln | awk 'NR>2 {print $1, $4, $7}' | column -t
}

# Function to show detailed information for a specific port
show_port_info() {
    local port_number=$1
    echo "Information for port $port_number:"
    netstat -tuln | grep ":$port_number" | awk '{print $1, $4, $7}' | column -t
}

# Function to list Docker images and containers
docker_overview() {
    echo "Docker Images:"
    docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}"

    echo "Docker Containers:"
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
}

# Function to show details for a specific Docker container
docker_container_info() {
    local container_name=$1
    echo "Information for Docker container $container_name:"
    docker inspect $container_name | jq '.[] | {Name: .Name, State: .State, Config: .Config}'
}

# Function to list Nginx domains and their ports
nginx_domains() {
    echo "Nginx Domains and Ports:"
    grep -E -h "server_name" /etc/nginx/sites-enabled/* | sed 's/.*server_name \(.*\);/server_name: \1/' | column -t
}

# Function to show detailed configuration for a specific Nginx domain
nginx_domain_info() {
    local domain=$1
    echo "Configuration for Nginx domain $domain:"

    # Find the file
    local config_file=$(grep -l "server_name $domain;" /etc/nginx/sites-enabled/*)

    # Extract details
    local port=$(grep -E "listen" $config_file | awk '{print $2}' | head -1)
    local root_dir=$(grep -E "root" $config_file | awk '{print $2}' | head -1)
    local index_file=$(grep -E "index" $config_file | awk '{print $2}' | head -1)
    local server_name=$(grep -E "server_name" $config_file | awk '{print $2}' | head -1)

    echo "Port: $port"
    echo "Root Directory: $root_dir"
    echo "Index File: $index_file"
    echo "Server Name: $server_name"
}

# Function to list users and their last login times
list_all_users() {
    echo "User Accounts and Last Login Times:"
    lastlog | column -t
}

# Function to show details for a specific user
user_info() {
    local username=$1
    echo "Details for user $username:"
    finger $username
}

# Function to display activities within a specific time range
show_activities_in_range() {
    local start_time=$1
    local end_time=$2
    echo "Activities from $start_time to $end_time:"
    journalctl --since="$start_time" --until="$end_time" | less
}

# Function to display help message
show_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -p, --port                Show all active ports and services"
    echo "  -p <port_number>          Show detailed information for a specific port"
    echo "  -d, --docker              List all Docker images and containers"
    echo "  -d <container_name>       Show detailed information for a specific Docker container"
    echo "  -n, --nginx               List all Nginx domains and their ports"
    echo "  -n <domain>               Show detailed configuration for a specific Nginx domain"
    echo "  -u, --users               List all users and their last login times"
    echo "  -u <username>             Show detailed information for a specific user"
    echo "  -t, --time <start> <end>  Show activities within a specific time range"
    echo "  -h, --help                Display this help message"
}

# Parse command-line arguments
case $1 in
    -p|--port)
        if [ -z "$2" ]; then
            show_ports
        else
            show_port_info $2
        fi
        ;;
    -d|--docker)
        if [ -z "$2" ]; then
            docker_overview
        else
            docker_container_info $2
        fi
        ;;
    -n|--nginx)
        if [ -z "$2" ]; then
            nginx_domains
        else
            nginx_domain_info $2
        fi
        ;;
    -u|--users)
        if [ -z "$2" ]; then
            list_all_users
        else
            user_info $2
        fi
        ;;
    -t|--time)
        if [ -z "$3" ]; then
            echo "Error: Time range requires both start and end times."
            exit 1
        else
            show_activities_in_range $2 $3
        fi
        ;;
    -h|--help)
        show_help
        ;;
    *)
        echo "Error: Invalid option."
        show_help
        exit 1
        ;;
esac
