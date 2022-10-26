variable "integrator_name" {
  description = "Name of the data integrator, recommended: ALL CAPS as this name will propagate across user name, database name, roles, and warehouse name"
  type        = string
}

variable "integrator_password" {
  description = "Snowflake password for integrator user."
  type        = string
}

variable "integrator_warehouse_config" {
  description = "Configuration for integrator's dedicated warehouse"
  type        = map(string)

  default = {
    warehouse_size       = "x-small"
    auto_suspend_seconds = "60"
  }
}

variable "reader_roles" {
  description = "Roles to be granted READ access to database where data from integrator is stored."

  type    = list(string)
  default = ["READ_ALL"]
}
