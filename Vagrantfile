$filrewall_selinux = <<-SCRIPT
echo "Disable Firewall"
systemctl stop firewalld && systemctl disable firewalld
echo "Disable Selinux"
setenforce 0
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
SCRIPT

$sdb1 = <<-SCRIPT
parted /dev/sdb mklabel msdos
parted /dev/sdb mkpart primary 0% 100%
mkfs.xfs /dev/sdb1
mkdir /mnt/data1
if grep -Fxq "sdb1" /etc/fstab
then
  echo 'sdb1 exist in fstab'
else
  echo `blkid /dev/sdb1 | awk '{print$2}' | sed -e 's/"//g'` /mnt/data1   xfs   noatime,nobarrier   0   0 >> /etc/fstab
fi
if mount | grep /mnt/data1 > /dev/null; then
  echo "/dev/sdb1 mounted /mnt/data1"
  umount /mnt/data1
  mount /mnt/data1
else
  mount /mnt/data1
fi
SCRIPT

$sdc1 = <<-SCRIPT
parted /dev/sdc mklabel msdos
parted /dev/sdc mkpart primary 0% 100%
mkfs.xfs /dev/sdc1
mkdir /mnt/data2
if grep -Fxq "sdc1" /etc/fstab
then
  echo 'sdc1 exist in fstab'
else
  echo `blkid /dev/sdc1 | awk '{print$2}' | sed -e 's/"//g'` /mnt/data2   xfs   noatime,nobarrier   0   0 >> /etc/fstab
fi
if mount | grep /mnt/data2 > /dev/null; then
  echo "/dev/sdc1 mounted /mnt/data2"
  umount /mnt/data2
  mount /mnt/data2
else
  mount /mnt/data2
fi
SCRIPT

$sdd1 = <<-SCRIPT
parted /dev/sdd mklabel msdos
parted /dev/sdd mkpart primary 0% 100%
mkfs.xfs /dev/sdd1
mkdir /mnt/metadata1
if grep -Fxq "sdd1" /etc/fstab
then
  echo 'sdd1 exist in fstab'
else
  echo `blkid /dev/sdd1 | awk '{print$2}' | sed -e 's/"//g'` /mnt/metadata1   xfs   noatime,nobarrier   0   0 >> /etc/fstab
fi
if mount | grep /mnt/metadata1 > /dev/null; then
  echo "/dev/sdd1 mounted /mnt/metadata1"
  umount /mnt/metadata1
  mount /mnt/metadata1
else
  mount /mnt/metadata1
fi
SCRIPT

node1disk1 = "./tmp/node1disk1.vdi";
node1disk2 = "./tmp/node1disk2.vdi";
node1disk3 = "./tmp/node1disk3.vdi";
node2disk1 = "./tmp/node2disk1.vdi";
node2disk2 = "./tmp/node2disk2.vdi";
node2disk3 = "./tmp/node2disk3.vdi";
node3disk1 = "./tmp/node3disk1.vdi";
node3disk2 = "./tmp/node3disk2.vdi";
node3disk3 = "./tmp/node3disk3.vdi";

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
    node1.vm.provision "shell", inline: $filrewall_selinux
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
    node2.vm.provision "shell", inline: $filrewall_selinux
  end

  config.vm.define "node3" do |node3|
    node3.vm.network "private_network", ip: ip_node3
    node3.vm.hostname = "node3"
    node3.vm.define "node3"
    node3.vm.box_download_insecure = true
    node3.vm.box = "centos/7"
    node3.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      if not File.exists?(node3disk1)
        vb.customize ['createhd', '--filename', node3disk1, '--variant', 'Fixed', '--size', 1 * 1024]
        vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 0, '--device', 1, '--type', 'hdd', '--medium', node3disk1]
      end
      if not File.exists?(node3disk2)
        vb.customize ['createhd', '--filename', node3disk2, '--variant', 'Fixed', '--size', 1 * 1024]
        vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', node3disk2]
      end
      if not File.exists?(node3disk3)
        vb.customize ['createhd', '--filename', node3disk3, '--variant', 'Fixed', '--size', 1 * 1024]
        vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 1, '--type', 'hdd', '--medium', node3disk3]
      end
    end
    node3.vm.provision "shell", inline: $sdb1
    node3.vm.provision "shell", inline: $sdc1
    node3.vm.provision "shell", inline: $sdd1
    node3.vm.provision "shell", inline: $filrewall_selinux
  end

end
