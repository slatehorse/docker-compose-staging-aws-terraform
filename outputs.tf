output "bastion_command" {
  value = "ssh ${module.bastion.ssh_user}@${aws_route53_record.bastion_host_alias.fqdn}"
}