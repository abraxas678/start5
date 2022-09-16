echo $rcpw > ~/rcpw
echo "#####################################################################"
echo "                INSTALL LSOF AND SETUP TAILSCALE"
echo "#####################################################################"
echo; sleep 2
/home/abraxas/start5/bashfuler.sh sudo apt install lsof -y
/home/abraxas/start5/bashfuler.sh curl -fsSL https://tailscale.com/install.sh | sh | tail -f -n5
sudo systemctl start tailscaled | tail -f -n5
sudo tailscale up | tail -f -n5
sudo tailscale up --ssh
sudo systemctl enable tailscaled
sudo systemctl start tailscaled
echo; echo "sudo tailscale file cp ~/.config/rclone/rclone.conf $(hostname):"
echo;
