variable "cluster_name" {
  default = "tfDemoCluster"
}

variable "availability_domain" {
  default = 3
}

variable "cluster_options_add_ons_is_kubernetes_dashboard_enabled" {
  default = true
}

variable "cluster_options_add_ons_is_tiller_enabled" {
  default = true
}

variable "cluster_options_kubernetes_network_config_pods_cidr" {
  default = "10.1.0.0/16"
}

variable "cluster_options_kubernetes_network_config_services_cidr" {
  default = "10.2.0.0/16"
}

variable "node_pool_initial_node_labels_key" {
  default = "key"
}

variable "node_pool_initial_node_labels_value" {
  default = "value"
}

variable "node_pool_name" {
  default = "demoNodePool"
}

variable "node_pool_node_image_name" {
  default = "Oracle-Linux-7.5"
}

variable "node_pool_node_shape" {
  default = "VM.Standard2.1"
}

variable "node_pool_quantity_per_subnet" {
  default = 0
}

variable "node_pool_ssh_public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCoqD1E/nshCFs2jvbwBg+/9S6BSZrSuA7XYhxm4zw72mOn8ez/obhyqoAzsgZL0b8O+kvOsnzP9CvYUq7NzKZ7oNZnGCxuZlssDQuI0KBx/y2Cr6XHUkspGVd0jzTTZkBv+jFuQqVmy1grHGYBkLyfSoowvIs8DQidRtfTByphZaEC0siYjy6W+/K1rdtxDREuK7M9zLXxCXQXSx7R+Bv/BItfLXzEq62luEkaYLJbP6TlZsJ0pNyMfDIRgrayeQZbWZvTn0gtKvIH4zF61fzvPpvzpi4JQx9Lo2Q5Wxs8rleHFZLyh8xzaHqaHlBiG857gKfjJ8vNSdqGYpo6Kuxl ociTest"
}

