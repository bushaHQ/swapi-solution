resource "aws_route53_record" "wildcard" {
    zone_id = aws_route53_zone.busha.zone_id
    name =  ".busha.com"
    type = "A"
    ttl = 300
    records = []

    lifecycle {
      prevent_destroy = true
    }
}



