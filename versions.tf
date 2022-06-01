terraform {
  cloud {
    organization = "vyrnn"

    workspaces {
      name = "zeraph-control"
    }
  }
}