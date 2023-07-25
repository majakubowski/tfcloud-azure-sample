module "af" {
  source         = "./SampleFunctionApp"
  project_prefix = var.project_prefix
  env            = var.env
}

module "github_federated_identity" {
  source                     = "./GithubFederatedIdentity"
  managed_identity_name      = "id-${var.project_prefix}-github-${var.env}"
  federated_identity_subject = "repo:${var.github_federation_subject.account}/${var.github_federation_subject.project}:environment:${var.github_federation_subject.env}"

  resource_group_name = module.af.resource_group_name
  
}
