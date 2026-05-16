module "projectservices" {
# for_each = toset(var.services)

  source = "../Modules/ProjectSetUp"

  project= "project-06cede75-fb8e-4bfb-984"
  


  

  services    = "compute.googleapis.com"
}