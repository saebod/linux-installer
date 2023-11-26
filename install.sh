source ./utils/menu.sh
OPTIONS_VALUES=("Update" "Python" "Docker" "Neovim" "Lazyvim" "Git" "oh-my-posh")
for i in "${!OPTIONS_VALUES[@]}"; do
	OPTIONS_STRING+="${OPTIONS_VALUES[$i]};"
done

menu SELECTED "$OPTIONS_STRING"

source ./utils/installers.sh
for i in "${!SELECTED[@]}"; do
	if [ "${SELECTED[$i]}" == "true" ]; then
		CHECKED+=("${OPTIONS_VALUES[$i]}")
	fi
done
for item in "${CHECKED[@]}"; do
    case "$item" in
        "Python")
          python_select 
          ;;
        "Update")
          update_select  
          ;;
        "Docker")
          docker_select
          ;;
          "Git")
          git_select
          ;;
        "Neovim")
          neovim_select
          ;;
        "Lazyvim")
          lazyvim_select
          ;;
        "oh-my-posh")
          ohmyposh_select
          ;;
        *)
            # You can add other cases here
            ;;
    esac
done
