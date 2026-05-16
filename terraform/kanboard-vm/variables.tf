variable "endpoint" {
  type = string
}

variable "api_token" {
  type      = string
  sensitive = true
}

variable "ssh_public_key_path" {
  type = string
}

variable "kanboard_ip" {
  type = string
}

variable "network_gateway" {
  type = string
}
