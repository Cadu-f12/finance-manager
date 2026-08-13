back_to_general_menu() {
    echo "For the general help:"
    echo "  Type './run.sh help' to display the general commands."
    echo ""
}

show_general_help() {
    echo "This script is a management module that improves the development and setup of the finance project."
    echo ""
    echo "Usage: ./run.sh [COMMAND]"
    echo ""
    echo "Infrastructure commands:"
    echo "  up          Start the infrastructure"
    echo "  down        Stop the infrastructure"
    echo "  build       Start the infrastructure and build Docker images"
    echo "  restart     Restart the infrastructure and rebuild Docker images"
    echo "  clean       Stop the infrastructure and clean Docker volumes"
    echo "  upsql       Start only the database container"
    echo "  help        You are here :)"
    echo ""
    echo "For more information on microservice commands:"
    echo "  Type the microservice name and press Enter or help to view its specific commands."
    echo ""
    echo "Available microservices:"
    echo "  finance-api [COMMAND]"
    echo "  <service>   [COMMAND]"
    echo "  <service>   [COMMAND]"
    echo ""
}
show_finance_api_help() {
    echo "This script manages the finance-api microservice to improve development and setup."
    echo ""
    echo "Usage: ./run.sh finance-api [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  init        Start the finance-api service locally"
    echo "  stop        Stop the finance-api service"
    echo "  help        You are here :)"
    echo ""
    back_to_general_menu
}
