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
iex> %Product{} |> Repo.insert!

16:15:23.579 [debug] QUERY OK db=14.5ms queue=0.2ms
INSERT INTO `products` () VALUES () []
%MariaexIssue.Product{__meta__: #Ecto.Schema.Metadata<:loaded, "products">,
 id: 4, inventory: nil, name: nil}
```
or
```elixir
iex> %Product{name: nil, inventory: nil} |> Repo.insert!

16:15:24.058 [debug] QUERY OK db=12.8ms queue=0.1ms
INSERT INTO `products` () VALUES () []
%MariaexIssue.Product{__meta__: #Ecto.Schema.Metadata<:loaded, "products">,
 id: 4, inventory: nil, name: nil}
```
or
```elixir
iex> %Product{name: "something"} |> Repo.insert!

16:18:35.069 [debug] QUERY OK db=11.3ms
INSERT INTO `products` (`name`) VALUES (?) ["something"]
%MariaexIssue.Product{__meta__: #Ecto.Schema.Metadata<:loaded, "products">,
 id: 6, inventory: nil, name: "something"}
```
