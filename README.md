**Install**
``` shell
git clone https://github.com/SaltedFishesNG/nixos.git
cd nixos
vi ./disk-config.nix
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disk-config.nix
sudo mkdir -p /mnt/persist/home/saya/Projects/nixos
sudo nixos-generate-config --no-filesystems --show-hardware-config --root /mnt > ./hardware-configuration.nix
sudo cp -r ./* /mnt/persist/home/saya/Projects/nixos
sudo nixos-install --flake /mnt/persist/home/saya/Projects/nixos#Gamma
reboot
```

**Third-Party Assets**
- `./resource/bg.png` and `./resource/lock.png` are NOT owned by me.
   - Source of `./resource/bg.png`: <https://www.pixiv.net/artworks/137000759>
   - Source of `./resource/lock.png`: <https://www.pixiv.net/artworks/137010221>
- These images are used under fair use for non-commercial purposes.
- If you are the original artist and wish to have your work removed, please contact me.
