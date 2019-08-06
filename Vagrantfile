VAGRANTFILE_API_VERSION = "2"

disk = './secondDisk.vdi' 
BOX_NAME="test"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.define :master do |master|
        master.vm.box = "centos/7"
        # master.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box"
        master.vm.provider "virtualbox" do |v|
          v.customize ["modifyvm", :id, "--memory", "2196"]
          v.name = BOX_NAME
        end
        master.vm.network :private_network, ip: "192.168.33.10"
        master.vm.hostname = BOX_NAME
    end

    config.vm.synced_folder(".", "/vagrant",
        :owner => "vagrant",
        :group => "vagrant",
        :mount_options => ['dmode=777','fmode=777']
    )

    # create the second disk and attach it
    config.vm.provider "virtualbox" do |vb|
        unless File.exist?(disk)
            vb.customize ['createhd', '--filename', disk, '--variant', 'Fixed', '--size', 1 * 1024]
        end

        vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk]
    end

    config.vm.provision :shell, path: "bootstrap.sh" 
    # config.vm.provision "file", source: "bootstrap.sh", destination: "/home/vagrant/bootstrap.sh" 
    config.vm.provision "shell" do |shell|
        shell.inline = "sudo /vagrant/bootstrap.sh"  
    end
end