# Ecto Mariaex Issue Mysql 5.5 & 5.6

Minimal reproduction of not null inserts in Ecto using mariaex combined with mysql 5.5 & 5.6.

## Affected versions

The following versions of mysql server seem to produce the issue:

  * 5.5
  * 5.6

The following versions of mysql server seem to work correctly:

  * 5.7

## Usage

Run `./run-insert.sh` to run the test against the local mysql server.
Run `./reproduce.sh` to build a docker container with mysql 5.5 and run the test.

## The issue

### Setup
Table that does not allow null values:
```Mysql
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `inventory` integer NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
```

Schema that does not allow nil values:
```elixir
defmodule MariaexIssue.Product do
  use Ecto.Schema

  schema "products" do
    field :name, :string, null: false
    field :inventory, :integer, null: false
  end
end
```

### Problem

Inserts with nil (null) values still get inserted and return success.

Both following examples return a created [success] struct and insert into the database:
```elixir
%Product{} |> Repo.insert!
```
or
```elixir
%Product{name: nil, inventory: nil} |> Repo.insert!
```
