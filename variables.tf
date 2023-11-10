# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "suffix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "amin14"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "France Central"
}

variable "admin_user" {
  description = "SSH User Admin"
  default     = "bns"
}

variable "public_key" {
  description = "Public key. This value is generated during deploy runtime and outputed into bunnyshell output"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6rMJu5mDnBeOjkKYwlqaHotqiC+4WiGF8RjdSicuVUlQ411rxbsEJPTcZ+FVQt0TKTMWlytUAIdzcpyo7lM+Q1y6ch/JxZcdYpIqSthfA8KaVPNbLXDKOXIbXzA864f9rb6c/bTeXUS3f3Y6thgSnABT2OTy9MXpt5iAZbi8qqmCizvpSA5hJidwENy3DQNe+MJMudZtYDNvBVovWdkSe8OKWtj+fBms/BRCPQuw0LdVvJNEYsdqwDeN78fKUMn/i44h4f77bhqnCt+w6+leRd/Z7aO1LSWikOFzkhDb5q1nENEEx5iEqrkdTL5ZkJ+h8JS3PEBlN4RhRDes6A0+ciDVUwTv8h2PTslAXALLULs3plS6KDN90EMA3PhkL2YADx57y2y9rvTBJTbBpJcXGO7LK8NLtcR+CCjgzbADLym4azbsWyCg7eTOL7TN3WnPIeYkSimI+HefrRDU7Fqj5gwyHbYtrZrnTCtykp+lm+KSP7TqfdciGE7mil6YpF/bFtQhPAufcT25xI2WM+ES+m8N/ScbxbMg37CxKj/JthxVA+6kDKjXE05CAB9T1oCkcgztbizt0FKnvdAAV5KAX7yCry/CI9esR9QQ8EzO5woATtFSE7OuJlx9gELDyukySmK7sUGQzTQBozgRhc4WvfcSulITa2x+oh8zUFQE8gQ== hello@machine.local"
}

variable "private_key_file_name" {
  description = "Private key. This value is generated during deploy runtime and outputed into bunnyshell output"
  default     = "id_rsa"
}