#=== Integrator Service User
resource "snowflake_user" "integrator_user" {
  provider = snowflake

  name              = var.integrator_name
  password          = var.integrator_password
  default_role      = var.integrator_name
  default_warehouse = var.integrator_name
}


#=== Integrator Role
resource "snowflake_role" "integrator_role" {
  provider = snowflake

  name = var.integrator_name
}

resource "snowflake_role_grants" "integrator_role_grant" {
  provider = snowflake

  role_name = snowflake_role.integrator_role.name
  users     = [snowflake_user.integrator_user.name]
}


#=== Warehouse
resource "snowflake_warehouse" "integrator_warehouse" {
  provider = snowflake

  name = var.integrator_name

  warehouse_size = var.integrator_warehouse_config.warehouse_size
  auto_suspend   = var.integrator_warehouse_config.auto_suspend_seconds
}

resource "snowflake_warehouse_grant" "integrator_warehouse_grant" {
  provider = snowflake

  warehouse_name = snowflake_warehouse.integrator_warehouse.name
  privilege      = "USAGE"

  roles = [snowflake_role.integrator_role.name]
}


#=== Database
resource "snowflake_database" "integrator_database" {
  provider = snowflake
  name     = var.integrator_name
}


#=== Grants
#= read
resource "snowflake_database_grant" "integrator_db_usage" {
  provider = snowflake

  database_name = snowflake_database.integrator_database.name
  privilege     = "USAGE"
  roles         = [snowflake_role.integrator_role.name]
  shares        = []
}

resource "snowflake_schema_grant" "integrator_schema_usage" {
  provider = snowflake

  database_name = snowflake_database.integrator_database.name
  privilege     = "USAGE"
  roles         = [snowflake_role.integrator_role.name]

  on_future = true
}

resource "snowflake_table_grant" "integrator_table_read" {
  provider = snowflake

  database_name = snowflake_database.integrator_database.name
  privilege     = "SELECT"
  roles         = [snowflake_role.integrator_role.name]

  on_future = true
}

resource "snowflake_view_grant" "integrator_view_read" {
  provider = snowflake

  database_name = snowflake_database.integrator_database.name
  privilege     = "SELECT"
  roles         = [snowflake_role.integrator_role.name]

  on_future = true
}

#= write
resource "snowflake_database_grant" "integrator_db_cs_grant" {
  provider = snowflake

  database_name = snowflake_database.integrator_database.name
  privilege     = "CREATE SCHEMA"
  roles         = [snowflake_role.integrator_role.name]
  shares        = []
}

resource "snowflake_database_grant" "integrator_db_m_grant" {
  provider = snowflake

  database_name = snowflake_database.integrator_database.name
  privilege     = "MONITOR"
  roles         = [snowflake_role.integrator_role.name]
  shares        = []
}

resource "snowflake_database_grant" "integrator_db_mod_grant" {
  provider = snowflake

  database_name = snowflake_database.integrator_database.name
  privilege     = "MODIFY"
  roles         = [snowflake_role.integrator_role.name]
  shares        = []
}
