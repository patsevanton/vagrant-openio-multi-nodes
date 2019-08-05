$filrewall_selinux = <<-SCRIPT
echo "Disable Firewall"
systemctl stop firewalld && systemctl disable firewalld
echo "Disable Selinux"
setenforce 0
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
SCRIPT

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
        file_to_disk = './tmp/large_disk.vdi'
        unless File.exist?(file_to_disk)
          vb.customize ['createhd', '--filename', file_to_disk, '--size', 500] # size is in MB
        end
        vb.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]      
      end
      node1.vm.provision "shell", inline: $filrewall_selinux
    end
  
    # config.vm.define "node2" do |node2|
    #   node2.vm.network "private_network", ip: ip_node2
    #   node2.vm.hostname = "node2"
    #   node2.vm.define "node2"
    #   node2.vm.box_download_insecure = true
    #   node2.vm.box = "centos/7"
    #   node2.vm.provider "virtualbox" do |vb|
    #     vb.memory = "2048"
    #   end
    #   node2.vm.provision "shell", inline: $filrewall_selinux
    # end

    # config.vm.define "node3" do |node3|
    #   node3.vm.network "private_network", ip: ip_node3
    #   node3.vm.hostname = "node3"
    #   node3.vm.define "node3"
    #   node3.vm.box_download_insecure = true
    #   node3.vm.box = "centos/7"
    #   node3.vm.provider "virtualbox" do |vb|
    #     vb.memory = "2048"
    #   end
    #   node3.vm.provision "shell", inline: $filrewall_selinux
    # end

end
