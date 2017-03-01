#!/bin/bash -e

mix ecto.create -r MariaexIssue.Repo
mix ecto.load -r MariaexIssue.Repo

mix run
