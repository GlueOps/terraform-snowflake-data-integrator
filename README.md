# terraform snowflake data integrator

## Overview

This module offers an opinionated structure for use with third-party data integrator tools, like [Hevo Data](https://hevodata.com/) and [Fivetran](https://www.fivetran.com/).

It is designed to offer isolation for third-party tools, including dedicated a dedicated warehouse and database to mitigate resource contention, restrict data access within a Snowflake account, and facilitate the usage of multiple data integration tools.

The module leverages the [Snowflake Terraform Provider](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest).

The module can be used in conjunction with [terraform-snowflake-foundation](https://github.com/GlueOps/terraform-snowflake-foundation), which creates the foundational elements for a new Snowflake account, including databases, warehouses, users, and RBAC.

Specifically, the module creates and manages the following Snowflake resources, which are dedicated to the data integrator:
 * Database
 * Warehouse
 * Service User
 * RBAC (roles and policies)
   * Role and Grants for the data integrator to land data
   * Reader Role for the data provided by the data integrator and applied to an array of roles outlined in `variables.tf`.

All resources created for use by the data integrator are given the name provided in `variables.tf` and the reader role is called `<integrator_name>_READER`.

## Usage

```hcl

module "hevo_data_integrator" {
  source = "github.com/GlueOps//terraform-snowflake-data-integrator"

  integrator_name = "HEVO"
  integrator_password = "<your-secret-password"
}
```

The following variables defaults are set in `variables.tf`.

```hcl
integrator_warehouse_config = {
  warehouse_size       = "x-small"
  auto_suspend_seconds = "60"
}

reader_roles = ["READ_ALL"]
```