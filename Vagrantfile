$sdb1 = <<-SCRIPT
parted /dev/sdb mklabel msdos
parted /dev/sdb mkpart primary 0% 100%
mkfs.xfs /dev/sdb1
mkdir /mnt/sdb1
if grep -Fxq "sdb1" /etc/fstab
then
  echo 'sdb1 exist in fstab'
else
  echo `blkid /dev/sdb1 | awk '{print$2}' | sed -e 's/"//g'` /mnt/sdb1   xfs   noatime,nobarrier   0   0 >> /etc/fstab
fi
if mount | grep /mnt/sdb1 > /dev/null; then
  echo "/dev/sdb1 mounted /mnt/sdb1"
  umount /mnt/sdb1
  mount /mnt/sdb1
else
  mount /mnt/sdb1
fi
SCRIPT

$sdc1 = <<-SCRIPT
parted /dev/sdc mklabel msdos
parted /dev/sdc mkpart primary 0% 100%
mkfs.xfs /dev/sdc1
mkdir /mnt/sdc1
if grep -Fxq "sdc1" /etc/fstab
then
  echo 'sdc1 exist in fstab'
else
  echo `blkid /dev/sdc1 | awk '{print$2}' | sed -e 's/"//g'` /mnt/sdc1   xfs   noatime,nobarrier   0   0 >> /etc/fstab
fi
if mount | grep /mnt/sdc1 > /dev/null; then
  echo "/dev/sdc1 mounted /mnt/sdc1"
  umount /mnt/sdc1
  mount /mnt/sdc1
else
  mount /mnt/sdc1
fi
SCRIPT

Node1Disk1 = "./tmp/Node1Disk1.vdi";
Node1Disk2 = "./tmp/Node1Disk2.vdi";

ip_node1 = "192.168.33.31";
ip_node2 = "192.168.33.32";
ip_node3 = "192.168.33.33";

Vagrant.configure("2") do |config|

  config.vm.define "node1" do |node1|
    node1.vm.network "private_network", ip: ip_node1
    node1.vm.hostname = "node1"
    node1.vm.define "node1"
    node1.vm.box_download_insecure = true
    node1.vm.box = "centos/7"
    node1.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      if not File.exists?(Node1Disk1)
        vb.customize ['createhd', '--filename', Node1Disk1, '--variant', 'Fixed', '--size', 1 * 1024]
        vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', Node1Disk1]
      end
      if not File.exists?(Node1Disk2)
        vb.customize ['createhd', '--filename', Node1Disk2, '--variant', 'Fixed', '--size', 1 * 1024]
        vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 1, '--type', 'hdd', '--medium', Node1Disk2]
      end
    end
    node1.vm.provision "shell", inline: $sdb1
    node1.vm.provision "shell", inline: $sdc1
  end

end
