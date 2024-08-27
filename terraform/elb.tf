module "elb" {
  source = "terraform-aws-module/elb.aws"

  name = busha-elb


  subnets =  module.vpc.subnet_ids
  security_group_id = module.vpc_security_group_ids
  

  listener = [
    {
        instance_port = 80
        protocol = "http"
        lb_port = 80
        lb_protocol = "http"
        ssl_certificate_id = (data.busa_lb)
    },
    {
        instance_port = 443
        protocol = "https"
        lb_port = 443
        lb_protocol = "http"
        ssl_certificate_id = (data.busa_lb)
    }
  ]

    health_check = {
        target = http/80
        interval = 30
        healthy_threshold = 2
        unhealthy_threshould = 2
        timeout = 5
    }

}