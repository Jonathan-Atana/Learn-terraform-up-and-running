output "alb-dns-name" {
  description = "The domain name of the load balancer"
  value = module.webserver_cluster.alb-dns-name
}