module "projectservices" {
for_each = toset(var.services)

  source = "../Modules/ProjectSetUp"

  project-id = var.project-id
  

  services    = each.key
}