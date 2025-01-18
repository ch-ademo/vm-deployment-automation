provider "vsphere" {
  user           = "adam@vsphere.local"  
  password       = "YLFXK66q1DPDyU8W!"  
  vsphere_server = "192.168.7.90"        

  // If using a self-signed certificate
  allow_unverified_ssl = true
}

// Datacenter resource
data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

// Datastore resource
data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

// Network resource
data "vsphere_network" "network" {
  name          = var.vm_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

// Template resource
data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.dc.id
}

// Fetch default resource pool
data "vsphere_resource_pool" "default_pool" {
  datacenter_id = data.vsphere_datacenter.dc.id
  name          = "pool1"  // Default resource pool name in most vSphere environments
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_resource_pool.default_pool.id  // Updated to use the resource pool from the data source
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_num_cpus
  memory   = var.vm_memory_mb
  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = var.vm_disk_size_gb
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = var.vm_name
        domain = "acme.local"
      }

      network_interface {
        ipv4_address = "192.168.200.50"
        ipv4_netmask = "24"
        dns_server_list = ["8.8.8.8"]
      }

      ipv4_gateway = "192.168.200.1"
    }
  }
}
