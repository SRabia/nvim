# setup
Took this setup from [primeagen](https://github.com/ThePrimeagen/init.lua) 
did some small modifications and added some more plugins.


# notes
run in nvim `:checkhealth mason` if you run into trouble.

mason will require node > 16, I used [nvm](https://github.com/nvm-sh/nvm)
  to control the versions. install a version with 
  ```
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
  nvm install node 16.3.0
  nvm use 16
  ```
don't forget to copy that packer thing!!!
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
 ```
