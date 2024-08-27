module "eks" {
  source = "terraform-aws-module/eks/aws"
  version = ""

  cluster_name = ""
  cluster_version = ""

  vpc_id = ""
  subnet_ids = ""

  eks_managed_nodegroups_default {
    amitype = ""

    attach_cluster_primary_security_group = ""

    create_security_group = false
  }

  eks_manage_groups {
    one = {
        name = "busha_nodes"

        instance_type = ["t3_medium"]

        min_size = 2
        max_size = 3
        desired_size = 2

        pre_bootstrap_user_data = <<-EOF
        echo 'foobar'
        EOF

        vpc_security_group_ids = [
            module.vpc_security_group_ids
        ]

        
        lifecycle = {
            prevent_destroy = true
        }
    }

    two = {
        name = "busha_node2"

        instance_type = ["t3_medium"]

        min_size = 2
        max_size = 3
        desired_size = 2

        pre_bootstrap_user_data = <<-EOF
        echo 'foobar'
        EOF

        vpc_security_group_ids = [

        ]

        
        lifecycle = {
            prevent_destroy = true
        }
    }
  }



}