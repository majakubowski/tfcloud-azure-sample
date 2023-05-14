variable "env" {
  description = "Name of environment - will be part of resources names"
  default     = "dev"
}
variable "project_prefix" {
  description = "used for resources names"
  default     = "testmj"
}
variable "github_federation_subject" {
  description = "used for github federation"
  type = object({
    account = string
    project = string
    env     = string
  })
}