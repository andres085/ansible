# ansible-config

## Setup en PC nueva

### 1. Clonar este repo
```bash
git clone https://github.com/andres085/ansible-config.git
cd ansible-config
```

### 2. Instalar Ansible
```bash
./ansible-run.sh
```

### 3. Correr el playbook
```bash
ansible-playbook --ask-vault-pass local.yml
```

Para correr solo ciertas tasks (ej: sin UI):
```bash
ansible-playbook --ask-vault-pass --tags 'ssh,zsh,dotfiles,stow,nvim,go,node,docker' local.yml
```

## Tags disponibles
| Tag | Descripción |
|-----|-------------|
| `ssh` | Instala claves SSH y config |
| `zsh` | Instala zsh, oh-my-zsh, powerlevel10k y autosuggestions |
| `dotfiles` | Clona el repo `.dotfiles` |
| `stow` | Instala stow y crea los symlinks de dotfiles |
| `nvim` | Instala neovim |
| `go` | Instala Go |
| `node` | Instala Node.js via n |
| `docker` | Instala Docker |
| `ghostty` | Instala Ghostty (requiere UI) |
| `floorp` | Instala Floorp browser (requiere UI) |
| `core-programs` | Instala tmux, fzf, i3, etc. |
