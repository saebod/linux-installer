#!/bin/bash

update_select() {
    echo "Starting Update"
    sudo apt-get update
    echo "Starting Upgrade"
    sudo apt-get upgrade -y
}

python_select() {
    sudo apt install python3
}

docker_select() {
    # Remove existing Docker packages
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do 
        sudo apt-get remove -y $pkg
    done

    # Add Docker's official GPG key and repository
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

git_select() {
    sudo apt-get install git
}

gitcli_select() {
    sudo apt-get update
    sudo apt-get install -y curl

    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y gh
}

neovim_select() {
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
    rm -rf nvim.appimage
}

lazyvim_select() {
    mv ~/.config/nvim{,.bak}
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git
}

ohmyposh_select() {
    sudo apt-get install -y unzip
    curl -s https://ohmyposh.dev/install.sh | bash -s

    if ! grep -q "oh-my-posh" ~/.bashrc; then
        echo "eval \"\$(oh-my-posh init bash --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/capr4n.omp.json')\"" >> ~/.bashrc
        echo "oh-my-posh line added to .bashrc"
    else
        echo "oh-my-posh line already exists in .bashrc"
    fi
}
