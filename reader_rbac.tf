resource "snowflake_role" "data_integrator_reader_role" {
  provider = snowflake

  name = "${var.integrator_name}_READER"
}

resource "snowflake_role_grants" "grant_data_integrator_reader_role" {
  provider = snowflake

  role_name = snowflake_role.data_integrator_reader_role.name
  roles     = var.reader_roles

}

resource "snowflake_database_grant" "read_integrator_database" {
  provider = snowflake

  database_name = snowflake_database.integrator_database.name
  privilege     = "USAGE"
  roles         = [snowflake_role.data_integrator_reader_role.name]
  shares        = []
}

resource "snowflake_schema_grant" "read_all_schemas" {
  provider = snowflake

  database_name = snowflake_database.integrator_database.name
  privilege     = "USAGE"
  roles         = [snowflake_role.data_integrator_reader_role.name]

  on_future = true
}

resource "snowflake_table_grant" "read_all_table_select_grant" {
  provider = snowflake

  database_name = snowflake_database.integrator_database.name
  privilege     = "SELECT"
  roles         = [snowflake_role.data_integrator_reader_role.name]

  on_future = true
}

resource "snowflake_view_grant" "read_all_view_select_grant" {
  provider = snowflake

  database_name = snowflake_database.integrator_database.name
  privilege     = "SELECT"
  roles         = [snowflake_role.data_integrator_reader_role.name]

  on_future = true
}
