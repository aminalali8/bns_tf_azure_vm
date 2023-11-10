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
}

variable "private_key_file_name" {
  description = "Private key. This value is generated during deploy runtime and outputed into bunnyshell output"
  default     = "id_rsa"
}