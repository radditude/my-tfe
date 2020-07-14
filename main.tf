provider "tfe" {
  hostname = var.hostname
  version  = "<= 0.9.1"
}

resource "tfe_organization" "boring-test-org" {
  name  = var.organization
  email = var.email
}

resource "tfe_oauth_client" "boring-oauth-client" {
  organization     = var.organization
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.oauth_token
  service_provider = "github"
}

resource "tfe_workspace" "boring_workspaces" {
  count          = var.workspace_count
  organization   = var.organization
  name           = "boring-workspace-${count.index}"
  auto_apply     = true
  queue_all_runs = true

  vcs_repo {
    identifier     = var.repo
    branch         = var.branch
    oauth_token_id = tfe_oauth_client.boring-oauth-client.oauth_token_id
  }
}

resource "tfe_team" "boring_team" {
  name         = "boring-team"
  organization = var.organization
}

resource "tfe_team_members" "boring_team_members" {
  team_id   = tfe_team.boring_team.id
  usernames = var.team_members
}

resource "tfe_team_member" "boring_team_members" {
  for_each = toset(var.team_members)

  team_id  = tfe_team.boring_team.id
  username = each.key
}
