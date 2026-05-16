output "kanboard_ssh_vm" {
  description = "Commande SSH vers la vm kanboard"
  value       = "ssh -t -i ~/.ssh/github_deploy_key admin@${try(proxmox_virtual_environment_vm.kanboard.ipv4_addresses[1][0], "not-ready")}"
}