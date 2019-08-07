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

$sdd1 = <<-SCRIPT
parted /dev/sdd mklabel msdos
parted /dev/sdd mkpart primary 0% 100%
mkfs.xfs /dev/sdd1
mkdir /mnt/sdd1
if grep -Fxq "sdd1" /etc/fstab
then
  echo 'sdd1 exist in fstab'
else
  echo `blkid /dev/sdd1 | awk '{print$2}' | sed -e 's/"//g'` /mnt/sdd1   xfs   noatime,nobarrier   0   0 >> /etc/fstab
fi
if mount | grep /mnt/sdd1 > /dev/null; then
  echo "/dev/sdd1 mounted /mnt/sdd1"
  umount /mnt/sdd1
  mount /mnt/sdd1
else
  mount /mnt/sdd1
fi
SCRIPT

node1disk1 = "./tmp/node1disk1.vdi";
node1disk2 = "./tmp/node1disk2.vdi";
node1disk3 = "./tmp/node1disk3.vdi";
node2disk1 = "./tmp/node2disk1.vdi";
node2disk2 = "./tmp/node2disk2.vdi";
node2disk3 = "./tmp/node2disk3.vdi";

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
      if not File.exists?(node1disk1)
        vb.customize ['createhd', '--filename', node1disk1, '--variant', 'Fixed', '--size', 1 * 1024]
        vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 0, '--device', 1, '--type', 'hdd', '--medium', node1disk1]
      end
      if not File.exists?(node1disk2)
        vb.customize ['createhd', '--filename', node1disk2, '--variant', 'Fixed', '--size', 1 * 1024]
        vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', node1disk2]
      end
      if not File.exists?(node1disk3)
        vb.customize ['createhd', '--filename', node1disk3, '--variant', 'Fixed', '--size', 1 * 1024]
        vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 1, '--type', 'hdd', '--medium', node1disk3]
      end
    end
    node1.vm.provision "shell", inline: $sdb1
    node1.vm.provision "shell", inline: $sdc1
    node1.vm.provision "shell", inline: $sdd1
  end

  config.vm.define "node2" do |node2|
    node2.vm.network "private_network", ip: ip_node2
    node2.vm.hostname = "node2"
    node2.vm.define "node2"
    node2.vm.box_download_insecure = true
    node2.vm.box = "centos/7"
    node2.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      if not File.exists?(node2disk1)
        vb.customize ['createhd', '--filename', node2disk1, '--variant', 'Fixed', '--size', 1 * 1024]
        vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 0, '--device', 1, '--type', 'hdd', '--medium', node2disk1]
      end
      if not File.exists?(node2disk2)
        vb.customize ['createhd', '--filename', node2disk2, '--variant', 'Fixed', '--size', 1 * 1024]
        vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', node2disk2]
      end
      if not File.exists?(node2disk3)
        vb.customize ['createhd', '--filename', node2disk3, '--variant', 'Fixed', '--size', 1 * 1024]
        vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 1, '--type', 'hdd', '--medium', node2disk3]
      end
    end
    node2.vm.provision "shell", inline: $sdb1
    node2.vm.provision "shell", inline: $sdc1
    node2.vm.provision "shell", inline: $sdd1
  end

end
