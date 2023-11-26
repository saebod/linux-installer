source ./utils/menu.sh
OPTIONS_VALUES=("Update" "Python" "Docker" "Neovim" "Lazyvim" "Git" "oh-my-posh" "Git CLI")
for i in "${!OPTIONS_VALUES[@]}"; do
	OPTIONS_STRING+="${OPTIONS_VALUES[$i]};"
done

menu SELECTED "$OPTIONS_STRING"

source ./utils/installers.sh
source ./utils/msg.sh
for i in "${!SELECTED[@]}"; do
	if [ "${SELECTED[$i]}" == "true" ]; then
		CHECKED+=("${OPTIONS_VALUES[$i]}")
	fi
done
for item in "${CHECKED[@]}"; do
    case "$item" in
        "Python")
          msg "$item"
          python_select 
          ;;
        "Update")
          msg "$item"
          update_select  
          ;;
        "Docker")
          msg "$item"
          docker_select
          ;;
          "Git")
          msg "$item"
          git_select
          ;;
        "Neovim")
          msg "$item"
          neovim_select
          ;;
        "Lazyvim")
          msg "$item"
          lazyvim_select
          ;;
        "oh-my-posh")
          msg "$item"
          ohmyposh_select
          ;;
        "Git CLI")
          msg "$item"
          gitcli_select
          ;;
        *)
            # You can add other cases here
            ;;
    esac
done
