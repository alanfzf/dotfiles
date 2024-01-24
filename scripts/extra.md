# Setup LightDm to use xrandr

> move the xrandr script to be globally available

```bash
sudo mv script.sh /usr/local/bin/xrandr-script.sh
```

> edit the lightdm config

```bash
sudoedit /etc/lightdm/lightdm.conf
```

```conf
[Seat:*]
display-setup-script=/usr/local/bin/xrandr-script.sh
```
