variable "datacenter" {
  type        = string
  description = "vSphere Datacenter name"
  default     = "DATACENTER_BACKUP"
}

variable "datastore" {
  type        = string
  description = "vSphere Datastore name"
  default     = "datastore-rebond2"
}

variable "template" {
  type        = string
  description = "Template name for VM"
  default     = "Linux DevOps Mgmt"
}

variable "vm_name" {
  type        = string
  description = "VM Name"
  default     = "linux-management"
}

variable "vm_network" {
  type        = string
  description = "VM Network name"
  default     = "LAN DevOPS"
}

variable "vm_memory_mb" {
  type        = number
  description = "Memory in MB for the VM"
  default     = 16384
}

variable "vm_num_cpus" {
  type        = number
  description = "Number of CPUs for the VM"
  default     = 8
}

variable "vm_disk_size_gb" {
  type        = number
  description = "Disk size in GB for the VM"
  default     = 200
}

variable "folder" {
  type        = string
  description = "Folder in which VM will be created"
  default     = "Project Cloud Automation"
}

variable "pool" {
  type        = string
  description = "The name of the resource pool"
  default     = "pool1"  # Adjust the default value as necessary
}

